"""
read_access_chorus.py

Builds a per-user access matrix across Entra groups, AML workspace roles,
reverse-proxy JSON ACLs, and Azure container-app lab instances.

Required environment variables:
  AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_CLIENT_SECRET
  SUBSCRIPTION_ID
  CHORUS_GROUP_ID, AWSR_A_GROUP_ID, AWSR_G_GROUP_ID, DATATH_GROUP_ID
  CHLNG_GROUP_ID, SFTLNCH_GROUP_ID, AIMAHEAD_GROUP_ID
  B2AI_RES_GRP_ID, AIM_RES_GRP_ID
  OUTPUT_DIR  (optional, default: /az_users/data)
"""

import asyncio
import datetime
import json
import os
import re

import pandas as pd
import requests
from azure.identity import ClientSecretCredential, DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient
from msgraph import GraphServiceClient


# ---------------------------------------------------------------------------
# Credential / client helpers
# ---------------------------------------------------------------------------

def build_credential() -> ClientSecretCredential:
    return ClientSecretCredential(
        tenant_id=os.environ['AZURE_TENANT_ID'],
        client_id=os.environ['AZURE_CLIENT_ID'],
        client_secret=os.environ['AZURE_CLIENT_SECRET'],
    )


def build_graph_client(credential: ClientSecretCredential) -> GraphServiceClient:
    return GraphServiceClient(
        credentials=credential,
        scopes=['https://graph.microsoft.com/.default'],
    )


# ---------------------------------------------------------------------------
# Stage 1a – Entra group membership
# ---------------------------------------------------------------------------

async def fetch_group_members(client: GraphServiceClient, group_dict: dict) -> pd.DataFrame:
    """Return a DataFrame (indexed by Entra object ID) of all members across group_dict."""
    user_df = pd.DataFrame()

    for group_key, group_id in group_dict.items():
        members = await client.groups.by_group_id(group_id).members.get()
        if not (members and members.value):
            continue
        for member in members.value:
            user = await client.users.by_user_id(member.id).get()
            if not user:
                continue
            print(user.mail)
            uid = member.id
            user_df.at[uid, 'name'] = user.display_name
            user_df.at[uid, 'email'] = user.mail
            user_df.at[uid, 'principal_name'] = user.user_principal_name
            user_df.at[uid, 'user_group'] = (
                'EXTERNAL' if '#' in user.user_principal_name else 'POI/INTERNAL'
            )
            user_df.at[uid, 'app_user_name'] = (
                re.sub(r'[^0-9a-z]+', '', re.sub(r'@.*', '', user.mail.lower()))[:13]
            )
            user_df.at[uid, group_key] = group_key

    return user_df


# ---------------------------------------------------------------------------
# Stage 1b – AML workspace role assignments
# ---------------------------------------------------------------------------

def get_workspace_roles(
    credential: ClientSecretCredential,
    sub_id: str,
    rg_name: str,
    workspace_name: str,
) -> pd.DataFrame:
    """
    Return a DataFrame (indexed by principal ID) of roles for an AML workspace.
    Multiple roles per principal are joined with ';'.
    """
    base = (
        f"https://management.azure.com/subscriptions/{sub_id}"
        f"/resourceGroups/{rg_name}"
        f"/providers/Microsoft.MachineLearningServices/workspaces/{workspace_name}"
        f"/providers/Microsoft.Authorization"
    )
    token = credential.get_token("https://management.azure.com/.default")
    headers = {
        "Authorization": f"Bearer {token.token}",
        "Content-Type": "application/json",
    }

    assignments = requests.get(
        f"{base}/roleAssignments?api-version=2022-04-01", headers=headers
    ).json()
    definitions = requests.get(
        f"{base}/roleDefinitions?api-version=2022-04-01", headers=headers
    ).json()

    def_map = {d['id']: d['properties']['roleName'] for d in definitions['value']}

    # Accumulate multiple roles per principal before building the DataFrame
    principals: dict[str, dict] = {}
    for item in assignments['value']:
        props = item['properties']
        pid = props['principalId']
        if pid not in principals:
            principals[pid] = {'id': pid, 'type': props['principalType'], 'roles': []}
        principals[pid]['roles'].append(def_map.get(props['roleDefinitionId'], 'Unknown'))

    if not principals:
        return pd.DataFrame(columns=['id', 'type', 'role_name'])

    role_df = pd.DataFrame([
        {'id': p['id'], 'type': p['type'], 'role_name': ';'.join(p['roles'])}
        for p in principals.values()
    ]).set_index('id')
    role_df['id'] = role_df.index  # keep 'id' as a regular column too
    return role_df


