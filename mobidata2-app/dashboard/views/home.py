from django.shortcuts import render

from dashboard.charts_and_data import climatizacao_frota_total, climatizacao_frota_por_consorcio, assaltos_por_viagem, metro_pax_transportados_por_ano, metro_pax_transportados_por_mes, aquisicoes_onibus_novos_por_ano, aquisicoes_onibus_novos_por_mes, aquisicoes_onibus_usados_por_mes, historico_idade_media_da_frota, comparativo_frota_operante_frota_total, frota_operante, frota_total, historico_linhas_regulares, comparativo_corredores_de_onibus, demanda_pax_stec, demanda_pax_pagamento, demanda_pax_integracao, historico_pax_transportados, historico_km_percorridos, receitas_por_concessionaria

def home(request):

    context = {
        ### Ônibus Municipal (STCO)
        # Idade e Renovação da Frota
        'grafico_historico_idade_media_da_frota': 
            historico_idade_media_da_frota.get_historico_idade_media_da_frota().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_aquisicoes_onibus_novos_por_ano': 
            aquisicoes_onibus_novos_por_ano.get_grafico_aquisicoes_onibus_novos_por_ano().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_aquisicoes_onibus_novos_por_mes': 
            aquisicoes_onibus_novos_por_mes.get_aquisicoes_onibus_novos_por_mes().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_aquisicoes_onibus_usados_por_mes': 
            aquisicoes_onibus_usados_por_mes.get_aquisicoes_onibus_usados_por_mes().to_html(full_html=False, include_plotlyjs='cdn'),
        
        # Tamanho da Frota
        'grafico_comparativo_frota_operante_frota_total': comparativo_frota_operante_frota_total.get_comparativo_frota_operante_frota_total().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_frota_operante': frota_operante.get_frota_operante().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_frota_total': frota_total.get_frota_total().to_html(full_html=False, include_plotlyjs='cdn'),

        # Oferta de Linhas e Ônibus
        'grafico_historico_linhas_regulares': historico_linhas_regulares.get_historico_linhas_regulares().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_comparativo_corredores_de_onibus': comparativo_corredores_de_onibus.get_comparativo_corredores_de_onibus().to_html(full_html=False, include_plotlyjs='cdn'),

        # Passageiros
        'grafico_historico_pax_transportados': historico_pax_transportados.get_historico_pax_transportados().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_demanda_pax_pagamento': demanda_pax_pagamento.get_demanda_pax_pagamento().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_demanda_pax_integracao': demanda_pax_integracao.get_demanda_pax_integracao().to_html(full_html=False, include_plotlyjs='cdn'),

        # Oferta de Viagens e Quilometragem
        'grafico_historico_km_percorridos': historico_km_percorridos.get_historico_km_percorridos().to_html(full_html=False, include_plotlyjs='cdn'),

        # Climatização da Frota
        'grafico_climatizacao_frota_total': climatizacao_frota_total.get_climatizacao_frota_total().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_climatizacao_frota_por_consorcio': climatizacao_frota_por_consorcio.get_climatizacao_frota_por_consorcio().to_html(full_html=False, include_plotlyjs='cdn'),

        # Receitas e Custos
        'grafico_receitas_por_concessionaria': receitas_por_concessionaria.get_receitas_por_concessionaria(),

        ### Metrô
        # Passageiros 
        'grafico_metro_pax_transportados_por_ano': metro_pax_transportados_por_ano.get_metro_pax_transportados_por_ano().to_html(full_html=False, include_plotlyjs='cdn'),
        'grafico_metro_pax_transportados_por_mes': metro_pax_transportados_por_mes.get_metro_pax_transportados_por_mes().to_html(full_html=False, include_plotlyjs='cdn'),

        ### STEC
        # Passageiros
        'grafico_demanda_pax_stec': demanda_pax_stec.get_demanda_pax_stec().to_html(full_html=False, include_plotlyjs='cdn'),

        ### Indicadores
        # Segurança Pública e Mobilidade
        'grafico_assaltos_por_viagem': assaltos_por_viagem.get_assaltos_por_viagem().to_html(full_html=False, include_plotlyjs='cdn'),
    }

    return render(request, 'home.html', context)