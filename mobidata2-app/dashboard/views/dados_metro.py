from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *
from . import gerar_grafico_linhas_simples_por_ano_mes

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_metro(request):
    titulo_da_pagina = "Dados do Metrô"
    exportar_sql_csv_ativado = False

    ###################### DADOS ANUAIS

    dados_ano = HistoricoPassageirosTransportadosMetroAno.objects.all().order_by('ano')
    df_ano = pandas.DataFrame(list(dados_ano.values('ano', 'passageiros')))

    if not df_ano.empty:
        grafico_ano = plotxp.bar(
            df_ano,
            x='ano',
            y='passageiros',
            title='Passageiros Transportados por Ano',
            labels={'ano': 'Ano', 'passageiros': 'Passageiros'},
        )
        grafico_ano.update_layout(yaxis_title='Passageiros', xaxis_title='Ano')
        grafico_ano_html = grafico_ano.to_html(full_html=False)
    else:
        grafico_ano_html = None

    ###################### DADOS MENSAIS

    grafico_dados_metro_ano_mes = gerar_grafico_linhas_simples_por_ano_mes(
        HistoricoPassageirosTransportadosMetroMes,
        'Passageiros',
        'Total Mensal de Passageiros Transportados',
        'passageiros'
    )

    return render(request, 'dash-metro.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'grafico_ano': grafico_ano_html,
        'grafico_dados_metro_ano_mes': grafico_dados_metro_ano_mes,
    })