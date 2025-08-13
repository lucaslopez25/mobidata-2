import pandas # type: ignore
import plotly.express as plotxp # type: ignore

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