from django.urls import path
from . import views

urlpatterns = [
    path('', views.landing, name='landing'),
    path('frota_de_onibus_stco_historico', views.frota_de_onibus_stco_historico, name='frota_de_onibus_stco_historico'),
    path('frota_de_onibus_stco_por_ano', views.frota_de_onibus_stco_por_ano, name='frota_de_onibus_stco_por_ano'),
    path('dados_operativos_historico', views.dados_operativos_historico, name='dados_operativos_historico'),
    path('dados_operativos_por_ano', views.dados_operativos_por_ano, name='dados_operativos_por_ano'),
    path('dados_taxis_por_ano', views.dados_taxis_por_ano, name='dados_taxis_por_ano'),
    path('bicicletas', views.bicicletas, name='bicicletas'),
    path('exportar_csv', views.exportar_csv, name='exportar_csv'),
]
