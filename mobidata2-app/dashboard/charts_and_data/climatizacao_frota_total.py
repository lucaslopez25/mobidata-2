from dashboard.models import ArCondicionadoStco

import pandas # type: ignore
import plotly.graph_objects as go

def get_climatizacao_frota_total():
    dados_qs = ArCondicionadoStco.objects.all().order_by('ano')
    df = pandas.DataFrame(list(dados_qs.values('ano', 'id_concessionaria', 'pct_frota_com_ar_condicionado')))

    ###################### GRAFICO TOTAL SISTEMA
    df_stco = df[df['id_concessionaria'] == 'STCO']
    
    fig_total = go.Figure()
    fig_total.add_trace(go.Bar(
        y=df_stco['ano'].astype(str),
        x=df_stco['pct_frota_com_ar_condicionado'],
        orientation='h',
        text=df_stco['pct_frota_com_ar_condicionado'].apply(lambda x: f"{x}%"),
        textposition='auto',
        marker_color='#2c3e50',
        name='Total STCO'
    ))

    fig_total.update_layout(
        title="Percentual da Climatização Frota Total de Ônibus por Ano",
        xaxis=dict(title="Percentual (%)", range=[0, 100]),
        yaxis=dict(title="Ano", automargin=True), # Corrigido aqui
        height=450,
        template="plotly_white"
    )

    return fig_total