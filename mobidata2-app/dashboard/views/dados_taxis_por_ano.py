from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_taxis_por_ano(request):
    titulo_da_pagina = "Frota de Táxis - Salvador (Ano a Ano)"
    exportar_sql_csv_ativado = False
    selecionar_ano_ativado = True

    anos_disponiveis = FrotaDeTaxis.objects.values_list('ano', flat=True).distinct().order_by('ano')
    ano_selecionado = int(request.GET.get('ano', anos_disponiveis.last()))

    ###################### FrotaDeTaxis

    frota_taxis_filtrado = FrotaDeTaxis.objects.filter(ano=ano_selecionado).first()

    if frota_taxis_filtrado:
        frota_taxis_labels = ['Táxis Comuns (Autônomos)', 'Táxis Comuns (Empresas)', 'Táxis Especiais']
        frota_taxis_values = [frota_taxis_filtrado.taxis_comum_autonomos, frota_taxis_filtrado.taxis_comum_empresas, frota_taxis_filtrado.taxis_especiais]

        frota_taxis_dataframe = pandas.DataFrame({'Tipo': frota_taxis_labels, 'Quantidade': frota_taxis_values})

        grafico_frota_taxis = plotxp.pie(
            frota_taxis_dataframe, 
            values='Quantidade',
            names='Tipo',
            title=f'Distribuição da Frota de Táxis - {ano_selecionado}',
        )
        grafico_frota_taxis.update_traces(textinfo='percent+label')
        grafico_frota_taxis = grafico_frota_taxis.to_html(full_html=False)
    else:
        grafico_frota_taxis = None

    ###################### Táxis por Combustível

    taxis_combustivel_filtrado = TaxisPorCombustivel.objects.filter(ano=ano_selecionado)
    if taxis_combustivel_filtrado.exists():
        combustivel_dataframe = pandas.DataFrame(list(taxis_combustivel_filtrado.values('tipo_combustivel', 'quantidade')))

        grafico_taxis_combustivel = plotxp.pie(
            combustivel_dataframe,
            names='tipo_combustivel',
            values='quantidade',
            title=f'Táxis por Tipo de Combustível - {ano_selecionado}',
        )
        grafico_taxis_combustivel.update_traces(textinfo='percent+label')
        grafico_taxis_combustivel = grafico_taxis_combustivel.to_html(full_html=False)
    else:
        grafico_taxis_combustivel = None

    ###################### Idade Média da Frota de Táxis

    idade_media_frota_taxis_filtrado = IdadeMediaDaFrotaDeTaxis.objects.filter(ano=ano_selecionado).first()
    if idade_media_frota_taxis_filtrado:
        idade_media_frota_taxis_dataframe = pandas.DataFrame([{
            'Ano': ano_selecionado,
            'Idade Média': idade_media_frota_taxis_filtrado.idade_media
        }])
        grafico_idade_media_frota_taxis = plotxp.bar(
            idade_media_frota_taxis_dataframe,
            x='Ano',
            y='Idade Média',
            title=f'Idade Média da Frota de Táxis - {ano_selecionado}'
        )
        grafico_idade_media_frota_taxis.update_layout(yaxis_title='Idade em anos')
        grafico_idade_media_frota_taxis = grafico_idade_media_frota_taxis.to_html(full_html=False)
    else:
        grafico_idade_media_frota_taxis = None

    ###################### TiposVeiculosServicoTaxis

    taxis_por_marca_filtrado = TiposVeiculosServicoTaxis.objects.filter(ano_registro=ano_selecionado)
    if taxis_por_marca_filtrado.exists():
        taxis_por_marca_dataframe = pandas.DataFrame(list(taxis_por_marca_filtrado.values('marca', 'modelo', 'quantidade')))
        taxis_por_marca_dataframe['modelo_completo'] = taxis_por_marca_dataframe['marca'] + ' - ' + taxis_por_marca_dataframe['modelo']

        grafico_taxis_por_marca = plotxp.bar(
            taxis_por_marca_dataframe,
            x='modelo_completo',
            y='quantidade',
            title=f'Modelos de Veículos Utilizados - {ano_selecionado}',
        )
        grafico_taxis_por_marca.update_layout(xaxis_title='Modelo', yaxis_title='Quantidade', xaxis_tickangle=-45)
        grafico_taxis_por_marca = grafico_taxis_por_marca.to_html(full_html=False)
    else:
        grafico_taxis_por_marca = None

    return render(request, 'dash-taxis.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'selecionar_ano_ativado': selecionar_ano_ativado,
        'anos': anos_disponiveis,
        'ano_selecionado': ano_selecionado,
        'grafico_frota_taxis': grafico_frota_taxis,
        'grafico_taxis_combustivel': grafico_taxis_combustivel,
        'grafico_idade_media_frota_taxis': grafico_idade_media_frota_taxis,
        'grafico_taxis_por_marca': grafico_taxis_por_marca,
    })