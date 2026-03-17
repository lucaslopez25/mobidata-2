from django.urls import path
from . import views

urlpatterns = [
    path('landing', views.landing, name='landing'),
    path('stco/frota_de_onibus', views.frota_de_onibus_stco, name='stco_frota_de_onibus'),
    # path('stec/frota_de_onibus', views.frota_de_onibus_stec, name='stec_frota_de_onibus'),
    # path('stco/climatizacao_frota', views.climatizacao_frota, name='stco_climatizacao_frota'),
    path('dados_taxis', views.dados_taxis, name='dados_taxis'),
    path('stco/dados_operacionais', views.dados_operacionais_stco, name='stco_dados_operacionais'),
    path('stec/dados_operacionais', views.dados_operacionais_stec, name='stec_dados_operacionais'),
    path('aspectos_economicos', views.aspectos_economicos, name='aspectos_economicos'),
    # path('dados_metro', views.dados_metro, name='dados_metro'),
    path('bicicletas', views.bicicletas, name='bicicletas'),
    # path('indicadores_desempenho', views.indicadores_desempenho, name='indicadores_desempenho'),
    path('exportar_csv/<str:tipo>/', views.exportar_dados_csv, name='exportar_csv'),

    path('', views.home, name='home'),
]
