from dashboard.models import HistoricoQuilometragemPercorrida

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_historico_km_percorridos():
    queryset = HistoricoQuilometragemPercorrida.objects.all().order_by('ano', 'mes')

    if not queryset.exists():
        return None

    df = pandas.DataFrame(list(queryset.values('ano', 'mes', 'quilometragem')))
    df['mes_str'] = df['mes'].apply(lambda x: f"{x:02d}")
    df['periodo'] = df['ano'].astype(str) + '-' + df['mes_str']

    fig = plotxp.line(
        df, 
        x='periodo', 
        y='quilometragem', 
        markers=True, 
        title='Quilometragem Percorrida em Milhões'
    )
    
    fig.update_layout(
        xaxis_title='Período (Ano-Mês)', 
        yaxis_title='Milhões de quilômetros (kms)',
        template='plotly_white'
    )
    
    return fig