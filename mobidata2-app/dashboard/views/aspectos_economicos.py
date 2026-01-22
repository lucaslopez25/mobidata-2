from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

import psycopg2
import os

from dashboard.models import *
from . import gerar_grafico_indicador_financeiro, gerar_graficos_dados_stco

import pandas # type: ignore
import plotly.express as plotxp # type: ignore
import plotly.graph_objects as plotgo # type: ignore
from plotly.subplots import make_subplots # type: ignore

def aspectos_economicos(request):
    titulo_da_pagina = "Aspectos Econômicos"
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

    ###################### DadosStco

    pacote_dados_stco = gerar_graficos_dados_stco(DadosStco)

    ###################### analise_comparativa_stco

    # with connection.cursor() as cursor:
    #     cursor.callproc('analise_comparativa_stco')
    #     cursor.execute("SELECT ano, tarifa_sobre_sm, custo_operacional_por_km, comparativo_40_tarifas FROM resultado_analise ORDER BY ano;")
    #     rows = cursor.fetchall()
    #     cols = [col[0] for col in cursor.description]

    # 'ENGINE': 'django.db.backends.postgresql',
    # 'HOST': os.environ.get("DB_HOST"),
    # 'NAME': os.environ.get('DB_NAME_2'),
    # 'USER': os.environ.get("DB_USER"),
    # 'PASSWORD': os.environ.get("DB_PASSWORD"),

    conexao_com_a_database = psycopg2.connect(
        host=os.environ.get("DB_HOST"),
        database=os.environ.get('DB_NAME_2'),
        user=os.environ.get("DB_USER"),
        password=os.environ.get("DB_PASSWORD")
    )
    cursor = conexao_com_a_database.cursor()
    script_chamada_procedure = '''CALL analise_comparativa_stco();'''
    cursor.execute(script_chamada_procedure)
    cursor.execute("SELECT ano, salario_minimo_ano, tarifa_sobre_sm, custo_operacional_por_km, qtd_passagens_compra_um_sm FROM resultado_analise ORDER BY ano;")
    rows = cursor.fetchall()
    cols = [col[0] for col in cursor.description]
    cursor.close()
    conexao_com_a_database.close()

    dataframe_analise_comparativa_stco = pandas.DataFrame(rows, columns=cols)

    # plotxp.line(
    #     dataframe_analise_comparativa_stco,
    #     x="ano",
    #     y="tarifa_sobre_sm",
    #     markers=True,
    #     title="Análise Comparativa dos Dados Apresentados",
    #     labels={"ano": "Ano", "tarifa_sobre_sm": "% Tarifa / Salário Mínimo"},
    # )

    ######### Gráfico salário mínimo e quantidade de passagens

    grafico_salario_passagens = plotgo.Figure()
    grafico_salario_passagens.add_trace(plotgo.Scatter(
        x=dataframe_analise_comparativa_stco['ano'],
        y=dataframe_analise_comparativa_stco['salario_minimo_ano'],
        mode='lines+markers',
        name='Salário Mínimo (R$)',
        line=dict(color='orange')
    ))
    grafico_salario_passagens.add_trace(plotgo.Scatter(
        x=dataframe_analise_comparativa_stco['ano'],
        y=dataframe_analise_comparativa_stco['qtd_passagens_compra_um_sm'],
        mode='lines+markers',
        name='Qtd de Passagens com 1 SM',
        line=dict(color='green')
    ))
    grafico_salario_passagens.update_layout(
        title='Salário Mínimo e Quantidade de Passagens compráveis com um Salário Mínimo (baseado nos valores de passagens em reais por ano)',
        xaxis_title='Ano',
        yaxis_title='Valores (R$)',
        template='plotly_white'
    )

    ######### Gráfico custo operacional

    grafico_custo_operacional = plotgo.Figure()
    grafico_custo_operacional.add_trace(plotgo.Scatter(
        x=dataframe_analise_comparativa_stco['ano'],
        y=dataframe_analise_comparativa_stco['custo_operacional_por_km'],
        mode='lines+markers',
        name='Custo Operacional por KM (R$)',
        line=dict(color='red')
    ))
    grafico_custo_operacional.update_layout(
        title='Custo operacional do STCO por quilômetro rodado (em reais)',
        xaxis_title='Ano',
        yaxis_title='R$',
        template='plotly_white'
    )

    ######### Gráfico tarifa como pct do salário mínimo

    grafico_tarifa_percentual = plotgo.Figure()
    grafico_tarifa_percentual.add_trace(plotgo.Scatter(
        x=dataframe_analise_comparativa_stco['ano'],
        y=dataframe_analise_comparativa_stco['tarifa_sobre_sm'],
        mode='lines+markers',
        name='Tarifa/Salário Mínimo (%)',
        line=dict(color='blue')
    ))
    grafico_tarifa_percentual.update_layout(
        title='Tarifa como Percentual do Salário Mínimo',
        xaxis_title='Ano',
        yaxis_title='Percentual (%)',
        template='plotly_white'
    )

    grafico_salario_passagens = grafico_salario_passagens.to_html(full_html=False)
    grafico_custo_operacional = grafico_custo_operacional.to_html(full_html=False)
    grafico_tarifa_percentual = grafico_tarifa_percentual.to_html(full_html=False)

    return render(request, 'aspectos-economicos.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'grafico_indicadores_financeiros_stco': pacote_grafico_indicadores_financeiros_stco['model_grafico'],
        'lista_anos_indicador_financeiro': pacote_grafico_indicadores_financeiros_stco['lista_anos'],
        'lista_concessionarias_indicador_financeiro': pacote_grafico_indicadores_financeiros_stco['lista_concessionarias'],
        'ano_selecionado_indicador_financeiro': ano_selecionado_indicador_financeiro,
        'concessionaria_selecionada_indicador_financeiro': concessionaria_selecionada_indicador_financeiro,
        'grafico_salario_passagens': grafico_salario_passagens,
        'grafico_custo_operacional': grafico_custo_operacional,
        'grafico_tarifa_percentual': grafico_tarifa_percentual,
        'grafico_passageiros': pacote_dados_stco['grafico_passageiros'],
        'grafico_quilometragem': pacote_dados_stco['grafico_quilometragem'],
    })