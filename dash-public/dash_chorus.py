import dash
from dash import dcc, html, Input, Output, ClientsideFunction
import dash_bootstrap_components as dbc
import dash_ag_grid as dag
import numpy as np
import pandas as pd
import plotly.graph_objects as go
import plotly as py
import pathlib


app = dash.Dash(
    __name__,
    meta_tags=[{"name": "viewport", "content": "width=device-width, initial-scale=1"}],
    external_stylesheets=[dbc.themes.BOOTSTRAP],
    url_base_pathname='/dash/'
)
app.css.config.serve_locally = True
app.scripts.config.serve_locally = True
app.title = "CHoRUS Data Status"

server = app.server
app.config.suppress_callback_exceptions = True

# Path
BASE_PATH = pathlib.Path(__file__).parent.resolve()
DATA_PATH = BASE_PATH.joinpath("data").resolve()

# Data Loading Block
counts_df = pd.read_csv("/app/data/allfiles_grouped.csv", header=0)
persons_omop_df = pd.read_csv("/app/data/omop_counts.csv", header=0)
conditions_df_tmp = pd.read_csv("/app/data/chorus_conditions.csv", header=0)
conditions_df = conditions_df_tmp[conditions_df_tmp["num_persons"]>=20] # SMALL CELL COUNT
demograph_df = pd.read_csv("/app/data/demograph.csv", header=0)
access_df = pd.read_csv("/app/data/access_details.csv", header=0)
site_deid_df = pd.read_csv("/app/data/source_key.csv", header=0)
site_deid_dict = dict(zip(site_deid_df["s_name"],site_deid_df["s_key"]))
person_ct_dict = dict(zip(persons_omop_df["site"],persons_omop_df["count_person"]))
note_ct_dict = dict(zip(persons_omop_df["site"],persons_omop_df["count_note"]))

# Use maps to remove site names
counts_df.loc[:, "trg_container_deid"] = counts_df.trg_container.map(site_deid_dict)
counts_df.loc[counts_df["modality"]=="OMOP", "total_individuals"] = counts_df.trg_container.map(person_ct_dict)
counts_df.loc[counts_df["modality"]=="NOTE", "total_individuals"] = counts_df.trg_container.map(note_ct_dict)
demograph_df.loc[:, "src_name_deid"] = demograph_df.src_name.map(site_deid_dict)


def generate_patient_volume_heatmap( hm_click, view):
    """
    :param: hm_click: clickData from heatmap.
    :param: view: viewData from heatmap.

    :return: Patient volume annotated heatmap.
    """

    filtered_df = counts_df
    filtered_df["view_data"] = counts_df[view]
    x_axis = sorted(filtered_df["trg_container_deid"].unique())
    y_axis = sorted(filtered_df["modality"].unique())

    site = ""
    mode = ""
    shapes = []

    if hm_click is not None:
        site = hm_click["points"][0]["x"]
        mode = hm_click["points"][0]["y"]

        # Add shapes
        x0 = x_axis.index(int(site[-2:])) / len(x_axis)
        x1 = x0 + 1 / len(x_axis)
        y0 = y_axis.index(mode) / len(y_axis)
        y1 = y0 + 1 / len(y_axis)

        shapes = [
            dict(
                type="rect",
                xref="paper",
                yref="paper",
                x0=x0,
                x1=x1,
                y0=y0,
                y1=y1,
                line=dict(color="#ff6347"),
            )
        ]

    # Get z value : sum(number of records) based on x, y,

    z = np.zeros((4, 14))
    annotations = []

    for ind_y, mode_loop in enumerate(y_axis):
        filtered_mode = filtered_df[filtered_df["modality"] == mode_loop]
        for ind_x, site_loop in enumerate(x_axis):
            record_cnt = filtered_mode[filtered_mode["trg_container_deid"] == site_loop][
                "view_data"
            ].sum()
            z[ind_y][ind_x] = int(record_cnt)

            annotation_dict = dict(
                showarrow=False,
                text="<b>" + str(int(record_cnt)) + "<b>",
                xref="x",
                yref="y",
                x=site_loop-1,
                y=mode_loop,
                font=dict(family="sans-serif"),
            )
            # Highlight annotation text by self-click
            if site_loop == site and mode_loop == mode:
                annotation_dict.update(size=15, font=dict(color="#ff6347"))

            annotations.append(annotation_dict)

    # Heatmap
    hovertemplate = "<b> %{y}  %{x} <br><br> %{z} "

    data = [
        dict(
            x=["Site " + str(n) for n in x_axis] ,
            y=y_axis,
            z=z,
            type="heatmap",
            name="",
            hovertemplate=hovertemplate,
            showscale=False,
            #colorscale="Primary"
            colorscale=[[0, "#f5f5f5"], [0.01, "#FBD1AF"], [1, "#FB6F01"]],
        )
    ]

    layout = dict(
        margin=dict(l=50, b=30, t=30, r=30),
        modebar={"orientation": "v"},
        font=dict(family="Open Sans"),
        annotations=annotations,
        shapes=shapes,
        xaxis=dict(
            side="top",
            ticks="",
            ticklen=2,
            tickfont=dict(family="sans-serif"),
            tickcolor="#ffffff",
        ),
        yaxis=dict(
            side="left", ticks="", tickfont=dict(family="sans-serif"), ticksuffix=" "
        ),
        hovermode="closest",
        showlegend=False,
    )
    return {"data": data, "layout": layout}



