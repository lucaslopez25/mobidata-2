import pandas
import plotly.express as plotxp
import plotly.graph_objects as go
from dashboard.models import IndicadoresFinanceirosStco
from dashboard.utils import get_cores_concessionarias

def get_receitas_por_concessionaria():

    concessionarias = ['SPE1', 'SPE2', 'SPE3']
    queryset = IndicadoresFinanceirosStco.objects.filter(
        id_concessionaria__in=concessionarias,
        tipo_conta__in=['Receita Bruta', 'Receita Líquida']
    ).order_by('ano')

    if not queryset.exists():
        return None

    df = pandas.DataFrame(list(queryset.values('id_concessionaria', 'ano', 'tipo_conta', 'valor')))
    df['valor'] = df['valor'].astype(float)
    
    cores_base = get_cores_concessionarias()
    fig = go.Figure()

    # 2. Criamos as camadas (traces) para cada concessionária
    # Inicialmente, deixaremos apenas a SPE2 visível
    for cons in concessionarias:
        df_temp = df[df['id_concessionaria'] == cons]
        cor = cores_base.get(cons, '#808080')
        
        # Linha de Receita Bruta
        fig.add_trace(go.Scatter(
            x=df_temp[df_temp['tipo_conta'] == 'Receita Bruta']['ano'],
            y=df_temp[df_temp['tipo_conta'] == 'Receita Bruta']['valor'],
            name=f"Receita Bruta ({cons})",
            line=dict(color=cor, width=3),
            visible=(cons == 'SPE2') # Só SPE2 começa visível
        ))
        
        # Linha de Receita Líquida
        fig.add_trace(go.Scatter(
            x=df_temp[df_temp['tipo_conta'] == 'Receita Líquida']['ano'],
            y=df_temp[df_temp['tipo_conta'] == 'Receita Líquida']['valor'],
            name=f"Receita Líquida ({cons})",
            line=dict(color=cor, width=2, dash='dot'),
            visible=(cons == 'SPE2')
        ))

    # 3. Criamos o Menu Dropdown interno
    dropdown_buttons = [
        {
            "label": "Salvador Norte (SPE1)",
            "method": "update",
            "args": [{"visible": [True, True, False, False, False, False]},
                     {"title": "Evolução de Receitas - SPE1"}]
        },
        {
            "label": "OT Trans (SPE2)",
            "method": "update",
            "args": [{"visible": [False, False, True, True, False, False]},
                     {"title": "Evolução de Receitas - SPE2"}]
        },
        {
            "label": "Plataforma (SPE3)",
            "method": "update",
            "args": [{"visible": [False, False, False, False, True, True]},
                     {"title": "Evolução de Receitas - SPE3"}]
        }
    ]

    fig.update_layout(
        # 1. Posicionamento da Legenda (Canto Superior Direito, dentro da margem)
        legend=dict(
            orientation="v",
            yanchor="top",
            y=1.0,
            xanchor="left",
            x=1.02  # Começa logo após o fim do gráfico (que termina em 0.85)
        ),

        # 2. Posicionamento do Menu (Logo abaixo da legenda)
        updatemenus=[{
            "buttons": dropdown_buttons,
            "direction": "down",
            "showactive": True,
            "x": 1.02, # Alinhado à esquerda com a legenda
            "xanchor": "left",
            "y": 0.7,  # Descido um pouco mais para não encostar na legenda
            "yanchor": "top"
        }],

        # 3. O SEGREDO: Definimos que o gráfico só ocupa 85% da largura
        # Isso reserva os 15% da direita exclusivamente para os controles
        xaxis=dict(
            tickmode='linear', 
            title='Ano',
            domain=[0, 0.85] # Gráfico vai de 0 a 0.85. Controles ficam de 0.85 a 1.0
        ),
        
        yaxis=dict(title='Valor (R$)'),
        
        # Margens ajustadas: r=20 é suficiente agora que usamos 'domain'
        margin=dict(l=20, r=20, t=80, b=20),
        
        title="Evolução de Receitas",
        template="plotly_white"
    )

    return fig.to_html(full_html=False, include_plotlyjs='cdn')