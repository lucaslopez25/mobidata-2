from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_operativos_historico(request):
    titulo_da_pagina = "Dados Operacionais (Histórico)"
    exportar_sql_csv_ativado = False
    selecionar_ano_ativado = False

    ###################### HistoricoPassageirosTransportados

    hist_pax_transp = HistoricoPassageirosTransportados.objects.all().order_by('ano', 'mes')

    if hist_pax_transp.exists():
        hist_pax_transp_dataframe = pandas.DataFrame(list(hist_pax_transp.values('ano', 'mes', 'passageiros')))
        hist_pax_transp_dataframe['mes'] = hist_pax_transp_dataframe['mes'].apply(lambda x: f"{x:02d}")
        hist_pax_transp_dataframe['periodo'] = hist_pax_transp_dataframe['ano'].astype(str) + '-' + hist_pax_transp_dataframe['mes']

        grafico_hist_pax_transp = plotxp.line(
            hist_pax_transp_dataframe, 
            x='periodo', 
            y='passageiros', 
            markers=True, 
            title='Passageiros Transportados em Milhões'
        )
        grafico_hist_pax_transp.update_layout(xaxis_title='Período (Ano-Mês)', yaxis_title='Passageiros')
        grafico_hist_pax_transp = grafico_hist_pax_transp.to_html(full_html=False)
    else:
        grafico_hist_pax_transp = None

    ###################### HistoricoQuilometragemPercorrida

    hist_kmt_perc = HistoricoQuilometragemPercorrida.objects.all().order_by('ano', 'mes')

    if hist_kmt_perc.exists():
        hist_kmt_perc_dataframe = pandas.DataFrame(list(hist_kmt_perc.values('ano', 'mes', 'quilometragem')))
        hist_kmt_perc_dataframe['mes'] = hist_kmt_perc_dataframe['mes'].apply(lambda x: f"{x:02d}")
        hist_kmt_perc_dataframe['periodo'] = hist_kmt_perc_dataframe['ano'].astype(str) + '-' + hist_kmt_perc_dataframe['mes']

        grafico_kmt_perc_transp = plotxp.line(
            hist_kmt_perc_dataframe, 
            x='periodo', 
            y='quilometragem', 
            markers=True, 
            title='Quilometragem Percorrida em Milhões'
        )
        grafico_kmt_perc_transp.update_layout(xaxis_title='Período (Ano-Mês)', yaxis_title='KMs')
        grafico_kmt_perc_transp = grafico_kmt_perc_transp.to_html(full_html=False)
    else:
        grafico_kmt_perc_transp = None

    ###################### Render

    return render(request, 'dash-operativo.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'selecionar_ano_ativado': selecionar_ano_ativado,
        'grafico_hist_pax_transp': grafico_hist_pax_transp,
        'grafico_kmt_perc_transp': grafico_kmt_perc_transp,
    })
