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

app = Dash(external_stylesheets=[dbc.themes.BOOTSTRAP], url_base_pathname='/dash/')
app.css.config.serve_locally = True
app.scripts.config.serve_locally = True
app.title = 'Data Deliveries'

all_table_columns = [
   'name', 'container', 'mode', 'size', 'extension', 'year_modified', 'month_modified', 'quarter_modified',  'last_modified'
]

group_table_columns = [
        'container', 'OMOP_SIZE', 'WAVEFORM_SIZE', 'IMAGE_SIZE', 'NOTE_SIZE', 'OMOP_FILES', 'WAVEFORM_FILES', 'IMAGE_FILES', 'NOTE_FILES', 'WAVEFORM_EXT', 'IMAGE_EXT', 'MOST_RECENT_UPLOAD',
        'OMOP_REL', 'WAVEFORM_REL', 'IMAGE_REL', 'NOTE_REL', 'MOST_RECENT_OMOP', 'MOST_RECENT_WAVE', 'MOST_RECENT_IMAGE', 'MOST_RECENT_NOTE'
        ]

def data_load():
    by_site_file = '/pilot_meta/data/by_site.csv'
    by_site = pd.read_csv(by_site_file)
    sample_file = '/pilot_meta/data/sample.csv'
    df = pd.read_csv(sample_file)
    return df, by_site

df, by_site = data_load()

container_dropdown = html.Div(
    [
        dbc.Label("Select a Site", html_for="container_dropdown"),
        dcc.Dropdown(
            id="container-dropdown",
            options=sorted(df["container"].unique()),
            value='columbia',
            clearable=False,
            maxHeight=600,
            optionHeight=50
        ),
    ],  className="mb-4",
)


control_panel = dbc.Card(
    dbc.CardBody(
        [container_dropdown ],
        className="bg-light",
    ),
    className="mb-4"
)

heading = html.H1("CHoRUS Data Delivery Dashboard",className="bg-secondary text-white p-2 mb-4")

about_card = dcc.Markdown(
    """
    The dashboard references files delivered to the choruspilotstorage storage container. It is updated by a
        job that runs daily; information is thus not real-time, but should be accurate within a 24-hour window.
    """)

info = dbc.Accordion([
    dbc.AccordionItem(about_card, title="About the Data Delivery Dashboard", )
],  start_collapsed=True)


def make_grid_group():
    grid = dag.AgGrid(
        id="grid-group",
        rowData=by_site.to_dict("records"),
        columnDefs= [{"field": c} for c in group_table_columns],
        defaultColDef={"filter": True, "floatingFilter": True,  "wrapHeaderText": True, "autoHeaderHeight": True, "initialWidth": 200 },
        dashGridOptions={},
        rowClassRules = {"bg-secondary text-dark bg-opacity-25": "params.node.rowPinned === 'top' | params.node.rowPinned === 'bottom'"},
        style={"height": 600, "width": "100%"}
    )
    return grid


def make_grid_all():
    grid = dag.AgGrid(
        id="grid-all",
        rowData=df.to_dict("records"),
        columnDefs= [{"field": c} for c in all_table_columns],
        defaultColDef={"filter": True, "floatingFilter": True,  "wrapHeaderText": True, "autoHeaderHeight": True, "initialWidth": 200 },
        dashGridOptions={},
        style={"height": 600, "width": "100%"}
    )
    return grid


app.layout = dbc.Container(
    [
        dcc.Store(id="store-selected-group", data={}),
        dcc.Store(id="store-selected-all", data={}),
        heading,
        dbc.Row([
            dbc.Col([control_panel, info], md=3),
            dbc.Col(
                [
                    dcc.Markdown(id="title"),
                    dbc.Row(dbc.Col(html.Div(id="mode-card"))),
                ],  md=9
            ),
        ]),
        dbc.Row(dbc.Col([ dcc.Markdown(id="subtitle-1"), make_grid_group()]), className="my-4"),
        dbc.Row(dbc.Col([ dcc.Markdown(id="subtitle-2"), make_grid_all()]), className="my-4"),
    ],
    fluid=True,
)


