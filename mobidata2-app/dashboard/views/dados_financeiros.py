from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *
from . import gerar_grafico_indicador_financeiro

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_financeiros(request):
    titulo_da_pagina = "Dados Financeiros"
    exportar_sql_csv_ativado = False

    ###################### IndicadoresFinanceirosStco

    ano_selecionado_indicador_financeiro = request.GET.get('ano_selecionado_indicador_financeiro')
    concessionaria_selecionada_indicador_financeiro = request.GET.get('concessionaria_selecionada_indicador_financeiro')

    if not ano_selecionado_indicador_financeiro and not concessionaria_selecionada_indicador_financeiro:
        ano_selecionado_indicador_financeiro = 2023

    pacote_grafico_indicadores_financeiros_stco = gerar_grafico_indicador_financeiro(
        IndicadoresFinanceirosStco, 
        ano_selecionado_indicador_financeiro, 
        concessionaria_selecionada_indicador_financeiro
    )

    print(pacote_grafico_indicadores_financeiros_stco['lista_anos'])
    print(pacote_grafico_indicadores_financeiros_stco['lista_concessionarias'])

    return render(request, 'dash-financeiro.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'grafico_indicadores_financeiros_stco': pacote_grafico_indicadores_financeiros_stco['model_grafico'],
        'lista_anos_indicador_financeiro': pacote_grafico_indicadores_financeiros_stco['lista_anos'],
        'lista_concessionarias_indicador_financeiro': pacote_grafico_indicadores_financeiros_stco['lista_concessionarias'],
        'ano_selecionado_indicador_financeiro': ano_selecionado_indicador_financeiro,
        'concessionaria_selecionada_indicador_financeiro': concessionaria_selecionada_indicador_financeiro,
    })