from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.graph_objects as go

def climatizacao_frota(request):
    titulo_da_pagina = "Climatização da Frota (STCO)"

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
        title="Evolução Climatização: Total do Sistema (STCO)",
        xaxis=dict(title="Percentual (%)", range=[0, 100]),
        yaxis=dict(title="Ano", automargin=True), # Corrigido aqui
        height=450,
        template="plotly_white"
    )

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
        title="Perspectiva por Operadora (2021-2024)",
        xaxis=dict(title="Percentual (%)", range=[0, 100]),
        yaxis=dict(title="Ano", automargin=True),
        barmode='group',
        height=600,
        legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1),
        template="plotly_white"
    )

    print("IDs encontrados no banco:", df['id_concessionaria'].unique())

    return render(request, 'stco/climatizacao-frota.html', {
        'titulo_da_pagina': titulo_da_pagina,
        
        'fig_total': fig_total.to_html(full_html=False),
        'fig_comp': fig_comp.to_html(full_html=False),
    })