@callback(
    Output("grid-group", "dashGridOptions"),
    Output("grid-all", "filterModel"),
    Output("store-selected-group", "data"),
    Output("store-selected-all", "data"),
    Input("container-dropdown", "value")
)
def pin_selected_report(container):
    bsite = by_site[(by_site["container"] == container)]
    bsite = bsite.fillna('')
    records_group = bsite.to_dict("records")
    dff = df[(df["container"] == container)]
    dff = dff.fillna('')
    records_all = dff.to_dict("records")
    return {"pinnedTopRowData": records_group},{'container': {'filterType': 'string', 'type': 'equals', 'filter': container}}, records_group, records_all


@callback(
    Output("title", "children"),
    Input("store-selected-group", "data"),
)
def make_title(data):
    try:
        data = data[0]
    except:
        data = by_site[by_site["container"] == 'columbia'].to_dict("records")
    title = f"""
    ## Data Delivery Report for {data["container"]} 
    *(Metadata refreshed at {data["Loaded_At"]})*
    
    ** For file-specific details, see the per-file grid at the bottom of the page **
    """
    return title


@callback(
    Output("subtitle-1", "children"),
    Input("store-selected-group", "data"),
)
def make_subtitle_1(data):
    subtitle_1 = f"""
    ### Overview of aggregate upload characteristics
    """
    return subtitle_1

@callback(
    Output("subtitle-2", "children"),
    Input("store-selected-group", "data"),
)
def make_subtitle_2(data):
    subtitle_2 = f"""
    ### Overview of all files delivered
    """
    return subtitle_2


@callback(
    Output("mode-card", "children"),
    Input("store-selected-group", "data"),
)
def make_mode_gap_card(data):
    try:
        data=data[0]
    except:
        data=by_site[by_site["container"] == 'columbia'].to_dict("records")
    data = {k: (f"{v}" if v  else '0') for k, v in data.items()}
    modegap = dbc.Row([
        dbc.Col([
            html.Div("Mode", className=" border-bottom border-3"),
            html.Div("OMOP"),
            html.Div("Waveform"),
            html.Div("Image"),
            html.Div("Note"),
        ], style={"minWidth": 250}),
        dbc.Col([
            html.Div("Files (#)", className=" border-bottom border-3"),
            html.Div( f"{data['OMOP_FILES']}"),
            html.Div(f"{data['WAVEFORM_FILES']}"),
            html.Div(f"{data['IMAGE_FILES']}"),
            html.Div(f"{data['NOTE_FILES']}"),
        ]),
        dbc.Col([
            html.Div("Size (GB)", className=" border-bottom border-3"),
            html.Div(f"{data['OMOP_SIZE']}"),
            html.Div(f"{data['WAVEFORM_SIZE']}"),
            html.Div(f"{data['IMAGE_SIZE']}"),
            html.Div(f"{data['NOTE_SIZE']}"),
        ]),
        dbc.Col([
            html.Div("Recent Upload", className=" border-bottom border-3"),
            html.Div(f"{data['MOST_RECENT_OMOP']}"),
            html.Div(f"{data['MOST_RECENT_WAVE']}"),
            html.Div(f"{data['MOST_RECENT_IMAGE']}"),
            html.Div(f"{data['MOST_RECENT_NOTE']}"),
        ])
    ], style={"minWidth": 400})

    omop = dbc.Alert(dcc.Markdown(
        f"""
        ** OMOP Data Size **
        ### {data['OMOP_REL']}%
        of total CHoRUS OMOP Data
        """,
    ), color="dark")

    wave = dbc.Alert(dcc.Markdown(
        f"""
        ** WAVEFORM Data Size **
        ### {data['WAVEFORM_REL']}%
        of total CHoRUS WAVEFORM Data
        """,
    ), color="dark")

    image = dbc.Alert(dcc.Markdown(
        f"""
        ** IMAGE Data Size **
        ### {data['IMAGE_REL']}%
        of total CHoRUS IMAGE Data
        """,
    ), color="dark")

    note = dbc.Alert(dcc.Markdown(
        f"""
        ** NOTE Data Size **
        ### {data['NOTE_REL']}%
        of total CHoRUS NOTE Data
        """,
    ), color="dark")

    card =  dbc.Card([
        dbc.CardHeader(html.H2("Data Upload Statistics"), className="text-center"),
        dbc.CardBody([
            dbc.Row([dbc.Col(omop), dbc.Col(wave), dbc.Col(image), dbc.Col(note),], className="text-center"),
            modegap
        ])
    ])
    return card




if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
