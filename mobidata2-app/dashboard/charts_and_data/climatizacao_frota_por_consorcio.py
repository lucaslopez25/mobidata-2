from dashboard.models import ArCondicionadoStco

import pandas # type: ignore
import plotly.graph_objects as go

def get_climatizacao_frota_por_consorcio():
    dados_qs = ArCondicionadoStco.objects.all().order_by('ano')
    df = pandas.DataFrame(list(dados_qs.values('ano', 'id_concessionaria', 'pct_frota_com_ar_condicionado')))

    ###################### GRAFICO POR CONSORCIO

    nomes_map = {'SPE2': 'OT Trans', 'SPE3': 'Plataforma'}
    cores_map = {'SPE2': '#26ae00', 'SPE3': '#ffc600'}
    
    fig_comp = go.Figure()
    
    for id_ref, full_name in nomes_map.items():
        df_filtro = df[df['id_concessionaria'] == id_ref]
        
        if not df_filtro.empty:
            fig_comp.add_trace(go.Bar(
                y=df_filtro['ano'].astype(str),
                x=df_filtro['pct_frota_com_ar_condicionado'],
                name=full_name,
                orientation='h',
                marker_color=cores_map.get(id_ref),
                text=df_filtro['pct_frota_com_ar_condicionado'].apply(lambda x: f"{x}%"),
                textposition='inside'
            ))

    fig_comp.update_layout(
        title="Percentual da Climatização Frota por Consórcio Operador de Ônibus por Ano",
        xaxis=dict(title="Percentual (%)", range=[0, 100]),
        yaxis=dict(title="Ano", automargin=True),
        barmode='group',
        height=600,
        legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1),
        template="plotly_white"
    )

    return fig_comp