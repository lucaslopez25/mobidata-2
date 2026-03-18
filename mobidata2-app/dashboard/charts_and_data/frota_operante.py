from dashboard.models import FrotaOperante
from dashboard.utils import get_cores_concessionarias 

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_frota_operante():

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
            title='Frota Operante de Ônibus por Concessionária',
            labels={
                'id_concessionaria': 'Concessionária', 
                'ano_mes': 'Ano-Mês', 
                'qtd_operante_de_onibus': 'Quantidade Operante',
            },
            color_discrete_map=get_cores_concessionarias()
        )
        grafico_frota_operante.update_layout(xaxis_title='Ano-Mês', yaxis_title='Quantidade Operante')
    else:
        grafico_frota_operante = None
    
    return grafico_frota_operante