from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse
from plotly.subplots import make_subplots

from dashboard.models import *
from . import gerar_grafico_linhas_simples_por_ano_mes, gerar_lista_de_anos_disponiveis_distinct

import pandas # type: ignore
import plotly.express as plotxp # type: ignore
import plotly.graph_objects as plotgo

def dados_operativos(request):
    titulo_da_pagina = "Dados Operativos"
    exportar_sql_csv_ativado = False

    ###################### HistoricoPassageirosTransportados

    grafico_hist_pax_transp = gerar_grafico_linhas_simples_por_ano_mes(
        HistoricoPassageirosTransportados,
        'Passageiros',
        'Passageiros Transportados em Milhões',
        'passageiros'
    )

    ###################### HistoricoQuilometragemPercorrida

    grafico_kmt_perc_transp = gerar_grafico_linhas_simples_por_ano_mes(
        HistoricoQuilometragemPercorrida,
        'Quilômetros (kms)',
        'Quilometragem Percorrida em Milhões',
        'quilometragem'
    )

    ###################### grafico_corredores_comparativo

    queryset = CorredoresDeOnibus.objects.all().order_by('ano')
    df = pandas.DataFrame(list(queryset.values(
        'ano',
        'nome_corredor',
        'qtd_onibus_por_hora',
        'qtd_linhas_convencionais',
        'extensao_em_kms'
    )))

    if not df.empty:
        df_agrupado = df.groupby('nome_corredor')
        corredores = list(df_agrupado.groups.keys())

        fig = make_subplots(
            rows=2, cols=1,
            subplot_titles=("Ônibus por Hora", "Linhas Convencionais")
        )

        botoes = []

        for i, corredor in enumerate(corredores):
            df_c = df_agrupado.get_group(corredor).sort_values(by='ano')
            extensao = df_c['extensao_em_kms'].iloc[0] if not df_c['extensao_em_kms'].isna().all() else 0

            # Gráfico 1: ônibus por hora
            fig.add_trace(
                plotgo.Scatter(
                    x=df_c['ano'],
                    y=df_c['qtd_onibus_por_hora'],
                    mode='lines+markers',
                    name=f"{corredor} - Ônibus/Hora",
                    visible=(i == 0)
                ),
                row=1, col=1
            )

            # Gráfico 2: linhas convencionais
            fig.add_trace(
                plotgo.Scatter(
                    x=df_c['ano'],
                    y=df_c['qtd_linhas_convencionais'],
                    mode='lines+markers',
                    name=f"{corredor} - Linhas Convencionais",
                    visible=(i == 0)
                ),
                row=2, col=1
            )

            # Controle de visibilidade: 2 traces por corredor
            visibilidade = [False] * (2 * len(corredores))
            visibilidade[2*i] = True      # trace do ônibus/hora
            visibilidade[2*i + 1] = True  # trace do linhas convencionais

            botoes.append(dict(
                label=corredor,
                method="update",
                args=[{"visible": visibilidade},
                      {"title": f"Histórico do Corredor: {corredor} ({extensao} km)"}]
            ))
        
            primeiro = corredores[0]
            extensao_primeiro = df_agrupado.get_group(primeiro)['extensao_em_kms'].iloc[0]

        # Layout e dropdown
        fig.update_layout(
            title=f"Histórico do Corredor: {primeiro} (Extensão: {extensao_primeiro:.1f} km)",
            xaxis_title="Ano",
            yaxis_title="Qtd Ônibus por Hora",
            xaxis2_title="Ano",
            yaxis2_title="Qtd Linhas Convencionais",
            updatemenus=[{
                "buttons": botoes,
                "direction": "down",
                "showactive": True,
                "x": 0.2,
                "xanchor": "center",
                "y": 1.5,
                "yanchor": "top"
            }],
            height=600
        )

        grafico_corredores_comparativo = fig.to_html(full_html=False)
    else:
        grafico_corredores_comparativo = None

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
    
    ###################### HistoricoLinhasRegulares

    historico_linhas_regulares = HistoricoLinhasRegulares.objects.all().order_by('ano', 'mes')

    if historico_linhas_regulares.exists():
        df_linhas = pandas.DataFrame(list(historico_linhas_regulares.values('ano', 'mes', 'qtd_linhas')))
        
        df_linhas['mes_str'] = df_linhas['mes'].apply(lambda x: f"{x:02d}")
        df_linhas['ano_mes'] = df_linhas['ano'].astype(str) + '-' + df_linhas['mes_str']

        grafico_historico_linhas_regulares = plotxp.line(
            df_linhas, 
            x='ano_mes', 
            y='qtd_linhas', 
            markers=True, 
            title='Histórico da Quantidade de Linhas Regulares',
            labels={
                'ano_mes': 'Ano-Mês',
                'qtd_linhas': 'Quantidade de Linhas'
            }
        )
        
        grafico_historico_linhas_regulares.update_layout(
            xaxis_title='Período (Ano-Mês)',
            yaxis_title='Qtd. de Linhas',
            hovermode="x unified"
        )
        grafico_historico_linhas_regulares = grafico_historico_linhas_regulares.to_html(full_html=False)
    else:
        grafico_historico_linhas_regulares = None

    ###################### Render

    return render(request, 'dash-operativo.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
        'grafico_hist_pax_transp': grafico_hist_pax_transp,
        'grafico_kmt_perc_transp': grafico_kmt_perc_transp,
        'grafico_corredores_comparativo': grafico_corredores_comparativo,

        'grafico_demanda_pagamento': grafico_demanda_pagamento,
        'grafico_demanda_integracao': grafico_demanda_integracao,

        'grafico_historico_linhas_regulares': grafico_historico_linhas_regulares,
    })