@app.callback(
    Output("patient_volume_hm", "figure"),
    [

        Input("patient_volume_hm", "clickData"),
        Input("data-select", "value"),
    ],
)
def update_heatmap(hm_click, view):
    # Find which one has been triggered
    ctx = dash.callback_context

    if ctx.triggered:
        prop_id = ctx.triggered[0]["prop_id"].split(".")[0]

    return generate_patient_volume_heatmap(
        hm_click, view
    )

def make_overview_grid():
    df_small = counts_df[["modality", "total_files", "total_individuals", "total_size_gb"]]
    df_small_grouped = df_small.groupby("modality", as_index=False).sum().sort_values(by="modality", ascending=False)
    grid = dag.AgGrid(
        id="grid-overview",
        rowData=df_small_grouped.to_dict("records"),
        columnDefs= [{"field": "modality", "wrapText": False, "filter": False, "floatingFilter": False, "initialWidth": 120 },
                     {"field": "total_individuals", "wrapText": False, "filter": False, "floatingFilter": False, "initialWidth": 140 },
                     {"field": "total_files", "wrapText": False, "filter": False, "floatingFilter": False, "initialWidth": 105 },
                     {"field": "total_size_gb", "wrapText": False, "filter": False, "floatingFilter": False, "initialWidth": 130 },],
        dashGridOptions={"rowHeight": 25},
        rowClassRules = {"bg-secondary text-dark bg-opacity-25": "params.node.rowPinned === 'top' | params.node.rowPinned === 'bottom'"},
        style={"height": 150, "width": "100%"}
    )
    return grid

def make_access_grid():
    grid = dag.AgGrid(
        id="grid-access",
        rowData=access_df.to_dict("records"),
        columnDefs= [{"field": "context", "wrapText": False, "filter": False, "floatingFilter": False, "initialWidth": 350 },
                     {"field": "unique_users", "wrapText": False, "filter": False, "floatingFilter": False, "initialWidth": 140 },],
        dashGridOptions={"rowHeight": 25},
        rowClassRules = {"bg-secondary text-dark bg-opacity-25": "params.node.rowPinned === 'top' | params.node.rowPinned === 'bottom'"},
        style={"height": 200, "width": "100%"}
    )
    return grid

