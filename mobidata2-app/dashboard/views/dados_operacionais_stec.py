from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse
from plotly.subplots import make_subplots

from dashboard.models import *
from . import gerar_grafico_linhas_simples_por_ano_mes, gerar_lista_de_anos_disponiveis_distinct

import pandas # type: ignore
import plotly.express as plotxp # type: ignore
import plotly.graph_objects as plotgo

def dados_operacionais_stec(request):
    titulo_da_pagina = "Dados Operacionais (STEC)"

    ###################### DemandaPaxStec

    demanda_pax_stec = DemandaPaxStec.objects.all().order_by('ano', 'mes')

    if demanda_pax_stec.exists():
        df_stec = pandas.DataFrame(list(demanda_pax_stec.values('ano', 'mes', 'pax_total', 'pax_equivalente')))
        
        df_stec['mes_str'] = df_stec['mes'].apply(lambda x: f"{x:02d}")
        df_stec['ano_mes'] = df_stec['ano'].astype(str) + '-' + df_stec['mes_str']

        df_stec_melted = df_stec.melt(
            id_vars=['ano_mes'], 
            value_vars=['pax_total', 'pax_equivalente'],
            var_name='tipo_passageiro', 
            value_name='quantidade'
        )

        df_stec_melted['tipo_passageiro'] = df_stec_melted['tipo_passageiro'].map({
            'pax_total': 'Passageiros Totais',
            'pax_equivalente': 'Passageiros Equivalentes'
        })

        grafico_demanda_pax_stec = plotxp.line(
            df_stec_melted,
            x='ano_mes',
            y='quantidade',
            color='tipo_passageiro',
            markers=True,
            title='Demanda de Passageiros do STEC',
            labels={'ano_mes': 'Período', 'quantidade': 'Nº de Passageiros', 'tipo_passageiro': 'Tipo'}
        )

        grafico_demanda_pax_stec.update_layout(
            xaxis_title='Ano-Mês',
            yaxis_title='Quantidade de Passageiros',
            hovermode="x unified",
            legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1)
        )
        
        grafico_demanda_pax_stec = grafico_demanda_pax_stec.to_html(full_html=False)
    else:
        grafico_demanda_pax_stec = None

    ###################### Render

    return render(request, 'stec/dados-operacionais.html', {
        'titulo_da_pagina': titulo_da_pagina,

        'grafico_demanda_pax_stec': grafico_demanda_pax_stec,
    })