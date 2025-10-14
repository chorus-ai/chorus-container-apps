import dash
import pandas as pd
import numpy as np
from dash import Dash, html, dcc, Input, Output, State, callback, Patch
import dash_bootstrap_components as dbc
import dash_ag_grid as dag
import plotly.graph_objects as go
from datetime import datetime
import pytz
import os

app = Dash(external_stylesheets=[dbc.themes.BOOTSTRAP], url_base_pathname='/dash3/')
app.css.config.serve_locally = True
app.scripts.config.serve_locally = True
app.title = 'User Access'

perm_table_columns = [
    'name','email','principal_name','user_group',
    'app_user_name','entra_groups','b2ai_landing',
    'aim_landing', 'dgs_landing', 'b2ai_firefox',
    'aim_firefox','b2ai_firefox_created',
    'aim_firefox_created','loaded_at'
]

limit_column_list = [
'name','email','user_group', 'entra_groups', 'dgs_landing',
    'b2ai_landing', 'b2ai_firefox', 'aim_landing',
    'aim_firefox', 'aim_workspace_access', 'aim_workspace_roles',
    'b2ai_firefox_created', 'aim_firefox_created'
]



def data_load():
    permission_file = '/az_users/data/personnel_metadata.csv'
    df = pd.read_csv(permission_file)
    return df


df = data_load()
loaded_at = df['loaded_at'][0]

heading = html.H1("CHoRUS User Access Dashboard", className="bg-secondary text-white p-2 mb-4")

about_card = dcc.Markdown(
    """
    The dashboard references the permissions and access available to users across different user 
    groups within the CHoRUS cloud environment
    """)

info = dbc.Accordion([
    dbc.AccordionItem(about_card, title="About the User Access Dashboard", )
], start_collapsed=True)


def make_grid_group():
    grid = dag.AgGrid(
        id="grid-group",
        rowData=df[limit_column_list].to_dict("records"),
        columnDefs=[{"field": c} for c in limit_column_list],
        defaultColDef={"filter": True, "floatingFilter": True, "wrapHeaderText": True, "autoHeaderHeight": True,
                       "initialWidth": 200},
        dashGridOptions={},
        rowClassRules={
            "bg-secondary text-dark bg-opacity-25": "params.node.rowPinned === 'top' | params.node.rowPinned === 'bottom'"},
        style={"height": 1000, "width": "100%"}
    )
    return grid



app.layout = dbc.Container(
    [
        dcc.Store(id="store-permissions", data={}),
        heading,
        dcc.Markdown(id="title"),
        dbc.Row(dbc.Col([ dcc.Markdown(id="subtitle-1"), make_grid_group()]), className="my-4"),

    ],
    fluid=True,
)


@callback(
    Output("title", "children"),
    Input("store-permissions", "data"),
)
def make_title(dummy):
    title = f"""
    ### Metadata refreshed at {loaded_at[0:19]}
    """
    return title





if __name__ == "__main__":
    app.run(debug=False, host='0.0.0.0')
