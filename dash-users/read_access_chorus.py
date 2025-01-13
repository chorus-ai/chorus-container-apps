import asyncio
import datetime
import json
import numpy as np
import os
import pandas as pd
import re

from azure.identity import ClientSecretCredential
from msgraph import GraphServiceClient
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient

# The environment variables below should be set
#os.environ['AZURE_CLIENT_ID']
#os.environ['AZURE_TENANT_ID']
#os.environ['AZURE_CLIENT_SECRET']
#os.environ['SUBSCRIPTION_ID']
#os.environ['CHORUS_GROUP_ID']
#os.environ['AWSR_A_GROUP_ID']
#os.environ['AWSR_G_GROUP_ID']
#os.environ['DATATH_GROUP_ID']
#os.environ['CHLNG_GROUP_ID']
#os.environ['SFTLNCH_GROUP_ID']
#os.environ['B2AI_RES_GRP_ID']
#os.environ['AIM_RES_GRP_ID']


group_dict = {"CHORUS": os.environ['CHORUS_GROUP_ID'],
                     "AWSR_A": os.environ['AWSR_A_GROUP_ID'],
                     "AWSR_G": os.environ['AWSR_G_GROUP_ID'],
                     "DATATH": os.environ['DATATH_GROUP_ID'],
                     "CHLNG" : os.environ['CHLNG_GROUP_ID'],
                     "SFTLNCH": os.environ['SFTLNCH_GROUP_ID']}

# Create a credential object. Used to authenticate requests
credential = ClientSecretCredential(
    tenant_id=os.environ['AZURE_TENANT_ID'],
    client_id=os.environ['AZURE_CLIENT_ID'],
    client_secret=os.environ['AZURE_CLIENT_SECRET']
)
scopes = ['https://graph.microsoft.com/.default']

# Create an API client with the credentials and scopes.
client = GraphServiceClient(credentials=credential, scopes=scopes)

user_df = pd.DataFrame({c: pd.Series(dtype='str') for c in list(group_dict.keys())})
resource_df_b2ai = pd.DataFrame()
resource_df_aim = pd.DataFrame()
async def get_group_members():
    for key in group_dict:

        members = await client.groups.by_group_id(group_dict[key]).members.get()
        if members and members.value:
            for member in members.value:
                user = await client.users.by_user_id(member.id).get()
                if user:
                    user_df.at[member.id, 'name'] = user.display_name
                    user_df.at[member.id, 'email'] = user.mail
                    user_df.at[member.id, 'principal_name'] = user.user_principal_name
                    if '#' in user.user_principal_name:
                        user_df.at[member.id, 'user_group'] = 'EXTERNAL'
                    else:
                        user_df.at[member.id, 'user_group'] = 'POI/INTERNAL'
                    user_df.at[member.id, 'app_user_name'] = re.sub(r"[^0-9a-z]+", "",re.sub(r"@.*", "", user.mail.lower()))[0:13]
                    user_df.at[member.id, key] = key
                    print(user.mail)

asyncio.run(get_group_members())

user_df['entra_groups'] = user_df[list(group_dict.keys())].apply(lambda x: ';'.join(x.dropna().astype(str).values), axis=1)

user_df.drop(columns=list(group_dict.keys()), inplace=True)

toIterate = user_df.copy()

# STAGE 2 - read json files and check reverse proxy permissions

access_b2ai = json.load(open('/b2ai_access/data/access.json'))
access_b2ai_list = [access_b2ai['roles'][role][0] for role in access_b2ai['roles']]


access_aim = json.load(open('/aim_access/data/access.json'))
access_aim_list = [access_aim['roles'][role][0] for role in access_aim['roles']]

for row in toIterate.itertuples():
    if row.email in access_b2ai_list:
        user_df.at[row.Index, 'b2ai_landing'] = 'TRUE'
    else:
        user_df.at[row.Index, 'b2ai_landing'] = 'FALSE'
    if row.email in access_aim_list:
        user_df.at[row.Index, 'aim_landing'] = 'TRUE'
    else:
        user_df.at[row.Index, 'aim_landing'] = 'FALSE'


# STAGE 3 - read resources in resource groups and check for lab instances

credential = DefaultAzureCredential()
resource_client = ResourceManagementClient(credential, os.environ['SUBSCRIPTION_ID'] )

resource_list_b2ai = resource_client.resources.list_by_resource_group(
    os.environ['B2AI_RES_GRP_ID'], expand = "createdTime,changedTime")

resource_list_aim = resource_client.resources.list_by_resource_group(
    os.environ['AIM_RES_GRP_ID'], expand = "createdTime,changedTime")

for resource in resource_list_b2ai:
    resource_df_b2ai.at[resource.id, 'name'] = resource.name
    resource_df_b2ai.at[resource.id, 'type'] = resource.type
    resource_df_b2ai.at[resource.id, 'created'] = resource.created_time

for resource in resource_list_aim:
    resource_df_aim.at[resource.id, 'name'] = resource.name
    resource_df_aim.at[resource.id, 'type'] = resource.type
    resource_df_aim.at[resource.id, 'created'] = resource.created_time

for row in toIterate.itertuples():
    for row2 in resource_df_b2ai.itertuples():
        if 'ca-b2ai-lab-' + row.app_user_name == row2.name:
            user_df.at[row.Index, 'b2ai_firefox'] = 'TRUE'
            user_df.at[row.Index, 'b2ai_firefox_created'] = row2.created
            break
        else:
            user_df.at[row.Index, 'b2ai_firefox'] = 'FALSE'
    for row3 in resource_df_aim.itertuples():
        if 'ca-aimahead-lab-' + row.app_user_name == row3.name:
            user_df.at[row.Index, 'aim_firefox'] = 'TRUE'
            user_df.at[row.Index, 'aim_firefox_created'] = row3.created
            break
        else:
            user_df.at[row.Index, 'aim_firefox'] = 'FALSE'




user_df['loaded_at'] = [datetime.datetime.now()] * user_df.shape[0]
user_df.to_csv('/az_users/data/personnel_metadata.csv', index=False)
