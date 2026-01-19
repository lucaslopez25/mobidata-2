import pdfplumber
import pandas as pd

with pdfplumber.open("2022 - Anuário de Transportes Urbanos de Salvador.pdf") as pdf:
    table = pdf.pages[40].extract_table()

df = pd.DataFrame(table[1:], columns=table[0])

print(df)
df.to_csv("veiculos_cadastrados_novos_usados_2022.csv", index=False)