from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def indicadores_desempenho(request):
    titulo_da_pagina = "Indicadores de Desempenho"

    ###################### IndiceAssaltosPorViagem

    indice_assaltos = IndiceAssaltosPorViagem.objects.all().order_by('ano', 'mes')

    if indice_assaltos.exists():
        df_assaltos = pandas.DataFrame(list(indice_assaltos.values('ano', 'mes', 'indice')))
        
        df_assaltos['mes_str'] = df_assaltos['mes'].apply(lambda x: f"{x:02d}")
        df_assaltos['ano_mes'] = df_assaltos['ano'].astype(str) + '-' + df_assaltos['mes_str']

        grafico_indice_assaltos = plotxp.line(
            df_assaltos,
            x='ano_mes',
            y='indice',
            markers=True,
            title='Índice de Assaltos por Viagem',
            labels={
                'ano_mes': 'Período (Ano-Mês)',
                'indice': 'Índice (Assaltos/Viagem)'
            }
        )

        grafico_indice_assaltos.update_layout(
            xaxis_title='Ano-Mês',
            yaxis_title='Índice de Assaltos',
            hovermode="x unified",
            template="plotly_white"
        )
        
        grafico_indice_assaltos.update_traces(line_color='#d9534f')

        grafico_indice_assaltos = grafico_indice_assaltos.to_html(full_html=False)
    else:
        grafico_indice_assaltos = None

    ###################### RENDER

    return render(request, 'indicadores-desempenho.html', {
        'titulo_da_pagina': titulo_da_pagina,

        'grafico_indice_assaltos': grafico_indice_assaltos,
    })