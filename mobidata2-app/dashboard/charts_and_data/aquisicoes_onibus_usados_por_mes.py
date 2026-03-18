import pandas
import plotly.express as plotxp
from dashboard.models import AquisicoesDeOnibusPorMes
from dashboard.utils import get_cores_concessionarias 

def get_aquisicoes_onibus_usados_por_mes():
    aquisicoes = AquisicoesDeOnibusPorMes.objects.filter(novo_ou_usado=False).order_by('ano', 'mes')

    if not aquisicoes.exists():
        return None

    data_frame = pandas.DataFrame(list(aquisicoes.values('ano', 'mes', 'id_concessionaria', 'qtd_onibus')))
    
    # Tratamento de data
    data_frame['mes_str'] = data_frame['mes'].apply(lambda x: f"{x:02d}")
    data_frame['ano_mes'] = data_frame['ano'].astype(str) + '-' + data_frame['mes_str']

    grafico = plotxp.bar(
        data_frame,
        x='ano_mes',
        y='qtd_onibus',
        color='id_concessionaria',
        barmode='stack',
        title='Aquisições de Ônibus Usados por Mês',
        labels={
            'id_concessionaria': 'Concessionária',
            'ano_mes': 'Ano-Mês',
            'qtd_onibus': 'Qtd Usados',
        },
        color_discrete_map=get_cores_concessionarias()
    )
    
    grafico.update_layout(xaxis_title='Ano-Mês', yaxis_title='Quantidade de ônibus adquiridos')
    return grafico