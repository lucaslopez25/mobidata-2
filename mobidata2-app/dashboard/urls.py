from django.urls import path
from . import views

urlpatterns = [
    path('', views.landing, name='landing'),
    path('frota_de_onibus_stco', views.frota_de_onibus_stco, name='frota_de_onibus_stco'),
    path('stco/climatizacao_frota', views.climatizacao_frota, name='stco_climatizacao_frota'),
    path('dados_taxis', views.dados_taxis, name='dados_taxis'),
    path('dados_operativos', views.dados_operativos, name='dados_operativos'),
    path('dados_financeiros', views.dados_financeiros, name='dados_financeiros'),
    path('dados_metro', views.dados_metro, name='dados_metro'),
    path('bicicletas', views.bicicletas, name='bicicletas'),
    path('exportar_csv/<str:tipo>/', views.exportar_dados_csv, name='exportar_csv'),
]
