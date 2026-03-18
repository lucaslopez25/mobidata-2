from dashboard.models import HistoricoPassageirosTransportados

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_historico_pax_transportados():
    queryset = HistoricoPassageirosTransportados.objects.all().order_by('ano', 'mes')

    if not queryset.exists():
        return None

    df = pandas.DataFrame(list(queryset.values('ano', 'mes', 'passageiros')))
    df['mes_str'] = df['mes'].apply(lambda x: f"{x:02d}")
    df['periodo'] = df['ano'].astype(str) + '-' + df['mes_str']

    fig = plotxp.line(
        df, 
        x='periodo', 
        y='passageiros', 
        markers=True, 
        title='Passageiros Transportados em Milhões'
    )
    
    fig.update_layout(
        xaxis_title='Período (Ano-Mês)', 
        yaxis_title='Passageiros',
        template='plotly_white'
    )
    
    return fig