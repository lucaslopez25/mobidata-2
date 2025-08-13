from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_operativos(request):
    titulo_da_pagina = "Dados Operativos"
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

    ###################### CorredoresDeOnibus

    anos_disponiveis_historico_corredores = CorredoresDeOnibus.objects.values_list('ano', flat=True).distinct().order_by('ano')

    ano_selecionado_historico_corredores = request.GET.get('ano_historico_corredores')
    if ano_selecionado_historico_corredores:
        ano_selecionado_historico_corredores = int(ano_selecionado_historico_corredores)
    else:
        ano_selecionado_historico_corredores = max(anos_disponiveis_historico_corredores) if anos_disponiveis_historico_corredores else None

    historico_corredores = CorredoresDeOnibus.objects.filter(ano=ano_selecionado_historico_corredores)

    if historico_corredores.exists():
        historico_corredores_dataframe = pandas.DataFrame(list(historico_corredores.values('nome_corredor', 'qtd_onibus_por_hora', 'extensao_em_kms', 'qtd_linhas_convencionais')))

        labels_indicadores = {
            'qtd_onibus_por_hora': 'Ônibus por Hora',
            'extensao_em_kms': 'Extensão (km)',
            'qtd_linhas_convencionais': 'Linhas Convencionais'
        }

        historico_corredores_dataframe_melt = historico_corredores_dataframe.melt(
            id_vars=['nome_corredor'],
            value_vars=['qtd_onibus_por_hora', 'extensao_em_kms', 'qtd_linhas_convencionais'],
            var_name='Indicador',
            value_name='Valor'
        )
        historico_corredores_dataframe_melt['Indicador'] = historico_corredores_dataframe_melt['Indicador'].map(labels_indicadores)

        grafico_historico_corredores = plotxp.bar(
            historico_corredores_dataframe_melt,
            x='nome_corredor',
            y='Valor',
            color='Indicador',
            barmode='group',
            title=f'Corredores de Ônibus - {ano_selecionado_historico_corredores}',
            labels={'nome_corredor': 'Corredor', 'Valor': 'Valor', 'Indicador': 'Indicador'}
        )

        grafico_historico_corredores.update_layout(yaxis_title='Valor', legend_title='Indicador')
        grafico_historico_corredores = grafico_historico_corredores.to_html(full_html=False)
    else:
        grafico_historico_corredores = None

    ###################### Render

    return render(request, 'dash-operativo.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'selecionar_ano_ativado': selecionar_ano_ativado,
        'grafico_hist_pax_transp': grafico_hist_pax_transp,
        'grafico_kmt_perc_transp': grafico_kmt_perc_transp,
        'grafico_historico_corredores': grafico_historico_corredores,
        'anos_disponiveis_historico_corredores': anos_disponiveis_historico_corredores,
        'ano_selecionado_historico_corredores': ano_selecionado_historico_corredores,
    })
