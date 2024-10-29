import dash
from dash import html, dcc, Input, Output
import plotly.express as px
import pandas as pd

def init_dash(server):
    dash_app1 = dash.Dash(__name__, server=server, url_base_pathname='/api/dash1/')

    dash_app1.layout = html.Div([
        html.H1('Dash App1'),
        dcc.Graph(id='graph1'),
        dcc.Interval(id='interval1', interval=600000)
    ])

    @dash_app1.callback(
        Output('graph1', 'figure'),
        [Input('interval1', 'n_intervals')]
    )
    def update_graph1(n):
        df = pd.DataFrame({
            'x': [1, 2, 3],
            'y': [1, 2, 3]
        })
        fig = px.line(df, x='x', y='y')
        return fig
