import os, uuid, sys, json
import pandas as pd
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient, __version__
connection_string = os.environ['PILOT_CONN_STR']
blob_svc = BlobServiceClient.from_connection_string(conn_str=connection_string)
blob_list = ["columbia","duke", "emory", "mayo", "mgh", "mit", "nationwide", "pitts", "seattle", "tuft", "ucla", "ucsf", "uflorida", "uva"]
#blob_list = ["duke"]
column_list = ["name", "container", "size", "last_modified", "creation_time"]
data_all = pd.DataFrame(columns=column_list)

for site_name in blob_list:
        site_cc = blob_svc.get_container_client(site_name)
        info = site_cc.list_blobs()
        cnt = 0
        data_tmp = pd.DataFrame()
        for dat in info:
                for key in dat.keys():
                        value = dat[key]
                        #print(f"key: {key}, value: {value}")
                        if key in column_list:
                                data_tmp.at[cnt, key] = value
                cnt = cnt + 1

        data_tmp['extension'] = data_tmp['name'].str.split(pat=".").str[1]
        data_all = pd.concat([data_all, data_tmp[data_tmp['extension'].notnull()]])
        print(f"Finished with {site_name}")

data_all.to_csv("/pilot_meta/data/all_metadata.csv")