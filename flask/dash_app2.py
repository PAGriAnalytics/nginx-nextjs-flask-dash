# dash_app2.py
import dash
from dash import html, dcc, Input, Output
import plotly.express as px
import pandas as pd

def init_dash(server):
    dash_app2 = dash.Dash(__name__, server=server, url_base_pathname='/api/dash2/')

    dash_app2.layout = html.Div([
        html.H1('Dash App 2'),
        dcc.Graph(id='graph2'),
        dcc.Interval(id='interval2', interval=600000)
    ])

    @dash_app2.callback(
        Output('graph2', 'figure'),
        [Input('interval2', 'n_intervals')]
    )
    def update_graph2(n):
        df = pd.DataFrame({
            'x': [1, 2, 3],
            'y': [1, 2, 3]
        })
        fig = px.line(df, x='x', y='y')
        return fig