def apply_workspace_roles(
    user_df: pd.DataFrame,
    role_df: pd.DataFrame,
    group_dict: dict,
    col_prefix: str,
) -> pd.DataFrame:
    """
    Annotate user_df with workspace access flags derived from role_df.

    Adds:
      {col_prefix}_person_access  – user has a direct role assignment
      {col_prefix}_group_access   – user belongs to a group with a role assignment
      {col_prefix}_access         – either of the above
      {col_prefix}_roles          – semicolon-joined role names
    """
    person_col = f"{col_prefix}_person_access"
    group_col  = f"{col_prefix}_group_access"
    access_col = f"{col_prefix}_access"
    roles_col  = f"{col_prefix}_roles"

    user_df[person_col] = False
    user_df[group_col]  = False

    role_ids = set(role_df.index)
    per_role_cols = []

    # Direct (person) role assignments
    person_roles_col = f"{col_prefix}_person_roles"
    for uid in user_df.index:
        if uid in role_ids:
            user_df.at[uid, person_col] = True
            user_df.at[uid, person_roles_col] = role_df.at[uid, 'role_name']
    per_role_cols.append(person_roles_col)

    # Group-level role assignments
    for group_key, group_id in group_dict.items():
        gcol = f"{col_prefix}_group_roles_{group_key}"
        per_role_cols.append(gcol)
        user_df[gcol] = ''
        if group_id not in role_ids or group_key not in user_df.columns:
            continue
        mask = user_df[group_key] == group_key
        user_df.loc[mask, group_col] = True
        user_df.loc[mask, gcol] = role_df.at[group_id, 'role_name']

    user_df[access_col] = user_df[person_col] | user_df[group_col]

    # Collapse all per-role columns into one
    user_df[roles_col] = user_df[per_role_cols].apply(
        lambda x: ';'.join(dict.fromkeys(v for v in x.dropna().astype(str) if v)),
        axis=1,
    )
    user_df.drop(columns=per_role_cols, inplace=True)
    return user_df


# ---------------------------------------------------------------------------
# Stage 2 – Reverse-proxy / landing access JSON files
# ---------------------------------------------------------------------------

def check_access_file(
    user_df: pd.DataFrame,
    path: str,
    col_name: str,
    key_col: str = 'email',
    use_keys: bool = False,
) -> pd.DataFrame:
    """
    Mark user_df[col_name] as 'TRUE'/'FALSE' based on whether user_df[key_col]
    appears in the access JSON at path.

    JSON shapes supported:
      {"roles": {"role_name": [identifier, ...], ...}}  use_keys=False (default)
        → takes the first element of each role's list as the allowed identifier
      {"roles": {"identifier": ..., ...}}               use_keys=True
        → uses the role keys themselves as the allowed identifiers (e.g. DGS)
    """
    data = json.load(open(path))
    roles = data['roles']
    if use_keys:
        allowed = set(roles.keys())
    else:
        allowed = {entries[0] for entries in roles.values() if entries}

    user_df[col_name] = user_df[key_col].isin(allowed).map({True: 'TRUE', False: 'FALSE'})
    return user_df


# ---------------------------------------------------------------------------
# Stage 3 – Azure resource group lab instances
# ---------------------------------------------------------------------------

def get_resource_df(credential, sub_id: str, rg_name: str) -> pd.DataFrame:
    """Return a DataFrame of resources in a resource group, indexed by resource ID."""
    client = ResourceManagementClient(credential, sub_id)
    rows = []
    for resource in client.resources.list_by_resource_group(
        rg_name, expand="createdTime,changedTime"
    ):
        rows.append({'id': resource.id, 'name': resource.name,
                     'type': resource.type, 'created': resource.created_time})
    return pd.DataFrame(rows).set_index('id') if rows else pd.DataFrame(
        columns=['name', 'type', 'created']
    )


