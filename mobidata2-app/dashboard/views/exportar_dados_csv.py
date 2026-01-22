from django.shortcuts import get_object_or_404
from django.http import HttpResponse, Http404

from dashboard.models import *

import pandas # type: ignore

AVAILABLE_MODELS_FOR_EXPORT = {
# 'fields': None                                                exporta todos os campos
# 'fields': ['ano', 'mes', 'quilometragem']                     exporta apenas campos selecionados
    'dop_passageiros': {
        'model': HistoricoPassageirosTransportados,
        'filename': 'historico_passageiros.csv',
        'fields': None,
    },
    'dop_quilometragem': {
        'model': HistoricoQuilometragemPercorrida,
        'filename': 'historico_quilometragem.csv',
        'fields': ['ano', 'mes', 'quilometragem'],
    },
    'dop_corredores': {
        'model': CorredoresDeOnibus,
        'filename': 'corredores_de_onibus.csv',
        'fields': ['ano', 'nome_corredor', 'qtd_onibus_por_hora', 'extensao_em_kms'],
    },
    'dop_historico_de_linhas': {
        'model': HistoricoLinhasRegulares,
        'filename': 'historico_quantidade_de_linhas.csv',
        'fields': ['ano', 'mes', 'qtd_linhas'],
    },
    'dop_demanda_pax_pagamento': {
        'model': DemandaPaxPorPagamento,
        'filename': 'demanda_pax_pagamento.csv',
        'fields': ['ano', 'mes', 'tipo_pagamento', 'demanda', 'demanda_int_metro', 'demanda_int_stec', 'demanda_int_brt'],
    },
    'fdo_stco_idade_media_frota': {
        'model': HistoricoIdadeMediaFrota,
        'filename': 'historico_idade_media_frota.csv',
        'fields': ['ano', 'mes', 'idade_media'],
    },
    'fdo_stco_veiculos_novos_por_ano': {
        'model': VeiculosNovosAdquiridosPorAno,
        'filename': 'veiculos_novos_adquiridos_por_ano.csv',
        'fields': ['ano', 'veiculos'],
    },
    'fdo_stco_frota_operante': {
        'model': FrotaOperante,
        'filename': 'stco_frota_operante.csv',
        'fields': ['ano', 'mes', 'id_concessionaria', 'qtd_operante_de_onibus'],
    },
    'fdo_stco_frota_total': {
        'model': FrotaTotal,
        'filename': 'stco_frota_total.csv',
        'fields': ['ano', 'mes', 'id_concessionaria', 'qtd_total_de_onibus'],
    },
    'fdo_stco_aquisicoes_onibus_por_mes': {
        'model': AquisicoesDeOnibusPorMes,
        'filename': 'stco_aquisicoes_onibus_por_mes_novos_e_usados.csv',
        'fields': ['ano', 'mes', 'id_concessionaria', 'qtd_onibus', 'novo_ou_usado'],
    },
    'fdo_stco_ar_condicionado_frota': {
        'model': ArCondicionadoStco,
        'filename': 'dados_de_climatizacao_na_frota.csv',
        'fields': ['ano', 'id_concessionaria', 'qtd_frota_total', 'qtd_frota_com_ar_condicionado', 'pct_frota_com_ar_condicionado'],
    },
    'fdo_comparativo_frota_stco': {
        'model': ComparativoFrotaStco,
        'filename': 'comparativo_frota_stco.csv',
        'fields': ['ano', 'frota_operante', 'frota_total', 'idade_media', 'percentual_operante_total'],
    },
    'ae_indicadores_financeiros_stco': {
        'model': IndicadoresFinanceirosStco,
        'filename': 'indicadores_financeiros_stco.csv',
        'fields': ['ano', 'id_concessionaria', 'tipo_conta', 'valor', 'unidade_medida', 'fonte', 'observacoes'],
    },
    'ae_indicadores_financeiros_stco': {
        'model': IndicadoresFinanceirosStco,
        'filename': 'indicadores_financeiros_stco.csv',
        'fields': ['ano', 'id_concessionaria', 'tipo_conta', 'valor', 'unidade_medida', 'fonte', 'observacoes'],
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