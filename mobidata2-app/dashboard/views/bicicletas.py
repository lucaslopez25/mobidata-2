from django.shortcuts import render

def bicicletas(request):
    return render(request, 'bicicletas.html')