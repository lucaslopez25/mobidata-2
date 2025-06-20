from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from .models import HistoricoIdadeMediaFrota

import io
import base64
import matplotlib.pyplot as matplot

import pandas
import plotly.express as plotxp

def home(request):
    template = loader.get_template('homepage.html')
    return HttpResponse(template.render())

def testematplotlib(request):
    dados = HistoricoIdadeMediaFrota.objects.filter(ano=2022).order_by('mes')

    meses = [d.mes for d in dados]
    idade_media = [d.idade_media for d in dados]

    matplot.figure(figsize=(8,4))
    matplot.plot(meses, idade_media, marker='o', color='blue')
    matplot.title('Idade Média da Frota - 2022')
    matplot.xlabel('Mês')
    matplot.ylabel('Idade Média (anos)')
    matplot.xticks(meses)
    matplot.grid(True)

    buf = io.BytesIO()
    matplot.savefig(buf, format='png')
    matplot.close()
    buf.seek(0)
    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')
    buf.close()

    return render(request, 'testematplotlib.html', { 'grafico': image_base64 })

def testematplotlib2(request):
    dados = HistoricoIdadeMediaFrota.objects.all().order_by('ano', 'mes')

    x_labels = [f"{d.ano}-{d.mes:02d}" for d in dados]
    idade_media = [d.idade_media for d in dados]

    matplot.figure(figsize=(58,12))
    matplot.plot(x_labels, idade_media, marker='o', color='blue')
    matplot.title('Histórico Completo da Idade Média da Frota')
    matplot.xlabel('Ano e Mês')
    matplot.ylabel('Idade Média (anos)')
    matplot.xticks(rotation=90, fontsize=8)
    matplot.grid(True)

    buf = io.BytesIO()
    matplot.savefig(buf, format='png', bbox_inches='tight')
    matplot.close()
    buf.seek(0)
    grafico_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')
    buf.close()

    return render(request, 'testematplotlib2.html', { 'grafico': grafico_base64 })

def historico_idade_media_frota(request):
    anos_disponiveis = HistoricoIdadeMediaFrota.objects.values_list('ano', flat=True).distinct().order_by('ano')
    ano_selecionado = int(request.GET.get('ano', anos_disponiveis.first()))

    historico_filtrado = HistoricoIdadeMediaFrota.objects.filter(ano=ano_selecionado).order_by('mes')

    historico_dataframe = pandas.DataFrame(list(historico_filtrado.values('ano', 'mes', 'idade_media')))
    historico_dataframe['mes'] = historico_dataframe['mes'].apply(lambda x: f"{x:02d}")

    grafico = plotxp.line(historico_dataframe, x='mes', y='idade_media', markers=True, title=f'Idade Média da Frota - {ano_selecionado}')
    grafico.update_layout(xaxis_title='Mês', yaxis_title='Idade Média (anos)')

    grafico_html = grafico.to_html(full_html=False)

    return render(request, 'historico_idade_media_frota.html', {
        'grafico': grafico_html,
        'anos': anos_disponiveis,
        'ano_selecionado': ano_selecionado
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