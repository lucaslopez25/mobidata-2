from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from .models import HistoricoIdadeMediaFrota
from .models import FrotaTotal

import pandas
import plotly.express as plotxp

def landing(request):
    return render(request, 'landing.html')

def frota_de_onibus_por_ano(request):
    anos_disponiveis = HistoricoIdadeMediaFrota.objects.values_list('ano', flat=True).distinct().order_by('ano')
    ano_selecionado = int(request.GET.get('ano', 2022))

    ###################### HISTORICO DE IDADE MEDIA

    historico_filtrado = HistoricoIdadeMediaFrota.objects.filter(ano=ano_selecionado).order_by('mes')

    if historico_filtrado.exists():
        historico_dataframe = pandas.DataFrame(list(historico_filtrado.values('ano', 'mes', 'idade_media')))
        historico_dataframe['mes'] = historico_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_historico = plotxp.line(historico_dataframe, x='mes', y='idade_media', markers=True, title=f'Idade Média da Frota - {ano_selecionado}')
        grafico_historico.update_layout(xaxis_title='Mês', yaxis_title='Idade Média (anos)')
        grafico_historico = grafico_historico.to_html(full_html=False)
    else:
        grafico_historico = None

    ###################### FROTA TOTAL

    frota_total = FrotaTotal.objects.filter(ano=ano_selecionado).order_by('mes')
    
    if frota_total.exists():
        frota_total_dataframe = pandas.DataFrame(list(frota_total.values('ano', 'mes', 'id_concessionaria','qtd_total_de_onibus')))
        frota_total_dataframe['mes'] = frota_total_dataframe['mes'].apply(lambda x: f"{x:02d}")

        grafico_frota_total = plotxp.bar(frota_total_dataframe, x='mes', y='qtd_total_de_onibus', title='Frota Total de Ônibus')
        grafico_frota_total.update_layout(xaxis_title='Mês', yaxis_title='Quantidade Total')
        grafico_frota_total = grafico_frota_total.to_html(full_html=False)
    else:
        grafico_frota_total = None

    ###################### RENDER

    return render(request, 'dash-onibus.html', {
        'anos': anos_disponiveis,
        'ano_selecionado': ano_selecionado,
        'grafico_historico': grafico_historico,
        'grafico_frota_total': grafico_frota_total,
    })

def exportar_csv(request):
    ano = int(request.GET.get('ano', 2022))

    historico_filtrado = HistoricoIdadeMediaFrota.objects.filter(ano=ano).order_by('mes')
    dataframe_exportar = pandas.DataFrame(list(historico_filtrado.values('ano', 'mes', 'idade_media')))
    dataframe_exportar['mes'] = dataframe_exportar['mes'].apply(lambda x: f"{x:02d}")

    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = f'attachment; filename="idade_media_frota_{ano}.csv"'
    dataframe_exportar.to_csv(path_or_buf=response, index=False)

    return response