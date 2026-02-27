"""
dash-public weekly refresh job

Reads blob metadata from Azure Blob Storage, loads it into Postgres,
runs SQL transformations, and exports CSV files to the shared data volume.

Adapted from:
  - dash/read_blob_chorus.py   (blob reading + Postgres loading)
  - dash-public/export_dash_src.sh (SQL queries + CSV export)

Environment variables required:
  PILOT_CONN_STR  - Azure Storage connection string
  PGHOST          - Postgres host  (default: localhost)
  PGPORT          - Postgres port  (default: 5432)
  PGUSER          - Postgres user  (default: postgres)
  DATA_DIR        - Output directory for CSVs (default: /app/data)
"""

import os
import subprocess
import sys
from datetime import datetime, timezone

from azure.storage.blob import BlobServiceClient

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

BLOB_CONN_STR = os.environ["PILOT_CONN_STR"]

PGHOST = os.environ.get("PGHOST", "localhost")
PGPORT = os.environ.get("PGPORT", "5432")
PGUSER = os.environ.get("PGUSER", "postgres")
DATA_DIR = os.environ.get("DATA_DIR", "/app/data")

SITE_CONTAINERS = [
    "columbia", "duke", "emory", "mayo", "mgh", "mit",
    "nationwide", "pitts", "seattle", "tuft", "ucla",
    "ucsf", "uflorida", "uva",
]

# Map raw container names → canonical site names used by OMOP DBs
SITE_DB_MAP = {
    "tuft": "tufts",
    "pitts": "pittsburgh",
    "uflorida": "florida",
    "uva": "virginia",
}

BLOB_COLUMN_LIST = ["name", "container", "size", "last_modified", "creation_time"]

# The 14 OMOP site databases to query for person/note counts
OMOP_SITE_DBS = [
    "columbia", "duke", "emory", "mgh", "mit", "mayo",
    "nationwide", "ucla", "ucsf", "florida", "pittsburgh",
    "seattle", "virginia", "tufts",
]

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def run(cmd, **kwargs):
    """Run a shell command, raising on failure."""
    print(f"  > {cmd if isinstance(cmd, str) else ' '.join(cmd)}")
    return subprocess.run(cmd, check=True, **kwargs)


def psql(database, sql=None, file=None, copy_to=None):
    """Execute a psql command against *database*."""
    base = ["psql", "-h", PGHOST, "-p", PGPORT, "-U", PGUSER, "-d", database]
    if file:
        run(base + ["-f", file])
    elif copy_to:
        run(base + ["-c", copy_to])
    elif sql:
        run(base + ["-c", sql])


def psql_scalar(database, sql):
    """Return a single scalar value from a psql query."""
    base = ["psql", "-h", PGHOST, "-p", PGPORT, "-U", PGUSER,
            "-d", database, "-qtAX", "-c", sql]
    result = subprocess.run(base, check=True, capture_output=True, text=True)
    return result.stdout.strip()


# ---------------------------------------------------------------------------
# Stage 1 – Read blob metadata from Azure and load into Postgres
# ---------------------------------------------------------------------------

def stage_read_blobs():
    print("\n=== Stage 1: Reading blob metadata from Azure Blob Storage ===")
    blob_svc = BlobServiceClient.from_connection_string(conn_str=BLOB_CONN_STR)

    # Re-create the raw metadata table
    psql("ohdsi", sql="DROP TABLE IF EXISTS public.all_metadata;")
    psql("ohdsi", sql="""
        CREATE TABLE public.all_metadata(
            file_id integer,
            name text,
            container text,
            last_modified text,
            size text,
            creation_time text
        );
    """)

    global_cnt = 0
    tmp_csv = "/tmp/blob_metadata.csv"

    for site_name in SITE_CONTAINERS:
        print(f"  Listing blobs in container: {site_name}")
        site_cc = blob_svc.get_container_client(site_name)
        blobs = site_cc.list_blobs()

        row_cnt = 0
        with open(tmp_csv, "w") as f:
            for blob in blobs:
                if row_cnt == 0:
                    # Write header once per site batch
                    header = "id"
                    for key in blob.keys():
                        if key in BLOB_COLUMN_LIST:
                            header += f",{key}"
                    f.write(header + "\n")

                line = str(global_cnt)
                for key in blob.keys():
                    if key in BLOB_COLUMN_LIST:
                        line += f",{blob[key]}"
                f.write(line + "\n")

                global_cnt += 1
                row_cnt += 1
                if row_cnt % 100_000 == 0:
                    print(f"    {row_cnt} blobs parsed...")

        # Load CSV into Postgres
        if row_cnt > 0:
            copy_cmd = (
                f"tail -q -n +2 {tmp_csv} | "
                f"psql -h {PGHOST} -p {PGPORT} -U {PGUSER} -d ohdsi "
                f"-c \"\\copy public.all_metadata FROM STDIN CSV DELIMITER E','\""
            )
            run(["bash", "-c", copy_cmd])
        print(f"  {site_name}: {row_cnt} blobs loaded ({global_cnt} total)")

    os.remove(tmp_csv) if os.path.exists(tmp_csv) else None
    print(f"  Total blobs loaded: {global_cnt}")


