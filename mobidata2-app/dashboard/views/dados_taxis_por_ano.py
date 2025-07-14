from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_taxis_por_ano(request):
    anos_disponiveis = FrotaDeTaxis.objects.values_list('ano', flat=True).distinct().order_by('ano')
    ano_selecionado = int(request.GET.get('ano', anos_disponiveis.last()))

    ###################### FrotaDeTaxis

    # id_frota_taxis = models.AutoField(primary_key=True)
    # ano = models.IntegerField(blank=True, null=True)
    # taxis_comum_autonomos = models.IntegerField(blank=True, null=True)
    # taxis_comum_empresas = models.IntegerField(blank=True, null=True)
    # total_taxis_comum = models.IntegerField(blank=True, null=True)
    # taxis_especiais = models.IntegerField(blank=True, null=True)
    # total_geral = models.IntegerField(blank=True, null=True)

    frota_taxis_filtrado = FrotaDeTaxis.objects.filter(ano=ano_selecionado).first()
    print(frota_taxis_filtrado)

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

        print(grafico_frota_taxis)
    else:
        grafico_frota_taxis = None

    return render(request, 'dash-taxis.html', {
        'anos': anos_disponiveis,
        'ano_selecionado': ano_selecionado,
        'grafico_frota_taxis': grafico_frota_taxis,
    })