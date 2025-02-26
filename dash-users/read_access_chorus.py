import asyncio
import datetime
import json
import numpy as np
import os
import pandas as pd
import re
import requests

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
#os.environ['AIMAHEAD_GROUP_ID']
#os.environ['RCMI_GROUP_ID']
#os.environ['B2AI_RES_GRP_ID']
#os.environ['AIM_RES_GRP_ID']
#os.environ['RCMI_RES_GRP_ID']

def get_role_df(cred, sub_id, rg_name, mlw_name):
    # Create pandas DF based on response from Azure MGMT API regarding access roles

    url = f"https://management.azure.com/subscriptions/{sub_id}/resourceGroups/{rg_name}/providers/Microsoft.MachineLearningServices/workspaces/{mlw_name}/providers/Microsoft.Authorization/roleAssignmentScheduleInstances?api-version=2020-10-01"

    # Get the access token for the Azure Management API
    token = cred.get_token("https://management.azure.com/.default")

    headers = {
        "Authorization": "Bearer " + token.token,
        "Content-Type": "application/json"
    }

    response = requests.get(url, headers=headers)

    role_df = pd.DataFrame()
    data = response.json()

    for item in data["value"]:
        role_df.at[item["properties"]["principalId"], 'id'] = item["properties"]["expandedProperties"]["principal"][
            "id"]
        if 'email' in item["properties"]["expandedProperties"]["principal"]:
            role_df.at[item["properties"]["principalId"], 'email'] = \
            item["properties"]["expandedProperties"]["principal"]["email"]
        else:
            role_df.at[item["properties"]["principalId"], 'email'] = "N/A"
        role_df.at[item["properties"]["principalId"], 'name'] = item["properties"]["expandedProperties"]["principal"][
            "displayName"]
        role_df.at[item["properties"]["principalId"], 'role_name'] = \
        item["properties"]["expandedProperties"]["roleDefinition"]["displayName"]
        role_df.at[item["properties"]["principalId"], 'type'] = item["properties"]["expandedProperties"]["principal"][
            "type"]

    return role_df

def update_user_df(udf, role_df, mlw_name, g_dict):
    # Join user_df captured through the Azure graph client with the role df
    # created through MGMT API requests

    udf[f'{mlw_name}_person_access'] = False
    role_df['role_grouped'] = role_df[['id', 'role_name']].groupby(['id'])['role_name'].transform(lambda x: ';'.join(x))

    for user_id in udf.index.tolist():
        if user_id in role_df["id"].to_list():
            udf.at[user_id, f'{mlw_name}_person_access'] = True
            udf.at[user_id, f'{mlw_name}_person_roles'] = role_df.at[user_id, 'role_grouped']

    udf[f'{mlw_name}_group_access'] = False
    unique_col_list = []
    for group_key in g_dict:
        unique_col = f'{mlw_name}_group_roles_' + group_key
        unique_col_list = unique_col_list + [unique_col]
        udf[unique_col] = [""] * len(udf.index)
        if g_dict[group_key] in role_df["id"].to_list():
            udf[f'{mlw_name}_group_access'][udf[group_key] == group_key] = True
            udf[unique_col][udf[group_key] == group_key] = role_df.at[g_dict[group_key], 'role_grouped']

    udf[f'{mlw_name}_access'] = udf[f'{mlw_name}_person_access'] | udf[f'{mlw_name}_group_access']
    unique_col_list = unique_col_list + [f"{mlw_name}_person_roles"]
    udf[f'{mlw_name}_roles'] = udf[unique_col_list].apply(lambda x: ';'.join(x.dropna().astype(str).values),
                                                                  axis=1)

    udf.drop(columns=unique_col_list, inplace=True)
    return udf

