from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *
from . import gerar_grafico_linhas_simples_por_ano_mes

import pandas # type: ignore
import plotly.express as plotxp # type: ignore


def dados_operativos(request):
    titulo_da_pagina = "Dados Operativos"
    exportar_sql_csv_ativado = False

    ###################### HistoricoPassageirosTransportados

    grafico_hist_pax_transp = gerar_grafico_linhas_simples_por_ano_mes(
        HistoricoPassageirosTransportados,
        'Passageiros',
        'Passageiros Transportados em Milhões',
        'passageiros'
    )

    ###################### HistoricoQuilometragemPercorrida

    grafico_kmt_perc_transp = gerar_grafico_linhas_simples_por_ano_mes(
        HistoricoQuilometragemPercorrida,
        'Quilômetros (kms)',
        'Quilometragem Percorrida em Milhões',
        'quilometragem'
    )

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
        'grafico_hist_pax_transp': grafico_hist_pax_transp,
        'grafico_kmt_perc_transp': grafico_kmt_perc_transp,
        'grafico_historico_corredores': grafico_historico_corredores,
        'anos_disponiveis_historico_corredores': anos_disponiveis_historico_corredores,
        'ano_selecionado_historico_corredores': ano_selecionado_historico_corredores,
    })
