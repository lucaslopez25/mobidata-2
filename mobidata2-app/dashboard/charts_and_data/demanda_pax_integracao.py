import pandas
import plotly.express as plotxp
from dashboard.models import DemandaPaxPorPagamento

def get_demanda_pax_integracao():
    demanda_pax = DemandaPaxPorPagamento.objects.all().order_by('ano', 'mes')

    if not demanda_pax.exists():
        return None

    df = pandas.DataFrame(list(demanda_pax.values(
        'ano', 'mes', 'demanda', 'demanda_int_metro', 'demanda_int_stec', 'demanda_int_brt'
    )))
    
    df['mes_str'] = df['mes'].apply(lambda x: f"{x:02d}")
    df['ano_mes'] = df['ano'].astype(str) + '-' + df['mes_str']

    # Agrupar e somar todos os tipos de pagamento por mês
    df_grouped = df.groupby('ano_mes')[[
        'demanda', 'demanda_int_metro', 'demanda_int_stec', 'demanda_int_brt'
    ]].sum().reset_index()
    
    # Transformar para formato longo (melt) para o Plotly
    df_melted = df_grouped.melt(
        id_vars='ano_mes', 
        var_name='tipo_demanda', 
        value_name='quantidade'
    )
    
    fig = plotxp.bar(
        df_melted,
        x='ano_mes',
        y='quantidade',
        color='tipo_demanda',
        barmode='stack',
        title='Demanda Total e Integrações por Mês',
        labels={
            'tipo_demanda': 'Tipo de Demanda',
            'ano_mes': 'Ano-Mês',
            'quantidade': 'Passageiros',
        },
    )
    
    fig.update_layout(xaxis_title='Ano-Mês', yaxis_title='Demanda Total')
    
    return fig