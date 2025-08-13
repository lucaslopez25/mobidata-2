from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def dados_financeiros(request):
    titulo_da_pagina = "Dados Financeiros"
    exportar_sql_csv_ativado = False

    return render(request, 'dash-financeiro.html', {
        'titulo_da_pagina': titulo_da_pagina,
        'exportar_sql_csv_ativado': exportar_sql_csv_ativado,
    })