from django.urls import path
from . import views

urlpatterns = [
    path('', views.landing, name='landing'),
    path('frota_de_onibus_stco', views.frota_de_onibus_stco, name='frota_de_onibus_stco'),
    path('dados_taxis', views.dados_taxis, name='dados_taxis'),
    path('dados_operativos', views.dados_operativos, name='dados_operativos'),
    path('dados_metro', views.dados_metro, name='dados_metro'),
    path('bicicletas', views.bicicletas, name='bicicletas'),
    path('exportar_csv', views.exportar_csv, name='exportar_csv'),
]
