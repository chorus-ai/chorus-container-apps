"""
dash-public weekly refresh job

Scans metadata from all Azure File Shares in a storage account using Azure SDK,
loads it into Postgres, runs SQL transformations, and exports CSV files.

Each site (tufts, mgh, columbia, etc.) has its own file share within the storage account.
This script scans all file shares and treats each share name as a "container".

Adapted from:
    - dash/read_blob_chorus.py   (metadata loading + Postgres staging)
  - dash-public/export_dash_src.sh (SQL queries + CSV export)

Environment variables required:
  AZURE_STORAGE_ACCOUNT      - Azure storage account name (e.g., "choruspilot")
  AZURE_STORAGE_KEY          - Azure storage account key (or use AZURE_STORAGE_CONNECTION_STRING)
  AZURE_FILE_SHARE_PREFIX    - Optional: Only scan shares starting with this prefix (default: scan all)
  MAX_WORKERS                - Number of parallel workers (default: 8)
  BATCH_SIZE                 - Files per batch for memory management (default: 10000)
  PGHOST                     - Postgres host  (default: localhost)
  PGPORT                     - Postgres port  (default: 5432)
  PGUSER                     - Postgres user  (default: postgres)
  DATA_DIR                   - Output directory for CSVs (default: /app/data)
"""

import csv
import os
import subprocess
import sys
from datetime import datetime, timezone
from tempfile import NamedTemporaryFile
from concurrent.futures import ThreadPoolExecutor
from queue import Queue
from azure.storage.fileshare import ShareServiceClient
from azure.storage.blob import BlobServiceClient

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# Azure Storage credentials
AZURE_STORAGE_ACCOUNT = os.environ.get("AZURE_STORAGE_ACCOUNT")
AZURE_STORAGE_KEY = os.environ.get("AZURE_STORAGE_KEY")
AZURE_STORAGE_ACCOUNT_LANDING = os.environ.get("AZURE_STORAGE_ACCOUNT_LANDING")
AZURE_STORAGE_KEY_LANDING = os.environ.get("AZURE_STORAGE_KEY_LANDING")

# Optional: Filter file shares by prefix (e.g., only scan shares starting with "site-")
# If not set, scans all file shares in the storage account
AZURE_FILE_SHARE_PREFIX = os.environ.get("AZURE_FILE_SHARE_PREFIX", "")

# Performance tuning
MAX_WORKERS = int(os.environ.get("MAX_WORKERS", "8"))  # For 4 vCPU, 8-12 threads is optimal
BATCH_SIZE = int(os.environ.get("BATCH_SIZE", "10000"))  # Flush to CSV every N files

# Postgres configuration
PGHOST = os.environ.get("PGHOST", "localhost")
PGPORT = os.environ.get("PGPORT", "5432")
PGUSER = os.environ.get("PGUSER", "postgres")
DATA_DIR = os.environ.get("DATA_DIR", "/app/data")
DELIV_DIR = os.environ.get("DELIV_DIR", "/app/delivery")

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

