from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore

def exportar_csv(request):
    ano = int(request.GET.get('ano', 2022))

    historico_filtrado = HistoricoIdadeMediaFrota.objects.filter(ano=ano).order_by('mes')
    dataframe_exportar = pandas.DataFrame(list(historico_filtrado.values('ano', 'mes', 'idade_media')))
    dataframe_exportar['mes'] = dataframe_exportar['mes'].apply(lambda x: f"{x:02d}")

    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = f'attachment; filename="idade_media_frota_{ano}.csv"'
    dataframe_exportar.to_csv(path_or_buf=response, index=False)

    return response