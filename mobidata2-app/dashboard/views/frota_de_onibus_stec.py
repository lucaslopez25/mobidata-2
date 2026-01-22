from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse

from dashboard.models import *

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def frota_de_onibus_stec(request):
    titulo_da_pagina = "Frota de Ônibus (STEC)"



    ###################### RENDER

    return render(request, 'stec/frota-stec-geral.html', {
        'titulo_da_pagina': titulo_da_pagina,

        'todo': None,
    })