def stage_scan_fileshare(storage):
    print(f"\n=== Stage 1: Scanning file metadata from '{storage}' ===")
    print(f"  Performance settings: MAX_WORKERS={MAX_WORKERS}, BATCH_SIZE={BATCH_SIZE:,}")

    if storage == "choruspilot":
        account_url = f"https://{AZURE_STORAGE_ACCOUNT}.file.core.windows.net"
        share_service_client = ShareServiceClient(account_url=account_url, credential=AZURE_STORAGE_KEY)
        database = "ohdsi"
        use_blobs = False
    else:
        account_url = f"https://{AZURE_STORAGE_ACCOUNT_LANDING}.blob.core.windows.net"
        blob_service_client = BlobServiceClient(account_url=account_url, credential=AZURE_STORAGE_KEY_LANDING)
        database = "postgres"
        use_blobs = True

    # Re-create the raw metadata table
    psql(database, sql="DROP TABLE IF EXISTS public.all_metadata;")
    psql(database, sql="""
        CREATE TABLE public.all_metadata(
            file_id integer,
            name text,
            container text,
            last_modified text,
            size text,
            creation_time text
        );
    """)

    result_queue = Queue(maxsize=MAX_WORKERS * 2)
    total_files = 0
    tmp_csv = None

    # --- File share helpers ---

    def process_item_to_record(item, directory_path, share_name):
        if directory_path:
            relative_name = f"{directory_path}/{item['name']}"
        else:
            relative_name = item['name']

        file_size = item.get('size', 0)

        last_modified_prop = item.get('last_modified')
        if last_modified_prop:
            last_modified = last_modified_prop.strftime("%Y-%m-%dT%H:%M:%SZ") if hasattr(last_modified_prop, 'strftime') else str(last_modified_prop)
        else:
            last_modified = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

        creation_time_prop = item.get('creation_time')
        if creation_time_prop:
            creation_time = creation_time_prop.strftime("%Y-%m-%dT%H:%M:%SZ") if hasattr(creation_time_prop, 'strftime') else str(creation_time_prop)
        else:
            creation_time = last_modified

        return {
            'name': relative_name,
            'container': share_name,
            'last_modified': last_modified,
            'size': str(file_size),
            'creation_time': creation_time,
        }

    def scan_directory_recursive(share_client, directory_path, share_name, batch_buffer):
        try:
            dir_client = share_client.get_directory_client(directory_path) if directory_path else share_client.get_directory_client("")
            subdirs = []
            for item in dir_client.list_directories_and_files():
                try:
                    if item['is_directory']:
                        full_path = f"{directory_path}/{item['name']}" if directory_path else item['name']
                        subdirs.append(full_path)
                    else:
                        batch_buffer.append(process_item_to_record(item, directory_path, share_name))
                        if len(batch_buffer) >= BATCH_SIZE:
                            result_queue.put(('batch', list(batch_buffer), share_name))
                            batch_buffer.clear()
                except Exception as e:
                    print(f"    WARNING [{share_name}]: Cannot access item in {directory_path}: {e}", file=sys.stderr)
            for subdir_path in subdirs:
                scan_directory_recursive(share_client, subdir_path, share_name, batch_buffer)
        except Exception as e:
            print(f"    WARNING [{share_name}]: Cannot scan directory {directory_path}: {e}", file=sys.stderr)

    def process_share_worker(share_name):
        batch_buffer = []
        try:
            share_client = share_service_client.get_share_client(share_name)
            scan_directory_recursive(share_client, "", share_name, batch_buffer)
            if batch_buffer:
                result_queue.put(('batch', batch_buffer, share_name))
            result_queue.put(('done', share_name, None))
        except Exception as e:
            print(f"    ERROR processing file share {share_name}: {e}", file=sys.stderr)
            result_queue.put(('error', share_name, str(e)))

    # --- Blob storage helpers ---

    def process_blob_container_worker(container_name):
        batch_buffer = []
        try:
            container_client = blob_service_client.get_container_client(container_name)
            for blob in container_client.list_blobs():
                last_modified = blob.last_modified.strftime("%Y-%m-%dT%H:%M:%SZ") if blob.last_modified else datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
                creation_time = blob.creation_time.strftime("%Y-%m-%dT%H:%M:%SZ") if blob.creation_time else last_modified
                batch_buffer.append({
                    'name': blob.name,
                    'container': container_name,
                    'last_modified': last_modified,
                    'size': str(blob.size),
                    'creation_time': creation_time,
                })
                if len(batch_buffer) >= BATCH_SIZE:
                    result_queue.put(('batch', list(batch_buffer), container_name))
                    batch_buffer.clear()
            if batch_buffer:
                result_queue.put(('batch', batch_buffer, container_name))
            result_queue.put(('done', container_name, None))
        except Exception as e:
            print(f"    ERROR processing blob container {container_name}: {e}", file=sys.stderr)
            result_queue.put(('error', container_name, str(e)))

    # --- Common scan/queue/CSV logic ---

    try:
        with NamedTemporaryFile(mode="w", newline="", suffix=".csv", delete=False) as tmp:
            tmp_csv = tmp.name
            writer = csv.writer(tmp)
            writer.writerow(["file_id", "name", "container", "last_modified", "size", "creation_time"])

            if use_blobs:
                print(f"  Discovering blob containers in storage account '{storage}'...")
                items_to_scan = [
                    c['name'] for c in blob_service_client.list_containers()
                    if not AZURE_FILE_SHARE_PREFIX or c['name'].startswith(AZURE_FILE_SHARE_PREFIX)
                ]
                worker_fn = process_blob_container_worker
                item_label = "container"
            else:
                print(f"  Discovering file shares in storage account '{storage}'...")
                items_to_scan = [
                    s['name'] for s in share_service_client.list_shares()
                    if not AZURE_FILE_SHARE_PREFIX or s['name'].startswith(AZURE_FILE_SHARE_PREFIX)
                ]
                worker_fn = process_share_worker
                item_label = "share"

            if not items_to_scan:
                print(f"  No {item_label}s found{' matching prefix' if AZURE_FILE_SHARE_PREFIX else ''}")
                return

            print(f"  Found {len(items_to_scan)} {item_label}s to scan: {', '.join(items_to_scan)}")
            print(f"  Starting parallel scan with {MAX_WORKERS} workers...")

            items_completed = 0
            items_total = len(items_to_scan)

            with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
                for item_name in items_to_scan:
                    executor.submit(worker_fn, item_name)

                while items_completed < items_total:
                    msg_type, data, extra = result_queue.get()

                    if msg_type == 'batch':
                        for record in data:
                            writer.writerow([
                                total_files,
                                record['name'],
                                record['container'],
                                record['last_modified'],
                                record['size'],
                                record['creation_time'],
                            ])
                            total_files += 1
                        if total_files % 100_000 == 0:
                            print(f"    Progress: {total_files:,} files scanned...")

                    elif msg_type == 'done':
                        items_completed += 1
                        print(f"    ✓ Completed {item_label}: {data} ({items_completed}/{items_total})")

                    elif msg_type == 'error':
                        items_completed += 1
                        print(f"    ✗ Failed {item_label}: {data} - {extra}", file=sys.stderr)

        print(f"\n  Writing {total_files:,} records to database...")
        psql(database, copy_to=f"\\copy public.all_metadata FROM '{tmp_csv}' CSV HEADER")

    finally:
        if tmp_csv and os.path.exists(tmp_csv):
            os.remove(tmp_csv)

    print(f"  Total files loaded: {total_files:,}")


