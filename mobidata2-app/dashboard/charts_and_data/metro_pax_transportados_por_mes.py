from dashboard.models import HistoricoPassageirosTransportadosMetroMes

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_metro_pax_transportados_por_mes():

    ###################### DADOS MENSAIS

    dados_mes = HistoricoPassageirosTransportadosMetroMes.objects.all().order_by('ano', 'mes')
    df_mes = pandas.DataFrame(list(dados_mes.values('ano', 'mes', 'passageiros')))

    if not df_mes.empty:
        df_mes['data_str'] = df_mes.apply(lambda x: f"{int(x['ano'])}-{int(x['mes']):02d}-01", axis=1)
        df_mes['data_dt'] = pandas.to_datetime(df_mes['data_str'])

        df_mes = df_mes.sort_values('data_dt')

        grafico_mes = plotxp.line(
            df_mes, x='data_dt', y='passageiros', title='Passageiros Transportados no Metrô (Mensal)',
            markers=True,
            labels={'data_dt': 'Ano-Mês', 'passageiros': 'Passageiros'},
            template='plotly_white'
        )
    else:
        grafico_mes = None
    
    return grafico_mes