def make_condition_grid():
    grid = dag.AgGrid(
        id="grid-condition",
        rowData=conditions_df.to_dict("records"),
        #CONCEPT_ID, CONCEPT_NAME, NUM_PERSONS, PERCENT_PERSONS, RECORDS_PER_PERSON, PERCENT_PERSONS_NTILE,
        #RECORDS_PER_PERSON_NTILE
        columnDefs= [{"field": "concept_id", "filter": True, "floatingFilter": True, "initialWidth": 140 },
                     {"field": "concept_name", "filter": True, "floatingFilter": True, "initialWidth": 200 },
                     {"field": "num_persons", "filter": False, "floatingFilter": False, "initialWidth": 140 },],
                     #{"field": "PERCENT_PERSONS", "filter": False, "floatingFilter": False, "initialWidth": 150},
                     #{"field": "RECORDS_PER_PERSON", "filter": False, "floatingFilter": False, "initialWidth": 150 }],
        #defaultColDef={"filter": True, "floatingFilter": True,  "wrapHeaderText": True, "autoHeaderHeight": True, "initialWidth": 150 },
        dashGridOptions={"rowHeight": 25},
        rowClassRules = {"bg-secondary text-dark bg-opacity-25": "params.node.rowPinned === 'top' | params.node.rowPinned === 'bottom'"},
        style={"height": 300, "width": "100%"}
    )
    return grid

container_dropdown = html.Div(
    [
        dbc.Label("Select a View", html_for="container_dropdown"),
        dcc.Dropdown(
            id="data-select",
            options=[{"label": "By Individuals (# Unique)", "value": "total_individuals"},
                    {"label": "By Data Size (GB)", "value": "total_size_gb"},
                    {"label": "By Files (#)", "value": "total_files"}],
            value="total_individuals",
            clearable=False,
            maxHeight=600,
            optionHeight=30
        ),
    ],  className="mb-4",)

def description_card():
    """

    :return: A Div containing dashboard title & descriptions.
    """
    return html.Div(
        id="description-card",
        children=[
            html.B("Central Data Summary"),
            make_overview_grid(),
            html.Br(),
            html.Hr(),
            html.B("User Access Details"),
            make_access_grid(),
            html.Br(),
            html.Hr(),
            html.B("Search Diagnoses in Data"),
            make_condition_grid(),
        ],
        style={"width": "100%"},
    )

sex_df = demograph_df.loc[(demograph_df["sex_name"]=="MALE") | (demograph_df["sex_name"]=="FEMALE"), ["sex_name", "age"]]

layout = go.Layout(barmode='overlay',
                   paper_bgcolor='rgb(255, 255, 255)',
                   plot_bgcolor='rgb(255, 255, 255)',
                   yaxis=go.layout.YAxis(range=[0, 100], title='Age'),
                   xaxis=go.layout.XAxis(
                   range=[-2000, 2000],
                   tickvals=[-2000, -1600, -1200, -800, -400, 0, 400, 800, 1200, 1600, 2000],
                   ticktext=[2000, 1600, 1200, 800, 400, 0, 400, 800, 1200, 1600, 2000]),
                    margin = dict(
                        l=20,
                        r=20,
                        b=20,
                        t=20,
                    ),
)

data = [go.Histogram(
    y=sex_df.loc[sex_df["sex_name"] == "MALE", "age"],
    orientation='h',
    name='Men',
    marker=dict(color='plum'),
    nbinsy=48,
),
    go.Histogram(
        y=sex_df.loc[sex_df["sex_name"] == "FEMALE", "age"],
        orientation='h',
        name='Women',
        marker=dict(color='purple'),
        nbinsy=48,
        x=-1 * np.ones(len(sex_df.loc[sex_df["sex_name"] == "FEMALE", "age"])),
        histfunc="sum"
    )
]

fig_2 = go.Figure(data=data, layout=layout)


