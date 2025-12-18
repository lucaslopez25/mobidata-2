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
    'fdo_stco_idade_media_frota': {
        'model': HistoricoIdadeMediaFrota,
        'filename': 'historico_idade_media_frota.csv',
        'fields': ['ano', 'mes', 'idade_media'],
    },
}


IGNORE_LIST = {
    'AquisicoesDeOnibusPorMes': {
        'nome_arquivo': 'aquisicoes_onibus_mensal',
        'titulo': 'Aquisições de Ônibus (Novos e Usados)',
        'colunas': {
            'ano': 'Ano',
            'mes': 'Mês',
            'id_concessionaria': 'Concessionária',
            'qtd_onibus': 'Quantidade de Ônibus',
            'novo_ou_usado': 'Veículo Novo (Sim/Não)',
        }
    },
    'FrotaTotal': {
        'nome_arquivo': 'frota_total_onibus',
        'titulo': 'Frota Total de Ônibus por Concessionária',
        'colunas': {
            'ano': 'Ano',
            'mes': 'Mês',
            'id_concessionaria': 'Concessionária',
            'qtd_total_de_onibus': 'Quantidade Total',
        }
    },
    'FrotaOperante': {
        'nome_arquivo': 'frota_operante_onibus',
        'titulo': 'Frota Operante de Ônibus por Concessionária',
        'colunas': {
            'ano': 'Ano',
            'mes': 'Mês',
            'id_concessionaria': 'Concessionária',
            'qtd_operante_de_onibus': 'Quantidade Operante',
        }
    },
    'VeiculosNovosAdquiridosPorAno': {
        'nome_arquivo': 'veiculos_novos_por_ano',
        'titulo': 'Veículos Novos Adquiridos por Ano',
        'colunas': {
            'ano': 'Ano',
            'veiculos': 'Total de Veículos Novos',
        }
    },
    'ArCondicionadoStco': {
        'nome_arquivo': 'frota_ar_condicionado',
        'titulo': 'Evolução da Frota com Ar Condicionado',
        'colunas': {
            'ano': 'Ano',
            'id_concessionaria': 'Concessionária',
            'qtd_frota_total': 'Frota Total',
            'qtd_frota_com_ar_condicionado': 'Qtd. com Ar Condicionado',
            'pct_frota_com_ar_condicionado': 'Percentual com Ar (%)',
        }
    },
    'DemandaPaxPorPagamento': {
        'nome_arquivo': 'demanda_passageiros_pagamento',
        'titulo': 'Demanda de Passageiros e Integrações',
        'colunas': {
            'ano': 'Ano',
            'mes': 'Mês',
            'tipo_pagamento': 'Tipo de Pagamento',
            'demanda': 'Demanda Principal',
            'demanda_int_metro': 'Integração Metrô',
            'demanda_int_stec': 'Integração STEC',
            'demanda_int_brt': 'Integração BRT',
        }
    }
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