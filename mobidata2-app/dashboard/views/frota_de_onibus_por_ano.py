from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def frota_de_onibus_por_ano(request):
    cores_concessionarias = {
        'SPE1': '#1631cc', #Salvador Norte
        'SPE2': '#26ae00', #OT Trans
        'SPE3': '#ffc600', #Plataforma
        'BRT1': '#192c96', #BRT
        'STEC': '#ea5a17', #STEC
        'STCO': '#808080', #Total das Concessionárias - SPE1 + SPE2 + SPE3
        'TOTL': '#404040', #Total Geral STCO + BRT + STEC
    }

    anos_disponiveis = HistoricoIdadeMediaFrota.objects.values_list('ano', flat=True).distinct().order_by('ano')
    ano_selecionado = int(request.GET.get('ano', 2024))

    ###################### HISTORICO DE IDADE MEDIA

    historico_filtrado = HistoricoIdadeMediaFrota.objects.filter(ano=ano_selecionado).order_by('mes')

    if historico_filtrado.exists():
        historico_dataframe = pandas.DataFrame(list(historico_filtrado.values('ano', 'mes', 'idade_media')))
        historico_dataframe['mes'] = historico_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_historico = plotxp.line(
            historico_dataframe, 
            x='mes', 
            y='idade_media', 
            markers=True, 
            title='Idade Média da Frota',
            width=630
        )
        grafico_historico.update_layout(xaxis_title='Mês', yaxis_title='Idade média em anos')
        grafico_historico = grafico_historico.to_html(full_html=False)
    else:
        grafico_historico = None

    ###################### AquisicoesDeOnibusPorMes

    aquisicoes = AquisicoesDeOnibusPorMes.objects.filter(ano=ano_selecionado).order_by('mes')

    if aquisicoes.exists():
        aquisicoes_dataframe = pandas.DataFrame(list(aquisicoes.values('ano','mes','id_concessionaria','qtd_onibus', 'novo_ou_usado')))
        aquisicoes_dataframe['mes'] = aquisicoes_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_aquisicoes = plotxp.bar(
            aquisicoes_dataframe,
            x='mes',
            y='qtd_onibus',
            color='id_concessionaria',
            barmode='stack',
            title='Aquisições de Ônibus por Mês',
            labels={
                'id_concessionaria': 'Concessionária', 
                'mes': 'Mês', 
                'qtd_onibus': 'Quantidade Total de Ônibus',
            },
            color_discrete_map=cores_concessionarias
        )
        grafico_aquisicoes.update_layout(xaxis_title='Mês', yaxis_title='Quantidade de ônibus adquiridos')
        grafico_aquisicoes = grafico_aquisicoes.to_html(full_html=False)
    else:
        grafico_aquisicoes = None

    ###################### FROTA TOTAL

    frota_total = FrotaTotal.objects.filter(ano=ano_selecionado).order_by('mes')
    
    if frota_total.exists():
        frota_total_dataframe = pandas.DataFrame(list(frota_total.values('ano', 'mes', 'id_concessionaria','qtd_total_de_onibus')))
        frota_total_dataframe['mes'] = frota_total_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_frota_total = plotxp.bar(
            frota_total_dataframe, 
            x='mes', 
            y='qtd_total_de_onibus', 
            color='id_concessionaria', 
            title='Frota Total de Ônibus',
            labels={
                'id_concessionaria': 'Concessionária', 
                'mes': 'Mês', 
                'qtd_total_de_onibus': 'Quantidade Total de Ônibus',
            },
            color_discrete_map=cores_concessionarias
        )
        grafico_frota_total.update_layout(xaxis_title='Mês', yaxis_title='Quantidade Total')
        grafico_frota_total = grafico_frota_total.to_html(full_html=False)
    else:
        grafico_frota_total = None

    ###################### FROTA OPERANTE

    frota_operante = FrotaOperante.objects.filter(ano=ano_selecionado).order_by('mes')
    
    if frota_operante.exists():
        frota_operante_dataframe = pandas.DataFrame(list(frota_operante.values('ano', 'mes', 'id_concessionaria','qtd_operante_de_onibus')))
        frota_operante_dataframe['mes'] = frota_operante_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_frota_operante = plotxp.bar(
            frota_operante_dataframe, x='mes', 
            y='qtd_operante_de_onibus', 
            color='id_concessionaria', 
            title='Frota Operante de Ônibus',
            labels={
                'id_concessionaria': 'Concessionária', 
                'mes': 'Mês', 
                'qtd_operante_de_onibus': 'Quantidade Operante',
            },
            color_discrete_map=cores_concessionarias
        )
        grafico_frota_operante.update_layout(xaxis_title='Mês', yaxis_title='Quantidade Operante')
        grafico_frota_operante = grafico_frota_operante.to_html(full_html=False)
    else:
        grafico_frota_operante = None

    ###################### RENDER

    return render(request, 'dash-onibus.html', {
        'anos': anos_disponiveis,
        'ano_selecionado': ano_selecionado,
        'grafico_historico': grafico_historico,
        'grafico_aquisicoes': grafico_aquisicoes,
        'grafico_frota_total': grafico_frota_total,
        'grafico_frota_operante': grafico_frota_operante,
    })