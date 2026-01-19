import pdfplumber
import pandas as pd

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)

tables = []

with pdfplumber.open("2024 - Anuário de Transportes Urbanos de Salvador.pdf") as pdf:
    for page in pdf.pages:
        tables_on_page = page.extract_tables({})

        if tables_on_page:
            for table in tables_on_page:
                if table:
                    tables.append({
                        'page': pdf.pages.index(page) + 1,
                        'data': table
                    })


with open("tabelas_extraidas.txt", "w", encoding="utf-8") as textfile:
    for table in tables:
        df = pd.DataFrame(table['data'])

        textfile.write(f"PÁGINA: {table['page']}\n\n")
        textfile.write(df.to_string(index=False))
        textfile.write("\n\n")