def get_race_box():
    race_df = demograph_df[(demograph_df["race_name"]!="Unknown") &
                           (demograph_df["race_name"]!="No matching concept") &
                           (demograph_df["race_name"]!="Other")  &
                           (demograph_df["race_name"]!="Vitals | Output | Urine Occurrence (unmeasured)") &
                            (demograph_df["race_name"]!="Refuse to answer") &
                           (demograph_df["race_name"]!="Japanese") &
                           (demograph_df["race_name"]!="Korean")
                           ]
    fig_1 = go.Figure()

    for race in race_df["race_name"].unique():
        fig_1.add_trace(go.Box(
            y=race_df.loc[race_df["race_name"] == race, "age"],
            name=race,
            whiskerwidth=0.2,
            marker_size=2,
            line_width=1,
           )
        )

    fig_1.update_layout(
        yaxis=dict(
            autorange=True,
            showgrid=False,
            zeroline=False,
            dtick=20,
            gridcolor='rgb(255, 255, 255)',
            gridwidth=1,
            zerolinecolor='rgb(255, 255, 255)',
            zerolinewidth=2,
            title='Age'
        ),
        xaxis=dict(
                           tickvals=None,
                           ticktext=None,
                           title='Race'),
        margin=dict(
            l=20,
            r=20,
            b=20,
            t=20,
        ),
        paper_bgcolor='rgb(255, 255, 255)',
        plot_bgcolor='rgb(255, 255, 255)',
        showlegend=True
    )
    fig_1.update_xaxes(showticklabels=False) # Hide x axis ticks
    return fig_1

# Create box plot
def get_eth_box():
    ethnicity_df = demograph_df[(demograph_df["ethnicity_name"]!="Unknown") & (demograph_df["ethnicity_name"]!="No matching concept") & (demograph_df["ethnicity_name"]!="Other")  & (demograph_df["ethnicity_name"]!="Liberians")]
    fig_3 = go.Figure()

    for ethnicity in ethnicity_df["ethnicity_name"].unique():
        fig_3.add_trace(go.Box(
            y=ethnicity_df.loc[ethnicity_df["ethnicity_name"] == ethnicity, "age"],
            name=ethnicity,
            whiskerwidth=0.2,
            marker_size=2,
            line_width=1,
           )
        )

    fig_3.update_layout(
        yaxis=dict(
            autorange=True,
            showgrid=False,
            zeroline=False,
            dtick=20,
            gridcolor='rgb(255, 255, 255)',
            gridwidth=1,
            zerolinecolor='rgb(255, 255, 255)',
            zerolinewidth=2,
            title='Age'
        ),
        xaxis=dict(
                           tickvals=None,
                           ticktext=None,
                           title='Ethnicity'),
        margin=dict(
            l=20,
            r=20,
            b=20,
            t=20,
        ),
        paper_bgcolor='rgb(255, 255, 255)',
        plot_bgcolor='rgb(255, 255, 255)',
        showlegend=True
    )
    fig_3.update_xaxes(showticklabels=False) # Hide x axis ticks
    return fig_3

app.layout = html.Div(
    id="app-container",
    children=[
        # Banner
        html.Div(
            id="banner",
            className="banner",
            children=[html.Img(src=app.get_asset_url("chorus_multicolor.png")), html.H6("Bridge2AI for Clinical Care")],
        ),
        # Left column
        html.Div(
            id="left-column",
            className="four columns",
            children=
            [description_card()]
            ,
        ),
        # Right column
        html.Div(
            id="right-column",
            className="eight columns",
            children=[
                # Patient Volume Heatmap
                html.Div(
                    id="patient_volume_card",
                    children=[
                        html.B("Data Availability Matrix"),
                        container_dropdown,
                        html.Hr(),
                        dcc.Graph(id="patient_volume_hm", style={"width": "100%", "height": "250px"}),
                        html.Br(),
                        html.Hr(),
                        html.Div([
                            html.Div([
                                html.B('Data Demographics'),
                                dcc.Graph(id='g1', figure=fig_2, style={"width": "100%", "height": "200px"})
                            ], className="six columns"),
                            html.Div([
                                dcc.Graph(id='g2', figure=get_eth_box(), style={"width": "100%", "height": "200px"})
                            ], className="six columns"),
                        ], className="row", style={"width": "100%", "height": "210px"}),
                        html.Br(),
                        html.Hr(),
                        html.Div([
                                dcc.Graph(id='g3', figure=get_race_box(), style={"width": "100%", "height": "200px"})
                            ], className="row", style={"width": "100%", "height": "210px"}),
                    ],
                ),
            ],
        ),
    ],
)





if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
