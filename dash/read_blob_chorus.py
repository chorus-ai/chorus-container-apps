import os, uuid, sys, json
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient, __version__
import subprocess
connection_string = os.environ['PILOT_CONN_STR']
blob_svc = BlobServiceClient.from_connection_string(conn_str=connection_string)
blob_list = ["columbia","duke", "emory", "mayo", "mgh", "mit", "nationwide", "pitts", "seattle", "tuft", "ucla", "ucsf", "uflorida", "uva"]
#blob_list = ["duke"]
column_list = ["name", "container", "size", "last_modified", "creation_time"]
cnt = 0
TMP_CSV="/tmp/to_send.csv"

def subprocess_run(command, input=None, cwd=None, env=None, check=True):
    if isinstance(input, str):
        input = input.encode('utf-8')
    return subprocess.run(command, input=input, cwd=cwd, env=env, check=check)


def psql_send_csv (csv_name, table_name, site_name):
    tmp_file = f'/tmp/{site_name}.sh'
    tmp_shell = f"""
        tail -q -n +2 {csv_name} | \\
        psql -d ohdsi -U postgres -p 5432 \\
        -c \"\copy public.{table_name} FROM STDIN CSV DELIMITER E','\" \\
        && rm -rf {csv_name}
        """
    with open(tmp_file, 'w') as t:
        t.write("#!/bin/bash\n")
        t.write(tmp_shell)
    subprocess_run(['chmod', '+x', tmp_file], check=True)
    subprocess_run([tmp_file], check=True)

def psql_run_file (file_name):
    tmp_file = f'/tmp/{file_name}.sh'
    tmp_shell = f"""
        psql -d ohdsi -U postgres -p 5432 \\
        -f /app/{file_name}.sql
        """
    with open(tmp_file, 'w') as t:
        t.write("#!/bin/bash\n")
        t.write(tmp_shell)
    subprocess_run(['chmod', '+x', tmp_file], check=True)
    subprocess_run([tmp_file], check=True)

psql_run_file("initialize")
for site_name in blob_list:
        site_cc = blob_svc.get_container_client(site_name)
        info = site_cc.list_blobs()
        cnt2 = 0
        cnt3 = 0
        print(f"Iterating over blob list for {site_name}")
        with open(TMP_CSV, 'w') as t:
            for dat in info:
                if cnt3 == 0:
                    t.write("id")
                    for key in dat.keys():
                        if key in column_list:
                            t.write(f",{key}")
                    t.write("\n")
                t.write(f"{cnt}")
                for key in dat.keys():
                    if key in column_list:
                        t.write(f",{dat[key]}")
                cnt = cnt + 1
                cnt2 = cnt2 + 1
                cnt3 = cnt3 + 1
                t.write("\n")
                if cnt2 == 100000:
                    print(f'{cnt} Total Blobs Parsed...')
                    cnt2 = 0
        psql_send_csv(TMP_CSV, "all_metadata", site_name)
        print(f"Finished with {site_name}")

psql_run_file("prep_for_export")
subprocess_run(["/app/export_dash_src.sh"], check=True)
subprocess_run(['rm', '-rf', "/tmp/*.sh"], check=True)