# ---------------------------------------------------------------------------
# Stage 2 – Run SQL transformations
# ---------------------------------------------------------------------------

def stage_sql_transforms():
    print("\n=== Stage 2: Running SQL transformations ===")
    # Create all_metadata_expanded + by_site_metadata  (from dash/prep_for_export.sql logic)
    # This is used by get_allfiles_grouped.sql
    print("  Running prep_for_export.sql on choruspilot metadata...")
    psql("ohdsi", file="/app/prep_for_export.sql")

    print("  Running prep_for_export.sql on landing metadata...")
    psql("postgres", file="/app/prep_for_export.sql")

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

    # by_site.csv
    psql("ohdsi", copy_to=f"\\copy public.by_site_metadata TO '{DELIV_DIR}/by_site.csv' CSV HEADER")

    # sample.csv
    psql("ohdsi", copy_to=f"\\copy public.all_metadata_sample TO '{DELIV_DIR}/sample.csv' CSV HEADER")

    # by_site_landing.csv
    psql("postgres", copy_to=f"\\copy public.by_site_metadata TO '{DELIV_DIR}/by_site_landing.csv' CSV HEADER")

    # sample_landing.csv
    psql("postgres", copy_to=f"\\copy public.all_metadata_sample TO '{DELIV_DIR}/sample_landing.csv' CSV HEADER")


    # omop_counts.csv  – per-site person and note counts
    print("  Collecting per-site OMOP counts...")
    omop_path = os.path.join(DATA_DIR, "omop_counts.csv")
    with open(omop_path, "w") as f:
        f.write("site,count_person,count_note\n")
        for site_db in OMOP_SITE_DBS:
            try:
                count_person = psql_scalar(site_db, "SELECT count(*) FROM omopcdm.person;")
                count_note = psql_scalar(site_db, "SELECT count(distinct(person_id)) FROM omopcdm.note;")
                f.write(f"{site_db},{count_person},{count_note}\n")
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

    stage_scan_fileshare("choruspilot")
    stage_scan_fileshare("mghb2ailanding")
    stage_sql_transforms()
    stage_export_csvs()
    stage_write_timestamp()

    print("Done.")
