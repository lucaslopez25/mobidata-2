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

    ###################### Render

    return render(request, 'stec/dados-operacionais.html', {
        'titulo_da_pagina': titulo_da_pagina,
    })