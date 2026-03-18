from dashboard.models import CorredoresDeOnibus

import pandas # type: ignore
import plotly.express as plotxp # type: ignore
import plotly.graph_objects as plotgo

from plotly.subplots import make_subplots

def get_comparativo_corredores_de_onibus():

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
    else:
        fig = None

    return fig