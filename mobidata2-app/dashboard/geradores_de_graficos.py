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