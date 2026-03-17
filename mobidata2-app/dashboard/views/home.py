from django.shortcuts import render

from dashboard.charts_and_data import climatizacao_frota_total, climatizacao_frota_por_consorcio, assaltos_por_viagem, metro_pax_transportados_por_ano, metro_pax_transportados_por_mes

def home(request):
    grafico_climatizacao_frota_total = climatizacao_frota_total.get_climatizacao_frota_total()
    grafico_climatizacao_frota_por_consorcio = climatizacao_frota_por_consorcio.get_climatizacao_frota_por_consorcio()

    grafico_metro_pax_transportados_por_ano = metro_pax_transportados_por_ano.get_metro_pax_transportados_por_ano()
    grafico_metro_pax_transportados_por_mes = metro_pax_transportados_por_mes.get_metro_pax_transportados_por_mes()

    grafico_assaltos_por_viagem = assaltos_por_viagem.get_assaltos_por_viagem()

    context = {
        'grafico_climatizacao_frota_total': grafico_climatizacao_frota_total.to_html(full_html=False),
        'grafico_climatizacao_frota_por_consorcio': grafico_climatizacao_frota_por_consorcio.to_html(full_html=False),

        'grafico_metro_pax_transportados_por_ano': grafico_metro_pax_transportados_por_ano.to_html(full_html=False),
        'grafico_metro_pax_transportados_por_mes': grafico_metro_pax_transportados_por_mes.to_html(full_html=False),

        'grafico_assaltos_por_viagem': grafico_assaltos_por_viagem.to_html(full_html=False),
    }

    return render(request, 'home.html', context)