def check_lab_instances(
    user_df: pd.DataFrame,
    resource_df: pd.DataFrame,
    prefix: str,
    col_name: str,
) -> pd.DataFrame:
    """
    For each user, check whether a container app named '<prefix><app_user_name>'
    exists in resource_df. Sets col_name ('TRUE'/'FALSE') and col_name+'_created'.
    """
    name_to_created = resource_df.set_index('name')['created'].to_dict()

    user_df[col_name] = 'FALSE'
    user_df[col_name + '_created'] = None

    for uid, row in user_df.iterrows():
        target = prefix + str(row.get('app_user_name', ''))
        if target in name_to_created:
            user_df.at[uid, col_name] = 'TRUE'
            user_df.at[uid, col_name + '_created'] = name_to_created[target]

    return user_df


# ---------------------------------------------------------------------------
# Finalize and export
# ---------------------------------------------------------------------------

def finalize_user_df(user_df: pd.DataFrame, group_dict: dict) -> pd.DataFrame:
    """Collapse per-group membership columns into entra_groups, then drop them."""
    group_keys = [k for k in group_dict if k in user_df.columns]
    user_df = user_df.mask(user_df == '')
    user_df['entra_groups'] = user_df[group_keys].apply(
        lambda x: ';'.join(x.dropna().astype(str).values), axis=1
    )
    user_df.drop(columns=group_keys, inplace=True)
    return user_df


def save_output(user_df: pd.DataFrame, output_dir: str) -> None:
    os.makedirs(output_dir, exist_ok=True)
    user_df.to_csv(os.path.join(output_dir, 'personnel_metadata.csv'), index=False)
    timestamp = datetime.datetime.now(datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')
    with open(os.path.join(output_dir, 'last_updated.txt'), 'w') as f:
        f.write(timestamp)
    print(f"Data saved to {output_dir}/personnel_metadata.csv at {timestamp}")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    group_dict = {
        "CHORUS":   os.environ['CHORUS_GROUP_ID'],
        "AWSR_A":   os.environ['AWSR_A_GROUP_ID'],
        "AWSR_G":   os.environ['AWSR_G_GROUP_ID'],
        "DATATH":   os.environ['DATATH_GROUP_ID'],
        "CHLNG":    os.environ['CHLNG_GROUP_ID'],
        "SFTLNCH":  os.environ['SFTLNCH_GROUP_ID'],
        "AIMAHEAD": os.environ['AIMAHEAD_GROUP_ID'],
    }
    sub_id       = os.environ['SUBSCRIPTION_ID']
    aim_rg       = os.environ['AIM_RES_GRP_ID']
    b2ai_rg      = os.environ['B2AI_RES_GRP_ID']
    aim_workspace = "mgh-aimahead-e2-mlw"

    # Stage 1 – group membership + workspace roles
    credential   = build_credential()
    graph_client = build_graph_client(credential)

    user_df = asyncio.run(fetch_group_members(graph_client, group_dict))

    role_df = get_workspace_roles(credential, sub_id, aim_rg, aim_workspace)
    user_df = apply_workspace_roles(user_df, role_df, group_dict, col_prefix='aim_workspace')
    print(user_df[user_df['aim_workspace_access']])

    # Stage 2 – landing / reverse-proxy access
    user_df = check_access_file(user_df, '/b2ai_access/data/access.json', 'b2ai_landing')
    user_df = check_access_file(user_df, '/aim_access/data/access.json',  'aim_landing')
    user_df = check_access_file(
        user_df, '/dgs_access/data/access.json', 'dgs_landing',
        key_col='principal_name', use_keys=True,
    )

    # Stage 3 – lab container instances
    default_cred   = DefaultAzureCredential()
    resource_df_b2ai = get_resource_df(default_cred, sub_id, b2ai_rg)
    resource_df_aim  = get_resource_df(default_cred, sub_id, aim_rg)

    user_df = check_lab_instances(user_df, resource_df_b2ai, 'ca-eng-lab-',    'b2ai_firefox')
    user_df = check_lab_instances(user_df, resource_df_aim,  'ca-aimahead-lab-', 'aim_firefox')

    # Finalize and save
    user_df['loaded_at'] = datetime.datetime.now(datetime.timezone.utc)
    user_df = finalize_user_df(user_df, group_dict)
    save_output(user_df, os.environ.get('OUTPUT_DIR', '/az_users/data'))


if __name__ == '__main__':
    main()
