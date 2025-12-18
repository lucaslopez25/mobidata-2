from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def frota_de_onibus_stco(request):
    titulo_da_pagina = "Frota de Ônibus (STCO)"
    exportar_sql_csv_ativado = False

    cores_concessionarias = {
        'SPE1': '#1631cc', #Salvador Norte
        'SPE2': '#26ae00', #OT Trans
        'SPE3': '#ffc600', #Plataforma
        'BRT1': '#192c96', #BRT
        'STEC': '#ea5a17', #STEC
        'STCO': '#808080', #Total das Concessionárias - SPE1 + SPE2 + SPE3
        'TOTL': '#404040', #Total Geral STCO + BRT + STEC
    }

    ###################### HISTORICO DE IDADE MEDIA

    historico = HistoricoIdadeMediaFrota.objects.all().order_by('ano', 'mes')

    if historico.exists():
        historico_dataframe = pandas.DataFrame(list(historico.values('ano', 'mes', 'idade_media')))
        historico_dataframe['mes'] = historico_dataframe['mes'].apply(lambda x: f"{x:02d}")
        historico_dataframe['ano_mes'] = historico_dataframe['ano'].astype(str) + '-' + historico_dataframe['mes']

        grafico_historico = plotxp.line(
            historico_dataframe, 
            x='ano_mes', 
            y='idade_media', 
            markers=True, 
            title='Idade média da frota'
        )
        grafico_historico.update_layout(xaxis_title='Ano-Mês', yaxis_title='Idade média em anos')
        grafico_historico = grafico_historico.to_html(full_html=False)
    else:
        grafico_historico = None

    ###################### AQUISIÇÕES DE ÔNIBUS

    aquisicoes = AquisicoesDeOnibusPorMes.objects.all().order_by('ano', 'mes')

    grafico_aquisicoes_novos = None
    grafico_aquisicoes_usados = None

    if aquisicoes.exists():
        aquisicoes_dataframe = pandas.DataFrame(list(aquisicoes.values('ano', 'mes', 'id_concessionaria', 'qtd_onibus', 'novo_ou_usado')))
        aquisicoes_dataframe['mes'] = aquisicoes_dataframe['mes'].apply(lambda x: f"{x:02d}")
        aquisicoes_dataframe['ano_mes'] = aquisicoes_dataframe['ano'].astype(str) + '-' + aquisicoes_dataframe['mes']

        # Filtra o DataFrame para obter apenas veículos NOVOS
        aquisicoes_novos_dataframe = aquisicoes_dataframe[aquisicoes_dataframe['novo_ou_usado'] == True]

        if not aquisicoes_novos_dataframe.empty:
            grafico_aquisicoes_novos = plotxp.bar(
                aquisicoes_novos_dataframe,
                x='ano_mes',
                y='qtd_onibus',
                color='id_concessionaria',
                barmode='stack',
                title='Aquisições de ônibus novos por mês',
                labels={
                    'id_concessionaria': 'Concessionária',
                    'ano_mes': 'Ano-Mês',
                    'qtd_onibus': 'Quantidade de Ônibus Novos',
                },
                color_discrete_map=cores_concessionarias
            )
            grafico_aquisicoes_novos.update_layout(xaxis_title='Ano-Mês', yaxis_title='Quantidade de ônibus adquiridos')
            grafico_aquisicoes_novos = grafico_aquisicoes_novos.to_html(full_html=False)

        aquisicoes_velhos_dataframe = aquisicoes_dataframe[aquisicoes_dataframe['novo_ou_usado'] == False]

        if not aquisicoes_velhos_dataframe.empty:
            grafico_aquisicoes_usados = plotxp.bar(
                aquisicoes_velhos_dataframe,
                x='ano_mes',
                y='qtd_onibus',
                color='id_concessionaria',
                barmode='stack',
                title='Aquisições de ônibus usados por mês',
                labels={
                    'id_concessionaria': 'Concessionária',
                    'ano_mes': 'Ano-Mês',
                    'qtd_onibus': 'Quantidade de Ônibus Usados',
                },
                color_discrete_map=cores_concessionarias
            )
            grafico_aquisicoes_usados.update_layout(xaxis_title='Ano-Mês', yaxis_title='Quantidade de ônibus adquiridos')
            grafico_aquisicoes_usados = grafico_aquisicoes_usados.to_html(full_html=False)

    ###################### FROTA TOTAL

    frota_total = FrotaTotal.objects.all().order_by('ano', 'mes')

    if frota_total.exists():
        frota_total_dataframe = pandas.DataFrame(list(frota_total.values('ano', 'mes', 'id_concessionaria', 'qtd_total_de_onibus')))
        frota_total_dataframe['mes'] = frota_total_dataframe['mes'].apply(lambda x: f"{x:02d}")
        frota_total_dataframe['ano_mes'] = frota_total_dataframe['ano'].astype(str) + '-' + frota_total_dataframe['mes']

        grafico_frota_total = plotxp.bar(
            frota_total_dataframe, 
            x='ano_mes', 
            y='qtd_total_de_onibus', 
            color='id_concessionaria', 
            title='Frota total de ônibus',
            labels={
                'id_concessionaria': 'Concessionária', 
                'ano_mes': 'Ano-Mês', 
                'qtd_total_de_onibus': 'Quantidade Total de Ônibus',
            },
            color_discrete_map=cores_concessionarias
        )
        grafico_frota_total.update_layout(xaxis_title='Ano-Mês', yaxis_title='Quantidade Total')
        grafico_frota_total = grafico_frota_total.to_html(full_html=False)
    else:
        grafico_frota_total = None

    ###################### FROTA OPERANTE

    frota_operante = FrotaOperante.objects.all().order_by('ano', 'mes')

    if frota_operante.exists():
        frota_operante_dataframe = pandas.DataFrame(list(frota_operante.values('ano', 'mes', 'id_concessionaria', 'qtd_operante_de_onibus')))
        frota_operante_dataframe['mes'] = frota_operante_dataframe['mes'].apply(lambda x: f"{x:02d}")
        frota_operante_dataframe['ano_mes'] = frota_operante_dataframe['ano'].astype(str) + '-' + frota_operante_dataframe['mes']

        grafico_frota_operante = plotxp.bar(
            frota_operante_dataframe, 
            x='ano_mes', 
            y='qtd_operante_de_onibus', 
            color='id_concessionaria', 
            title='Frota operante de ônibus',
            labels={
                'id_concessionaria': 'Concessionária', 
                'ano_mes': 'Ano-Mês', 
                'qtd_operante_de_onibus': 'Quantidade Operante',
            },
            color_discrete_map=cores_concessionarias
        )
        grafico_frota_operante.update_layout(xaxis_title='Ano-Mês', yaxis_title='Quantidade Operante')
        grafico_frota_operante = grafico_frota_operante.to_html(full_html=False)
    else:
        grafico_frota_operante = None

    ###################### veiculos_novos_adquiridos_por_ano

    grafico_veiculos_novos_ano = None
    veiculos_novos_ano = VeiculosNovosAdquiridosPorAno.objects.all().order_by('ano')

    if veiculos_novos_ano.exists():
        df_veiculos_novos_ano = pandas.DataFrame(list(veiculos_novos_ano.values('ano', 'veiculos')))

        grafico_veiculos_novos_ano = plotxp.bar(
            df_veiculos_novos_ano,
            x='ano',
            y='veiculos',
            title='Veículos novos adquiridos por ano',
            labels={
                'ano': 'Ano',
                'veiculos': 'Quantidade de Veículos Novos',
            },
        )
        grafico_veiculos_novos_ano.update_layout(
            xaxis=dict(tickmode='array', tickvals=df_veiculos_novos_ano['ano']),
            xaxis_title='Ano', 
            yaxis_title='Quantidade'
        )
        grafico_veiculos_novos_ano = grafico_veiculos_novos_ano.to_html(full_html=False)

    ###################### demanda_pax_por_pagamento

    demanda_pax = DemandaPaxPorPagamento.objects.all().order_by('ano', 'mes')

    grafico_demanda_pagamento = None
    grafico_demanda_integracao = None

    if demanda_pax.exists():
        df_demanda = pandas.DataFrame(list(demanda_pax.values(
            'ano', 'mes', 'tipo_pagamento', 'demanda', 
            'demanda_int_metro', 'demanda_int_stec', 'demanda_int_brt'
        )))
        df_demanda['mes'] = df_demanda['mes'].apply(lambda x: f"{x:02d}")
        df_demanda['ano_mes'] = df_demanda['ano'].astype(str) + '-' + df_demanda['mes']

        # Gráfico 1: Demanda (coluna 'demanda') por Tipo de Pagamento
        grafico_demanda_pagamento = plotxp.bar(
            df_demanda,
            x='ano_mes',
            y='demanda',
            color='tipo_pagamento',
            barmode='stack',
            title='Demanda de Passageiros por Tipo de Pagamento',
            labels={
                'tipo_pagamento': 'Tipo de Pagamento',
                'ano_mes': 'Ano-Mês',
                'demanda': 'Demanda de Passageiros',
            },
        )
        grafico_demanda_pagamento.update_layout(xaxis_title='Ano-Mês', yaxis_title='Demanda')
        grafico_demanda_pagamento = grafico_demanda_pagamento.to_html(full_html=False)

        # Gráfico 2: Demanda Total e Integrações (somando todos tipos de pagamento)
        df_demanda_grouped = df_demanda.groupby('ano_mes')[[
            'demanda', 'demanda_int_metro', 'demanda_int_stec', 'demanda_int_brt'
        ]].sum().reset_index()
        
        # 'Melt' para formato longo, ideal para stacked bar
        df_demanda_melted = df_demanda_grouped.melt(
            id_vars='ano_mes', 
            var_name='tipo_demanda', 
            value_name='quantidade'
        )
        
        grafico_demanda_integracao = plotxp.bar(
            df_demanda_melted,
            x='ano_mes',
            y='quantidade',
            color='tipo_demanda',
            barmode='stack',
            title='Demanda Total e Integrações por Mês',
            labels={
                'tipo_demanda': 'Tipo de Demanda',
                'ano_mes': 'Ano-Mês',
                'quantidade': 'Quantidade de Passageiros',
            },
        )
        grafico_demanda_integracao.update_layout(xaxis_title='Ano-Mês', yaxis_title='Demanda Total')
        grafico_demanda_integracao = grafico_demanda_integracao.to_html(full_html=False)

    ###################### RENDER

    return render(request, 'dash-frota-stco.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'grafico_historico': grafico_historico,
        'grafico_aquisicoes_novos': grafico_aquisicoes_novos,
        'grafico_aquisicoes_usados': grafico_aquisicoes_usados,
        'grafico_frota_total': grafico_frota_total,
        'grafico_frota_operante': grafico_frota_operante,
        'grafico_veiculos_novos_ano': grafico_veiculos_novos_ano,

        #teste
        'grafico_demanda_pagamento': grafico_demanda_pagamento,
        'grafico_demanda_integracao': grafico_demanda_integracao,
    })