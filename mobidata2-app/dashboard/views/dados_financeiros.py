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

    dataframe_analise_comparativa_stco = pandas.DataFrame(rows, columns=cols)

    # plotxp.line(
    #     dataframe_analise_comparativa_stco,
    #     x="ano",
    #     y="tarifa_sobre_sm",
    #     markers=True,
    #     title="Análise Comparativa dos Dados Apresentados",
    #     labels={"ano": "Ano", "tarifa_sobre_sm": "% Tarifa / Salário Mínimo"},
    # )

    grafico_analise_comparativa_stco = make_subplots(specs=[[{"secondary_y": True}]])
    grafico_analise_comparativa_stco.add_trace(plotgo.Scatter(
            x=dataframe_analise_comparativa_stco['ano'],
            y=dataframe_analise_comparativa_stco['tarifa_sobre_sm'],
            mode='lines+markers',
            name='Tarifa/Salário Mínimo (%)',
            line=dict(color='blue')
        ),
        secondary_y=False
    )

    grafico_analise_comparativa_stco.add_trace(plotgo.Scatter(
            x=dataframe_analise_comparativa_stco['ano'],
            y=dataframe_analise_comparativa_stco['qtd_passagens_compra_um_sm'],
            mode='lines+markers',
            name='Quantidade de Passagens que 1 Salário Mínimo consegue comprar (R$)',
            line=dict(color='green')
        ),
        secondary_y=True
    )

    grafico_analise_comparativa_stco.add_trace(plotgo.Scatter(
            x=dataframe_analise_comparativa_stco['ano'],
            y=dataframe_analise_comparativa_stco['custo_operacional_por_km'],
            mode='lines+markers',
            name='Custo Operacional do STCO/KM (R$)',
            line=dict(color='red')
        ),
        secondary_y=True
    )

    grafico_analise_comparativa_stco.add_trace(plotgo.Scatter(
            x=dataframe_analise_comparativa_stco['ano'],
            y=dataframe_analise_comparativa_stco['salario_minimo_ano'],
            mode='lines+markers',
            name='Salário Mínimo (R$)',
            line=dict(color='orange')
        ),
        secondary_y=True
    )

    grafico_analise_comparativa_stco.update_layout(title='Análise Comparativa de dados STCO com dados econômicos', xaxis_title='Ano', template='plotly_white')
    grafico_analise_comparativa_stco.update_yaxes(title_text='Percentual', secondary_y=False)
    grafico_analise_comparativa_stco.update_yaxes(title_text='Reais (R$)', secondary_y=True)

    grafico_analise_comparativa_stco = grafico_analise_comparativa_stco.to_html(full_html=False)

    return render(request, 'dash-financeiro.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'grafico_indicadores_financeiros_stco': pacote_grafico_indicadores_financeiros_stco['model_grafico'],
        'lista_anos_indicador_financeiro': pacote_grafico_indicadores_financeiros_stco['lista_anos'],
        'lista_concessionarias_indicador_financeiro': pacote_grafico_indicadores_financeiros_stco['lista_concessionarias'],
        'ano_selecionado_indicador_financeiro': ano_selecionado_indicador_financeiro,
        'concessionaria_selecionada_indicador_financeiro': concessionaria_selecionada_indicador_financeiro,
        'grafico_analise_comparativa_stco': grafico_analise_comparativa_stco,
        'grafico_passageiros': pacote_dados_stco['grafico_passageiros'],
        'grafico_quilometragem': pacote_dados_stco['grafico_quilometragem'],
    })