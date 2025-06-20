from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('matplot', views.testematplotlib, name='testematplotlib'),
    path('matplot2', views.testematplotlib2, name='testematplotlib2'),
    path('historico_idade_media_frota', views.historico_idade_media_frota, name='historico_idade_media_frota'),
    path('exportar_csv', views.exportar_csv, name='exportar_csv'),
]
