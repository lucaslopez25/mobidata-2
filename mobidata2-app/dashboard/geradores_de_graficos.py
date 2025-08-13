import pandas # type: ignore
import plotly.express as plotxp # type: ignore
import plotly.graph_objects as plotgo # type: ignore
from plotly.subplots import make_subplots # type: ignore

def gerar_grafico_linhas_simples_por_ano_mes(model, yaxis_titulo, titulo_grafico, yaxis_modelname):

    queryset = model.objects.all().order_by('ano', 'mes')

    if queryset.exists():
        model_dataframe = pandas.DataFrame(list(queryset.values('ano', 'mes', yaxis_modelname)))
        model_dataframe['mes'] = model_dataframe['mes'].apply(lambda x: f"{x:02d}")
        model_dataframe['periodo'] = model_dataframe['ano'].astype(str) + '-' + model_dataframe['mes']

        model_grafico = plotxp.line(
            model_dataframe, 
            x='periodo', 
            y=yaxis_modelname, 
            markers=True, 
            title=titulo_grafico
        )
        model_grafico.update_layout(xaxis_title='Período (Ano-Mês)', yaxis_title=yaxis_titulo)
        model_grafico = model_grafico.to_html(full_html=False)
    else:
        model_grafico = None

    return model_grafico

def gerar_grafico_indicador_financeiro_todas_concessionarias_por_ano(dataframe, ano):

    grafico = plotxp.bar(
        dataframe,
        x="tipo_conta",
        y="valor",
        color="id_concessionaria__nome_concessionaria",
        barmode="group",
        title=f"Histórico Financeiro das Concessionárias no ano {ano}",
        labels={"tipo_conta": "Tipo de Conta", "valor": "Valor"}
    )

    return grafico.to_html(full_html=False)

def gerar_grafico_indicador_financeiro_historico_anual_da_concessionaria(dataframe, concessionaria):

    grafico = plotxp.line(
        dataframe,
        x="ano",
        y="valor",
        color="tipo_conta",
        markers=True,
        title=f"Histórico Financeiro da {concessionaria}",
        labels={"ano": "Ano", "valor": "Valor"}
    )

    return grafico.to_html(full_html=False)

def gerar_grafico_indicador_financeiro(model, ano_selecionado, concessionaria_selecionada):

    queryset = model.objects.select_related("id_concessionaria").values("id_concessionaria__nome_concessionaria", "tipo_conta", "ano", "valor")

    if queryset.exists():
        model_dataframe = pandas.DataFrame(list(queryset))
        lista_anos = sorted(model_dataframe["ano"].unique())
        lista_concessionarias = sorted(model_dataframe["id_concessionaria__nome_concessionaria"].unique())
        if ano_selecionado:
            model_dataframe = model_dataframe[model_dataframe["ano"] == int(ano_selecionado)]
            model_grafico = gerar_grafico_indicador_financeiro_todas_concessionarias_por_ano(model_dataframe, ano_selecionado)
            return {
                'model_grafico': model_grafico,
                'lista_anos': lista_anos,
                'lista_concessionarias': lista_concessionarias,
            }
        elif concessionaria_selecionada:
            model_dataframe = model_dataframe[model_dataframe["id_concessionaria__nome_concessionaria"] == concessionaria_selecionada]
            model_grafico = gerar_grafico_indicador_financeiro_historico_anual_da_concessionaria(model_dataframe, concessionaria_selecionada)
            return {
                'model_grafico': model_grafico,
                'lista_anos': lista_anos,
                'lista_concessionarias': lista_concessionarias,
            }
    
    return None

def gerar_graficos_dados_stco(model):

    queryset = model.objects.order_by("ano") # O model deve ser DadosStco

    if queryset.exists():
        anos = [d.ano for d in queryset]
        passageiros_total = [d.passageiros_total for d in queryset]
        passageiros_equivalente = [d.passageiros_equivalente for d in queryset]
        quilometragem_total = [float(d.quilometragem_total) if d.quilometragem_total else None for d in queryset]
        kms_por_viagem = [float(d.kms_por_viagem) if d.kms_por_viagem else None for d in queryset]
        passageiros_por_viagem = [float(d.passageiros_por_viagem) if d.passageiros_por_viagem else None for d in queryset]

        grafico_passageiros = plotgo.Figure()

        grafico_passageiros.add_trace(plotgo.Scatter(
            x=anos, y=passageiros_total,
            name="Passageiros Totais",
            mode="lines+markers",
            marker_color="blue"
        ))

        grafico_passageiros.add_trace(plotgo.Scatter(
            x=anos, y=passageiros_equivalente,
            name="Passageiros Equivalentes",
            mode="lines+markers",
            marker_color="green"
        ))

        grafico_passageiros.update_layout(
            title="Dados Operacionais do STCO - Passageiros",
            xaxis_title="Ano",
            yaxis=dict(
                title="Passageiros",
                showgrid=True
            ),
            barmode="group",
            template="plotly_white"
        )

        grafico_passageiros = grafico_passageiros.to_html(full_html=False)

        grafico_quilometragem = plotgo.Figure()

        grafico_quilometragem.add_trace(plotgo.Scatter(
            x=anos, y=quilometragem_total,
            name="Quilometragem Total (km)",
            mode="lines+markers",
            marker_color="orange"
        ))

        grafico_quilometragem.update_layout(
            title="Dados Operacionais do STCO - Quilometragem",
            xaxis_title="Ano",
            yaxis=dict(
                title="Quilômetros",
                showgrid=True
            ),
            barmode="group",
            template="plotly_white"
        )

        grafico_quilometragem = grafico_quilometragem.to_html(full_html=False)

        return {
            'grafico_passageiros': grafico_passageiros,
            'grafico_quilometragem': grafico_quilometragem,
        }
    else:
        return {
            'grafico_passageiros': None,
            'grafico_quilometragem': None,
        }