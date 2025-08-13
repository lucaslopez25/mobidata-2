from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

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
    dados_mes = HistoricoPassageirosTransportadosMetroMes.objects.all().order_by('ano', 'mes')
    df_mes = pandas.DataFrame(list(dados_mes.values('ano', 'mes', 'passageiros')))

    if not df_mes.empty:
        df_mes['periodo'] = df_mes['ano'].astype(str) + '-' + df_mes['mes'].apply(lambda x: f"{x:02d}")
        grafico_mes = plotxp.line(
            df_mes,
            x='periodo',
            y='passageiros',
            title='Passageiros Transportados por Mês',
            labels={'periodo': 'Período', 'passageiros': 'Passageiros'},
        )
        grafico_mes.update_layout(xaxis_tickangle=-45)
        grafico_mes_html = grafico_mes.to_html(full_html=False)
    else:
        grafico_mes_html = None

    return render(request, 'dash-metro.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'grafico_ano': grafico_ano_html,
        'grafico_mes': grafico_mes_html
    })