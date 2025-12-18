from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def climatizacao_frota(request):
    titulo_da_pagina = "Climatização da Frota (STCO)"

    cores_concessionarias = {
        'SPE1': '#1631cc', #Salvador Norte
        'SPE2': '#26ae00', #OT Trans
        'SPE3': '#ffc600', #Plataforma
        'BRT1': '#192c96', #BRT
        'STEC': '#ea5a17', #STEC
        'STCO': '#808080', #Total das Concessionárias - SPE1 + SPE2 + SPE3
        'TOTL': '#404040', #Total Geral STCO + BRT + STEC
    }

    ar_cond = ArCondicionadoStco.objects.all().order_by('ano')

    grafico_ar_cond_pct = None
    grafico_ar_cond_abs = None

    if ar_cond.exists():
        df_ar = pandas.DataFrame(list(ar_cond.values(
            'ano', 'id_concessionaria', 'qtd_frota_total', 
            'qtd_frota_com_ar_condicionado', 'pct_frota_com_ar_condicionado'
        )))

        # Gráfico 1: Percentual da frota com Ar Condicionado (Linha)
        grafico_ar_cond_pct = plotxp.line(
            df_ar,
            x='ano',
            y='pct_frota_com_ar_condicionado',
            color='id_concessionaria',
            markers=True,
            title='Percentual da Frota com Ar Condicionado por Ano',
            labels={
                'id_concessionaria': 'Concessionária',
                'ano': 'Ano',
                'pct_frota_com_ar_condicionado': 'Percentual com Ar (%)',
            },
            color_discrete_map=cores_concessionarias
        )
        grafico_ar_cond_pct.update_layout(
            xaxis=dict(tickmode='array', tickvals=df_ar['ano'].unique()),
            xaxis_title='Ano', 
            yaxis_title='Percentual (%)'
        )
        grafico_ar_cond_pct = grafico_ar_cond_pct.to_html(full_html=False)

        # Gráfico 2: Quantidade absoluta da frota com Ar Condicionado (Barra)
        grafico_ar_cond_abs = plotxp.bar(
            df_ar,
            x='ano',
            y='qtd_frota_com_ar_condicionado',
            color='id_concessionaria',
            barmode='stack',
            title='Frota com Ar Condicionado por Ano (Absoluto)',
            labels={
                'id_concessionaria': 'Concessionária',
                'ano': 'Ano',
                'qtd_frota_com_ar_condicionado': 'Quantidade com Ar',
            },
            color_discrete_map=cores_concessionarias
        )
        grafico_ar_cond_abs.update_layout(
            xaxis=dict(tickmode='array', tickvals=df_ar['ano'].unique()),
            xaxis_title='Ano', 
            yaxis_title='Quantidade de Veículos'
        )
        grafico_ar_cond_abs = grafico_ar_cond_abs.to_html(full_html=False)

    return render(request, 'stco/climatizacao-frota.html', {
        'titulo_da_pagina': titulo_da_pagina,
        
        'grafico_ar_cond_pct': grafico_ar_cond_pct,
        'grafico_ar_cond_abs': grafico_ar_cond_abs,
    })