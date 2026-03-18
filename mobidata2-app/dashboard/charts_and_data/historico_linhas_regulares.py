from dashboard.models import HistoricoLinhasRegulares

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_historico_linhas_regulares():

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
    else:
        grafico_historico_linhas_regulares = None

    return grafico_historico_linhas_regulares