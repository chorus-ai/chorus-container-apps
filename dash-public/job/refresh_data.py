"""
dash-public weekly refresh job

Scans metadata from the mounted CHoRUS file share, loads it into Postgres,
runs SQL transformations, and exports CSV files to the shared data volume.

Adapted from:
    - dash/read_blob_chorus.py   (metadata loading + Postgres staging)
  - dash-public/export_dash_src.sh (SQL queries + CSV export)

Environment variables required:
    PILOT_ROOT      - Root of CHoRUS file share to scan (default: /choruspilot)
  PGHOST          - Postgres host  (default: localhost)
  PGPORT          - Postgres port  (default: 5432)
  PGUSER          - Postgres user  (default: postgres)
  DATA_DIR        - Output directory for CSVs (default: /app/data)
"""

import csv
import os
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path
from tempfile import NamedTemporaryFile

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

PILOT_ROOT = os.environ.get("PILOT_ROOT", "/choruspilot")

PGHOST = os.environ.get("PGHOST", "localhost")
PGPORT = os.environ.get("PGPORT", "5432")
PGUSER = os.environ.get("PGUSER", "postgres")
DATA_DIR = os.environ.get("DATA_DIR", "/app/data")

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
# Stage 1 – Scan file share metadata and load into Postgres
# ---------------------------------------------------------------------------

def stage_scan_fileshare():
    print("\n=== Stage 1: Scanning file metadata from CHoRUS file share ===")
    root = Path(PILOT_ROOT)

    if not root.exists() or not root.is_dir():
        raise FileNotFoundError(f"PILOT_ROOT does not exist or is not a directory: {PILOT_ROOT}")

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

    total_files = 0
    tmp_csv = None
    root_str = str(root)

    def scan_directory(dir_path, rel_path=""):
        """Recursively scan directory using os.scandir for maximum performance."""
        nonlocal total_files

        # Extract container from relative path
        if rel_path:
            first_sep = rel_path.find(os.sep)
            if first_sep > 0:
                container = rel_path[:first_sep]
                name_prefix = rel_path[first_sep+1:] + os.sep
            elif first_sep == 0:
                # Path starts with separator
                next_sep = rel_path.find(os.sep, 1)
                if next_sep > 0:
                    container = rel_path[1:next_sep]
                    name_prefix = rel_path[next_sep+1:] + os.sep if next_sep < len(rel_path) - 1 else ""
                else:
                    container = rel_path[1:]
                    name_prefix = ""
            else:
                container = rel_path
                name_prefix = ""
        else:
            container = "unknown"
            name_prefix = ""

        try:
            with os.scandir(dir_path) as entries:
                for entry in entries:
                    try:
                        # Use cached stat from DirEntry
                        is_dir = entry.is_dir(follow_symlinks=False)

                        if is_dir:
                            # Recurse into subdirectory
                            new_rel = os.path.join(rel_path, entry.name) if rel_path else entry.name
                            scan_directory(entry.path, new_rel)
                        else:
                            # Process file
                            stat_info = entry.stat(follow_symlinks=False)

                            # Build file name
                            name = name_prefix + entry.name if name_prefix else entry.name

                            # Format timestamp
                            last_modified = datetime.fromtimestamp(stat_info.st_mtime, timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

                            writer.writerow([
                                total_files,
                                name,
                                container,
                                last_modified,
                                str(stat_info.st_size),
                                last_modified,  # creation_time = last_modified on Linux
                            ])
                            total_files += 1

                            if total_files % 100_000 == 0:
                                print(f"    {total_files} files scanned...")

                    except (PermissionError, OSError) as e:
                        print(f"    WARNING: Cannot access {entry.path}: {e}", file=sys.stderr)
                        continue

        except (PermissionError, OSError) as e:
            print(f"    WARNING: Cannot scan directory {dir_path}: {e}", file=sys.stderr)

    try:
        with NamedTemporaryFile(mode="w", newline="", suffix=".csv", delete=False) as tmp:
            tmp_csv = tmp.name
            writer = csv.writer(tmp)
            writer.writerow(["file_id", "name", "container", "last_modified", "size", "creation_time"])

            # Start recursive scan from root
            scan_directory(root_str)

        psql("ohdsi", copy_to=f"\\copy public.all_metadata FROM '{tmp_csv}' CSV HEADER")
    finally:
        if tmp_csv and os.path.exists(tmp_csv):
            os.remove(tmp_csv)

    print(f"  Total files loaded: {total_files}")


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

    stage_scan_fileshare()
    stage_sql_transforms()
    stage_export_csvs()
    stage_write_timestamp()

    print("Done.")
