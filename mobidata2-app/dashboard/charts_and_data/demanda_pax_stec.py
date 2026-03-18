from dashboard.models import DemandaPaxStec

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_demanda_pax_stec():

    ###################### DemandaPaxStec

    demanda_pax_stec = DemandaPaxStec.objects.all().order_by('ano', 'mes')

    if demanda_pax_stec.exists():
        df_stec = pandas.DataFrame(list(demanda_pax_stec.values('ano', 'mes', 'pax_total', 'pax_equivalente')))
        
        df_stec['mes_str'] = df_stec['mes'].apply(lambda x: f"{x:02d}")
        df_stec['ano_mes'] = df_stec['ano'].astype(str) + '-' + df_stec['mes_str']

        df_stec_melted = df_stec.melt(
            id_vars=['ano_mes'], 
            value_vars=['pax_total', 'pax_equivalente'],
            var_name='tipo_passageiro', 
            value_name='quantidade'
        )

        df_stec_melted['tipo_passageiro'] = df_stec_melted['tipo_passageiro'].map({
            'pax_total': 'Passageiros Totais',
            'pax_equivalente': 'Passageiros Equivalentes'
        })

        grafico = plotxp.line(
            df_stec_melted,
            x='ano_mes',
            y='quantidade',
            color='tipo_passageiro',
            markers=True,
            title='Demanda de Passageiros do STEC',
            labels={'ano_mes': 'Período', 'quantidade': 'Nº de Passageiros', 'tipo_passageiro': 'Tipo'}
        )

        grafico.update_layout(
            xaxis_title='Ano-Mês',
            yaxis_title='Quantidade de Passageiros',
            hovermode="x unified",
            legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1)
        )
        
    else:
        grafico = None

    return grafico