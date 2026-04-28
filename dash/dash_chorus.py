import pandas as pd
from dash import Dash, html, dcc, Input, Output, State, callback, Patch
import dash_bootstrap_components as dbc
import dash_ag_grid as dag


app = Dash(external_stylesheets=[dbc.themes.BOOTSTRAP], url_base_pathname='/dash2/')
app.css.config.serve_locally = True
app.scripts.config.serve_locally = True
app.title = 'Data Deliveries'

all_table_columns = [
   'name', 'container', 'mode', 'size', 'extension', 'year_modified', 'month_modified', 'quarter_modified',  'last_modified'
]

group_table_columns = [
    'container','omop_size','wave_size','image_size','note_size','omop_files','wave_files','image_files','note_files',
    'waveform_ext','image_ext','most_recent_upload','omop_rel','waveform_rel','image_rel','note_rel','most_recent_omop',
    'most_recent_wave','most_recent_image','most_recent_note','loaded_at'
        ]

def data_load():
    by_site_file = '/pilot_meta/data/by_site.csv'
    by_site = pd.read_csv(by_site_file)
    sample_file = '/pilot_meta/data/sample.csv'
    df = pd.read_csv(sample_file)
    by_site_landing_file = '/pilot_meta/data/by_site_landing.csv'
    by_site_landing = pd.read_csv(by_site_landing_file)
    sample_landing_file = '/pilot_meta/data/sample_landing.csv'
    df_landing = pd.read_csv(sample_landing_file)
    return df, by_site, df_landing, by_site_landing

df, by_site, df_landing, by_site_landing  = data_load()

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

storage_dropdown = html.Div(
    [
        dbc.Label("Select a Storage Container", html_for="storage_dropdown"),
        dcc.Dropdown(
            id="storage-dropdown",
            options=['choruspilot', 'mghb2ailanding'],
            value='choruspilot',
            clearable=False,
            maxHeight=600,
            optionHeight=50
        ),
    ],  className="mb-4",
)


control_panel = dbc.Card(
    dbc.CardBody(
        [storage_dropdown, container_dropdown],
        className="bg-light",
    ),
    className="mb-4"
)

heading = html.H1("CHoRUS Data Delivery Dashboard",className="bg-secondary text-white p-2 mb-4")

about_card = dcc.Markdown(
    """
    The dashboard references files delivered to the choruspilotstorage and mghb2ailanding storage containers. It is updated by a
        job that runs weekly; information is thus not real-time, but should be accurate within a seven-day window.
    """)

info = dbc.Accordion([
    dbc.AccordionItem(about_card, title="About the Data Delivery Dashboard", )
],  start_collapsed=True)


def make_grid_group(dat):
    grid = dag.AgGrid(
        id="grid-group",
        rowData=dat.to_dict("records"),
        columnDefs= [{"field": c} for c in group_table_columns],
        defaultColDef={"filter": True, "floatingFilter": True,  "wrapHeaderText": True, "autoHeaderHeight": True, "initialWidth": 200 },
        dashGridOptions={},
        rowClassRules = {"bg-secondary text-dark bg-opacity-25": "params.node.rowPinned === 'top' | params.node.rowPinned === 'bottom'"},
        style={"height": 600, "width": "100%"}
    )
    return grid


def make_grid_all(dat):
    grid = dag.AgGrid(
        id="grid-all",
        rowData=dat.to_dict("records"),
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
        dbc.Row(dbc.Col([ dcc.Markdown(id="subtitle-1"), make_grid_group(by_site)]), className="my-4"),
        dbc.Row(dbc.Col([ dcc.Markdown(id="subtitle-2"), make_grid_all(df)]), className="my-4"),
    ],
    fluid=True,
)


@callback(
    Output("container-dropdown", "options"),
    Output("container-dropdown", "value"),
    Input("storage-dropdown", "value"),
)
def update_container_options(storage):
    source = by_site if storage == "choruspilot" else by_site_landing
    options = sorted(source["container"].unique())
    value = options[0] if options else None
    return options, value


@callback(
    Output("grid-group", "dashGridOptions"),
    Output("grid-group", "rowData"),
    Output("grid-all", "rowData"),
    Output("grid-all", "filterModel"),
    Output("store-selected-group", "data"),
    Output("store-selected-all", "data"),
    Input("container-dropdown", "value"),
    Input("storage-dropdown", "value")
)
def update_grids(container, storage):
    if storage == "choruspilot":
        full_group = by_site.fillna('')
        full_all = df.fillna('')
    else:
        full_group = by_site_landing.fillna('')
        full_all = df_landing.fillna('')

    bsite = full_group[full_group["container"] == container]
    records_group = bsite.to_dict("records")
    records_all = full_all[full_all["container"] == container].to_dict("records")

    return (
        {"pinnedTopRowData": records_group},
        full_group.to_dict("records"),
        full_all.to_dict("records"),
        {"container": {"filterType": "string", "type": "equals", "filter": container}},
        records_group,
        records_all,
    )


@callback(
    Output("title", "children"),
    Input("store-selected-group", "data"),
    Input("storage-dropdown", "value")
)
def make_title(data, storage):
    try:
        data = data[0]
    except (IndexError, KeyError):
        data = by_site[by_site["container"] == 'columbia'].to_dict("records")[0]
    title = f"""
    ## Data Delivery Report for {data["container"]} in {storage} 
    *(Metadata refreshed at {data["loaded_at"]})*
    
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
    ### File delivery sample (max 1000 files per mode)
    """
    return subtitle_2


@callback(
    Output("mode-card", "children"),
    Input("store-selected-group", "data"),
)
def make_mode_gap_card(data):
    try:
        data = data[0]
    except (IndexError, KeyError):
        data = by_site[by_site["container"] == 'columbia'].to_dict("records")[0]
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
            html.Div( f"{data['omop_files']}"),
            html.Div(f"{data['wave_files']}"),
            html.Div(f"{data['image_files']}"),
            html.Div(f"{data['note_files']}"),
        ]),
        dbc.Col([
            html.Div("Size (GB)", className=" border-bottom border-3"),
            html.Div(f"{data['omop_size']}"),
            html.Div(f"{data['wave_size']}"),
            html.Div(f"{data['image_size']}"),
            html.Div(f"{data['note_size']}"),
        ]),
        dbc.Col([
            html.Div("Recent Upload", className=" border-bottom border-3"),
            html.Div(f"{data['most_recent_omop']}"),
            html.Div(f"{data['most_recent_wave']}"),
            html.Div(f"{data['most_recent_image']}"),
            html.Div(f"{data['most_recent_note']}"),
        ])
    ], style={"minWidth": 400})

    omop = dbc.Alert(dcc.Markdown(
        f"""
        ** OMOP Data Size **
        ### {data['omop_rel']}%
        of total CHoRUS OMOP Data
        """,
    ), color="dark")

    wave = dbc.Alert(dcc.Markdown(
        f"""
        ** WAVEFORM Data Size **
        ### {data['waveform_rel']}%
        of total CHoRUS WAVEFORM Data
        """,
    ), color="dark")

    image = dbc.Alert(dcc.Markdown(
        f"""
        ** IMAGE Data Size **
        ### {data['image_rel']}%
        of total CHoRUS IMAGE Data
        """,
    ), color="dark")

    note = dbc.Alert(dcc.Markdown(
        f"""
        ** NOTE Data Size **
        ### {data['note_rel']}%
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
