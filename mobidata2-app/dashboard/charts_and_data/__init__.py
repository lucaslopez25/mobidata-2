### Ônibus Municipal
# Idade e Renovação da Frota
from .historico_idade_media_da_frota import get_historico_idade_media_da_frota
from .aquisicoes_onibus_novos_por_ano import get_grafico_aquisicoes_onibus_novos_por_ano
from .aquisicoes_onibus_novos_por_mes import get_aquisicoes_onibus_novos_por_mes
from .aquisicoes_onibus_usados_por_mes import get_aquisicoes_onibus_usados_por_mes

# Tamanho da Frota
from .comparativo_frota_operante_frota_total import get_comparativo_frota_operante_frota_total
from .frota_operante import get_frota_operante
from .frota_total import get_frota_total

# Oferta de Linhas e Ônibus
from .historico_linhas_regulares import get_historico_linhas_regulares
from .comparativo_corredores_de_onibus import get_comparativo_corredores_de_onibus

# Passageiros
from .historico_pax_transportados import get_historico_pax_transportados
from .demanda_pax_pagamento import get_demanda_pax_pagamento
from .demanda_pax_integracao import get_demanda_pax_integracao

# Oferta de Viagens e Quilometragem
from .historico_km_percorridos import get_historico_km_percorridos

# Climatização da Frota
from .climatizacao_frota_total import get_climatizacao_frota_total
from .climatizacao_frota_por_consorcio import get_climatizacao_frota_por_consorcio

### Metrô
# Passageiros
from .metro_pax_transportados_por_ano import get_metro_pax_transportados_por_ano
from .metro_pax_transportados_por_mes import get_metro_pax_transportados_por_mes

### STEC
# Passageiros
from .demanda_pax_stec import get_demanda_pax_stec

### Indicadores
# Segurança Pública e Mobilidade
from .assaltos_por_viagem import get_assaltos_por_viagem