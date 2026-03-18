from dashboard.models import FrotaTotal
from dashboard.utils import get_cores_concessionarias 

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_frota_total():

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
            title='Frota Total de Ônibus por Concessionária',
            labels={
                'id_concessionaria': 'Concessionária', 
                'ano_mes': 'Ano-Mês', 
                'qtd_total_de_onibus': 'Quantidade Total de Ônibus',
            },
            color_discrete_map=get_cores_concessionarias()
        )
        grafico_frota_total.update_layout(xaxis_title='Ano-Mês', yaxis_title='Quantidade Total')
    else:
        grafico_frota_total = None
    
    return grafico_frota_total