from dashboard.models import HistoricoIdadeMediaFrota

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_historico_idade_media_da_frota():

    dados = HistoricoIdadeMediaFrota.objects.all().order_by('ano', 'mes')

    if dados.exists():
        data_frame = pandas.DataFrame(list(dados.values('ano', 'mes', 'idade_media')))
        data_frame['mes'] = data_frame['mes'].apply(lambda x: f"{x:02d}")
        data_frame['ano_mes'] = data_frame['ano'].astype(str) + '-' + data_frame['mes']

        grafico = plotxp.line(
            data_frame, 
            x='ano_mes', 
            y='idade_media', 
            markers=True, 
            title='Idade média da frota'
        )
        grafico.update_layout(xaxis_title='Ano-Mês', yaxis_title='Idade média em anos')
    else:
        grafico = None

    return grafico