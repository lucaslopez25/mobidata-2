from django.urls import path
from . import views

urlpatterns = [
    path('', views.landing, name='landing'),
    path('frota_de_onibus_por_ano', views.frota_de_onibus_por_ano, name='frota_de_onibus_por_ano'),
    path('exportar_csv', views.exportar_csv, name='exportar_csv'),
]
