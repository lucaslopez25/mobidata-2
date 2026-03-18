from dashboard.models import ComparativoFrotaStco

import pandas # type: ignore
import plotly.express as plotxp # type: ignore

def get_comparativo_frota_operante_frota_total():

    ###################### ComparativoFrotaStco

    comparativo_frota_stco = ComparativoFrotaStco.objects.all().order_by('ano')

    if comparativo_frota_stco.exists():
        df_comp = pandas.DataFrame(list(comparativo_frota_stco.values('ano', 'frota_operante', 'frota_total')))

        df_melted = df_comp.melt(
            id_vars=['ano'], 
            value_vars=['frota_operante', 'frota_total'],
            var_name='tipo_frota', 
            value_name='quantidade'
        )

        labels_map = {
            'frota_total': 'Frota Total',
            'frota_operante': 'Frota Operante'
        }
        df_melted['tipo_frota'] = df_melted['tipo_frota'].map(labels_map)

        grafico_comparativo_frota = plotxp.line(
            df_melted,
            x='ano',
            y='quantidade',
            color='tipo_frota',
            markers=True,
            title='Comparativo de Frota Operante e Total',
            color_discrete_map={
                'Frota Total': '#EF553B',
                'Frota Operante': '#636EFA'
            }
        )

        grafico_comparativo_frota.update_layout(
            xaxis_title='Ano',
            yaxis_title='Quantidade de Ônibus',
            legend_title='Legenda',
            xaxis=dict(tickmode='linear'),
            hovermode="x unified"
        )
    else:
        grafico_comparativo_frota = None

    return grafico_comparativo_frota