def add_landing_access(udf, to_iter, landing_name, endpoint_specific=False):
    # Add columns to user df for access to landing pages
    if endpoint_specific:
        access = json.load(open(f'/{landing_name}_access/data/access.json'))
        access_list = list(access['roles'].keys())
    else:
        access = json.load(open(f'/{landing_name}_access/data/access.json'))
        access_list = [access['roles'][role][0] for role in access['roles']]

    for row in to_iter.itertuples():
        if endpoint_specific:
            if row.principal_name in access_list:
                udf.at[row.Index, f'{landing_name}_landing'] = 'TRUE'
            else:
                udf.at[row.Index, f'{landing_name}_landing'] = 'FALSE'
        else:
            if row.email in access_b2ai_list:
                udf.at[row.Index, f'{landing_name}_landing'] = 'TRUE'
            else:
                udf.at[row.Index, f'{landing_name}_landing'] = 'FALSE'

    return udf


def add_ff_access(udf, res_client, res_group_id, ff_name):
    # Add columns to user df for firefox provisioning
    res_df = pd.DataFrame()
    resource_list = res_client.resources.list_by_resource_group(
        res_group_id, expand="createdTime,changedTime")
    for resource in resource_list:
        res_df.at[resource.id, 'name'] = resource.name
        res_df.at[resource.id, 'type'] = resource.type
        res_df.at[resource.id, 'created'] = resource.created_time

    for row in toIterate.itertuples():
        for row2 in res_df.itertuples():
            if f'ca-{ff_name}-lab-' + row.app_user_name == row2.name:
                udf.at[row.Index, f'{ff_name}_firefox'] = 'TRUE'
                udf.at[row.Index, f'{ff_name}_firefox_created'] = row2.created
                break
            else:
                udf.at[row.Index, f'{ff_name}_firefox'] = 'FALSE'

    return udf


group_dict = {"CHORUS": os.environ['CHORUS_GROUP_ID'],
                     "AWSR_A": os.environ['AWSR_A_GROUP_ID'],
                     "AWSR_G": os.environ['AWSR_G_GROUP_ID'],
                     "DATATH": os.environ['DATATH_GROUP_ID'],
                     "CHLNG" : os.environ['CHLNG_GROUP_ID'],
                     "SFTLNCH": os.environ['SFTLNCH_GROUP_ID'],
                     "AIMAHEAD": os.environ['AIMAHEAD_GROUP_ID'],
                     "RCMI": os.environ['RCMI_GROUP_ID']}

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

role_df_aimahead = get_role_df(credential, os.environ["SUBSCRIPTION_ID"], os.environ["AIM_RES_GRP_ID"], "mgh-aimahead-e2-mlw")
role_df_rcmi = get_role_df(credential, os.environ["SUBSCRIPTION_ID"], os.environ["RCMI_RES_GRP_ID"], "mgh-rcmi-e2-mlw")

user_df = update_user_df(user_df, role_df_aimahead, 'aim_workspace', group_dict)
user_df = update_user_df(user_df, role_df_rcmi, 'rcmi_workspace', group_dict)

user_df = user_df.mask(user_df == '')
user_df['entra_groups'] = user_df[list(group_dict.keys())].apply(lambda x: ';'.join(x.dropna().astype(str).values),
                                                         axis=1)
user_df.drop(columns=list(group_dict.keys()), inplace=True)
toIterate = user_df.copy()

# STAGE 2 - read json files and check reverse proxy permissions

for landing_page in ['b2ai', 'aim', 'dgs', 'rcmi']:
    end_specific = landing_page in ['dgs']
    user_df = add_landing_access(user_df, toIterate, landing_page, end_specific)


# STAGE 3 - read resources in resource groups and check for lab instances

credential = DefaultAzureCredential()
resource_client = ResourceManagementClient(credential, os.environ['SUBSCRIPTION_ID'] )
#
#
#
user_df = add_ff_access(user_df, resource_client, os.environ['B2AI_RES_GRP_ID'], 'b2ai')
user_df = add_ff_access(user_df, resource_client, os.environ['AIM_RES_GRP_ID'], 'aimahead')
user_df = add_ff_access(user_df, resource_client, os.environ['RCMI_RES_GRP_ID'], 'rcmi')


user_df['loaded_at'] = [datetime.datetime.now()] * user_df.shape[0]
user_df.to_csv('/az_users/data/personnel_metadata.csv', index=False)
