from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_operativos_por_ano(request):
    anos_disponiveis = HistoricoPassageirosTransportados.objects.values_list('ano', flat=True).distinct().order_by('ano')
    ano_selecionado = int(request.GET.get('ano', 2024))

    ###################### HistoricoPassageirosTransportados

    hist_pax_transp_filtrado = HistoricoPassageirosTransportados.objects.filter(ano=ano_selecionado).order_by('mes')

    if hist_pax_transp_filtrado.exists():
        hist_pax_transp_dataframe = pandas.DataFrame(list(hist_pax_transp_filtrado.values('ano', 'mes', 'passageiros')))
        hist_pax_transp_dataframe['mes'] = hist_pax_transp_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_hist_pax_transp = plotxp.line(
            hist_pax_transp_dataframe, 
            x='mes', 
            y='passageiros', 
            markers=True, 
            title='Passageiros Transportados em Milhões',
            width=600
        )
        grafico_hist_pax_transp.update_layout(xaxis_title='Mês', yaxis_title='Passageiros')
        grafico_hist_pax_transp = grafico_hist_pax_transp.to_html(full_html=False)
    else:
        grafico_hist_pax_transp = None

    ###################### HistoricoQuilometragemPercorrida

    hist_kmt_perc_filtrado = HistoricoQuilometragemPercorrida.objects.filter(ano=ano_selecionado).order_by('mes')

    if hist_kmt_perc_filtrado.exists():
        hist_kmt_perc_dataframe = pandas.DataFrame(list(hist_kmt_perc_filtrado.values('ano', 'mes', 'quilometragem')))
        hist_kmt_perc_dataframe['mes'] = hist_kmt_perc_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_kmt_perc_transp = plotxp.line(
            hist_kmt_perc_dataframe, 
            x='mes', 
            y='quilometragem', 
            markers=True, 
            title='Quilometragem Percorrida em Milhões'
        )
        grafico_kmt_perc_transp.update_layout(xaxis_title='Mês', yaxis_title='KMs')
        grafico_kmt_perc_transp = grafico_kmt_perc_transp.to_html(full_html=False)
    else:
        grafico_kmt_perc_transp = None

    return render(request, 'dash-operativo.html', {
        'anos': anos_disponiveis,
        'ano_selecionado': ano_selecionado,
        'grafico_hist_pax_transp': grafico_hist_pax_transp,
        'grafico_kmt_perc_transp': grafico_kmt_perc_transp,
    })