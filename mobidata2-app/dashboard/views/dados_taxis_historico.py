from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_taxis_historico(request):
    titulo_da_pagina = "Frota de Táxis - Salvador (Histórico)"
    exportar_sql_csv_ativado = False
    selecionar_ano_ativado = False

    ###################### FrotaDeTaxis - Histórico completo

    frota_taxis = FrotaDeTaxis.objects.all().order_by('ano')
    if frota_taxis.exists():
        frota_dataframe = pandas.DataFrame(list(frota_taxis.values(
            'ano', 'taxis_comum_autonomos', 'taxis_comum_empresas', 'taxis_especiais'
        )))
        frota_dataframe = frota_dataframe.melt(
            id_vars='ano',
            value_vars=['taxis_comum_autonomos', 'taxis_comum_empresas', 'taxis_especiais'],
            var_name='Tipo',
            value_name='Quantidade'
        )
        frota_dataframe['Tipo'] = frota_dataframe['Tipo'].map({
            'taxis_comum_autonomos': 'Táxis Comuns (Autônomos)',
            'taxis_comum_empresas': 'Táxis Comuns (Empresas)',
            'taxis_especiais': 'Táxis Especiais'
        })

        grafico_frota_taxis = plotxp.bar(
            frota_dataframe,
            x='ano',
            y='Quantidade',
            color='Tipo',
            barmode='group',
            title='Distribuição da Frota de Táxis'
        )
        grafico_frota_taxis.update_layout(xaxis_title='Ano', yaxis_title='Quantidade')
        grafico_frota_taxis = grafico_frota_taxis.to_html(full_html=False)
    else:
        grafico_frota_taxis = None

    ###################### Táxis por Combustível

    taxis_combustivel = TaxisPorCombustivel.objects.all().order_by('ano')
    if taxis_combustivel.exists():
        combustivel_dataframe = pandas.DataFrame(list(taxis_combustivel.values('ano', 'tipo_combustivel', 'quantidade')))
        grafico_taxis_combustivel = plotxp.bar(
            combustivel_dataframe,
            x='ano',
            y='quantidade',
            color='tipo_combustivel',
            barmode='stack',
            title='Táxis por Tipo de Combustível ao Longo dos Anos',
        )
        grafico_taxis_combustivel.update_layout(xaxis_title='Ano', yaxis_title='Quantidade')
        grafico_taxis_combustivel = grafico_taxis_combustivel.to_html(full_html=False)
    else:
        grafico_taxis_combustivel = None

    ###################### Idade Média da Frota de Táxis

    idade_media_frota_taxis = IdadeMediaDaFrotaDeTaxis.objects.all().order_by('ano')
    if idade_media_frota_taxis.exists():
        idade_media_frota_taxis_dataframe = pandas.DataFrame(list(idade_media_frota_taxis.values('ano', 'idade_media')))
        grafico_idade_media_frota_taxis = plotxp.line(
            idade_media_frota_taxis_dataframe,
            x='ano',
            y='idade_media',
            markers=True,
            title='Idade Média da Frota de Táxis ao Longo dos Anos'
        )
        grafico_idade_media_frota_taxis.update_layout(yaxis_title='Idade Média (anos)')
        grafico_idade_media_frota_taxis = grafico_idade_media_frota_taxis.to_html(full_html=False)
    else:
        grafico_idade_media_frota_taxis = None

    ###################### TiposVeiculosServicoTaxis

    taxis_por_marca = TiposVeiculosServicoTaxis.objects.all().order_by('ano_registro', 'mes_registro')
    if taxis_por_marca.exists():
        taxis_por_marca_dataframe = pandas.DataFrame(list(taxis_por_marca.values(
            'ano_registro', 'mes_registro', 'marca', 'modelo', 'quantidade'
        )))
        taxis_por_marca_dataframe['período'] = taxis_por_marca_dataframe['ano_registro'].astype(str) + '-' + taxis_por_marca_dataframe['mes_registro'].apply(lambda x: f'{x:02d}')
        taxis_por_marca_dataframe['modelo_completo'] = taxis_por_marca_dataframe['marca'] + ' - ' + taxis_por_marca_dataframe['modelo']

        grafico_taxis_por_marca = plotxp.line(
            taxis_por_marca_dataframe,
            x='período',
            y='quantidade',
            color='modelo_completo',
            markers=True,
            title='Modelos de Veículos Utilizados ao Longo do Tempo'
        )
        grafico_taxis_por_marca.update_layout(xaxis_title='Período', yaxis_title='Quantidade')
        grafico_taxis_por_marca = grafico_taxis_por_marca.to_html(full_html=False)
    else:
        grafico_taxis_por_marca = None


    return render(request, 'dash-taxis.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'selecionar_ano_ativado': selecionar_ano_ativado,
        'grafico_frota_taxis': grafico_frota_taxis,
        'grafico_taxis_combustivel': grafico_taxis_combustivel,
        'grafico_idade_media_frota_taxis': grafico_idade_media_frota_taxis,
        'grafico_taxis_por_marca': grafico_taxis_por_marca,
    })