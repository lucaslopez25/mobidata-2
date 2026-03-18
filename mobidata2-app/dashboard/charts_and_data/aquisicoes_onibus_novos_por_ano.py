from dashboard.models import VeiculosNovosAdquiridosPorAno

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_grafico_aquisicoes_onibus_novos_por_ano():

    ###################### grafico_aquisicoes_onibus_novos_por_ano

    grafico_aquisicoes_onibus_novos_por_ano = None
    veiculos_novos_ano = VeiculosNovosAdquiridosPorAno.objects.all().order_by('ano')

    if veiculos_novos_ano.exists():
        df_veiculos_novos_ano = pandas.DataFrame(list(veiculos_novos_ano.values('ano', 'veiculos')))

        grafico_aquisicoes_onibus_novos_por_ano = plotxp.bar(
            df_veiculos_novos_ano,
            x='ano',
            y='veiculos',
            title='Aquisições de ônibus novos por ano',
            labels={
                'ano': 'Ano',
                'veiculos': 'Quantidade de ônibus Novos',
            },
        )
        grafico_aquisicoes_onibus_novos_por_ano.update_layout(
            xaxis=dict(tickmode='array', tickvals=df_veiculos_novos_ano['ano']),
            xaxis_title='Ano', 
            yaxis_title='Quantidade'
        )
    else:
        grafico_aquisicoes_onibus_novos_por_ano = None
    
    return grafico_aquisicoes_onibus_novos_por_ano