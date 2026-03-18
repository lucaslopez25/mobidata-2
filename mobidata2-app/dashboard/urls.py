from django.urls import path
from . import views

urlpatterns = [
    # Legacy
    path('dados_taxis', views.dados_taxis, name='dados_taxis'),
    path('aspectos_economicos', views.aspectos_economicos, name='aspectos_economicos'),
    path('bicicletas', views.bicicletas, name='bicicletas'),

    # Atualizado
    path('', views.home, name='home'),
    path('exportar_csv/<str:tipo>/', views.exportar_dados_csv, name='exportar_csv'),
]