# ---------------------------------------------------------------------------
# Stage 2 – Run SQL transformations
# ---------------------------------------------------------------------------

def stage_sql_transforms():
    print("\n=== Stage 2: Running SQL transformations ===")

    # Create all_metadata_expanded + by_site_metadata  (from dash/prep_for_export.sql logic)
    # This is used by get_allfiles_grouped.sql
    print("  Running prep_for_export.sql on ohdsi...")
    psql("ohdsi", file="/app/prep_for_export.sql")

    # Create allfiles_grouped (the main heatmap source)
    print("  Running get_allfiles_grouped.sql on ohdsi...")
    psql("ohdsi", file="/app/get_allfiles_grouped.sql")

    # Create condition summary (on merge DB)
    print("  Running get_condition_summary.sql on merge...")
    psql("merge", file="/app/get_condition_summary.sql")

    # Create demographics (on merge DB)
    print("  Running get_demo_dash.sql on merge...")
    psql("merge", file="/app/get_demo_dash.sql")


# ---------------------------------------------------------------------------
# Stage 3 – Export CSVs
# ---------------------------------------------------------------------------

def stage_export_csvs():
    print("\n=== Stage 3: Exporting CSVs ===")
    os.makedirs(DATA_DIR, exist_ok=True)

    # allfiles_grouped.csv
    psql("ohdsi", copy_to=f"\\copy public.allfiles_grouped TO '{DATA_DIR}/allfiles_grouped.csv' CSV HEADER")

    # demograph.csv
    psql("merge", copy_to=f"\\copy public.demo_dash TO '{DATA_DIR}/demograph.csv' CSV HEADER")

    # source_key.csv
    psql("merge", copy_to=f"\\copy persist.source_key TO '{DATA_DIR}/source_key.csv' CSV HEADER")

    # chorus_conditions.csv
    psql("merge", copy_to=f"\\copy public.domain_summary_condition TO '{DATA_DIR}/chorus_conditions.csv' CSV HEADER")

    # omop_counts.csv  – per-site person and note counts
    print("  Collecting per-site OMOP counts...")
    omop_path = os.path.join(DATA_DIR, "omop_counts.csv")
    with open(omop_path, "w") as f:
        f.write("site, count_person, count_note\n")
        for site_db in OMOP_SITE_DBS:
            try:
                count_person = psql_scalar(site_db, "SELECT count(*) FROM omopcdm.person;")
                count_note = psql_scalar(site_db, "SELECT count(distinct(person_id)) FROM omopcdm.note;")
                f.write(f"{site_db}, {count_person}, {count_note}\n")
                print(f"    {site_db}: persons={count_person}, notes={count_note}")
            except subprocess.CalledProcessError as e:
                print(f"    WARNING: could not query {site_db}: {e}", file=sys.stderr)

    print(f"  CSVs written to {DATA_DIR}/")


# ---------------------------------------------------------------------------
# Stage 4 – Write refresh timestamp
# ---------------------------------------------------------------------------

def stage_write_timestamp():
    timestamp = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    ts_path = os.path.join(DATA_DIR, "last_updated.txt")
    with open(ts_path, "w") as f:
        f.write(timestamp)
    print(f"\n=== Data refresh completed at {timestamp} ===")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    print("=" * 60)
    print("  dash-public weekly refresh job")
    print("=" * 60)

    stage_read_blobs()
    stage_sql_transforms()
    stage_export_csvs()
    stage_write_timestamp()

    print("Done.")
