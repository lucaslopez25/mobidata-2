from django.shortcuts import get_object_or_404
from django.http import HttpResponse, Http404

from dashboard.models import *

import pandas # type: ignore

AVAILABLE_MODELS_FOR_EXPORT = {
# 'fields': None                                                exporta todos os campos
# 'fields': ['ano', 'mes', 'quilometragem']                     exporta apenas campos selecionados
    'passageiros': {
        'model': HistoricoPassageirosTransportados,
        'filename': 'historico_passageiros.csv',
        'fields': None,
    },
    'quilometragem': {
        'model': HistoricoQuilometragemPercorrida,
        'filename': 'historico_quilometragem.csv',
        'fields': ['ano', 'mes', 'quilometragem'],
    },
    'corredores': {
        'model': CorredoresDeOnibus,
        'filename': 'corredores_de_onibus.csv',
        'fields': ['ano', 'nome_corredor', 'qtd_onibus_por_hora', 'extensao_em_kms'],
    },
}

def exportar_dados_csv(request, tipo):
    chosen_model = AVAILABLE_MODELS_FOR_EXPORT.get(tipo)

    if not chosen_model:
        raise Http404("Tipo de dado não encontrado")

    queryset = chosen_model['model'].objects.all()

    if chosen_model['fields']:
        data = list(queryset.values(*chosen_model['fields']))
    else:
        data = list(queryset.values())

    df = pandas.DataFrame(data)

    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = f'attachment; filename="{chosen_model["filename"]}"'
    df.to_csv(path_or_buf=response, index=False, encoding='utf-8-sig')

    return response