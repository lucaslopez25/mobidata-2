from django.urls import path
from . import views

urlpatterns = [
    path('', views.mainpage_dashboard, name='mainpage_dashboard'),
    path('exportar_csv', views.exportar_csv, name='exportar_csv'),
]
