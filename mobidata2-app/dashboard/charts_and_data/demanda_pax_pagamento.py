import pandas
import plotly.express as plotxp
from dashboard.models import DemandaPaxPorPagamento

def get_demanda_pax_pagamento():
    demanda_pax = DemandaPaxPorPagamento.objects.all().order_by('ano', 'mes')

    if not demanda_pax.exists():
        return None

    df = pandas.DataFrame(list(demanda_pax.values('ano', 'mes', 'tipo_pagamento', 'demanda')))
    
    df['mes_str'] = df['mes'].apply(lambda x: f"{x:02d}")
    df['ano_mes'] = df['ano'].astype(str) + '-' + df['mes_str']

    fig = plotxp.bar(
        df,
        x='ano_mes',
        y='demanda',
        color='tipo_pagamento',
        barmode='stack',
        title='Demanda de Passageiros por Tipo de Pagamento',
        labels={
            'tipo_pagamento': 'Tipo de Pagamento',
            'ano_mes': 'Ano-Mês',
            'demanda': 'Passageiros',
        },
    )
    
    fig.update_layout(xaxis_title='Ano-Mês', yaxis_title='Demanda')

    return fig