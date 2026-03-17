from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_metro_pax_transportados_por_ano():

    ###################### DADOS ANUAIS

    dados_ano = HistoricoPassageirosTransportadosMetroAno.objects.all().order_by('ano')
    df_ano = pandas.DataFrame(list(dados_ano.values('ano', 'passageiros')))

    if not df_ano.empty:
        grafico_ano = plotxp.bar(
            df_ano,
            x='ano',
            y='passageiros',
            title='Passageiros Transportados no Metrô (Anual)',
            labels={'ano': 'Ano', 'passageiros': 'Passageiros'},
        )
        grafico_ano.update_layout(yaxis_title='Passageiros', xaxis_title='Ano')
    else:
        grafico_ano = None

    return grafico_ano