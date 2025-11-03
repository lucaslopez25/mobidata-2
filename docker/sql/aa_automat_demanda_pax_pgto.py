import os

def gerar_script_sql():
    """
    Solicita o ano e tipo_pagamento, então entra em um loop para coletar
    os 4 valores de demanda para cada um dos 12 meses, gerando o script SQL.
    """
    print("--- Gerador de Script SQL de Demanda de Passageiros ---\n")
    
    # 1. Solicita os parâmetros iniciais
    ano = input("Digite o ANO (ex: 2024): ")
    tipo_pagamento = input("Digite o TIPO_PAGAMENTO (ex: 'VALE-TRANSPORTE'): ").strip().upper()
    
    # Validação básica
    if not ano.isdigit() or not tipo_pagamento:
        print("\nErro: Ano deve ser um número e Tipo de Pagamento não pode ser vazio.")
        return

    # Lista de meses para o loop
    meses = [
        "JANEIRO", "FEVEREIRO", "MARÇO", "ABRIL", "MAIO", "JUNHO", 
        "JULHO", "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO"
    ]
    
    sql_entries = []
    
    # 2. Inicia o loop de 12 meses
    print(f"\n--- Coletando dados para {tipo_pagamento} no ano {ano} ---\n")
    
    for mes_index, mes_nome in enumerate(meses):
        mes = mes_index + 1
        print(f"--- Mês {mes} ({mes_nome}) ---")
        
        # 3. Solicita os 4 dados e trata o input
        
        # Função interna para solicitar um valor e retornar o formato SQL
        def get_demanda_input(prompt):
            valor = input(prompt).strip()
            # Se o input estiver vazio, retorna a string 'NULL'
            if not valor:
                return 'NULL'
            # Tenta converter para inteiro, se falhar, retorna NULL (para evitar SQL injection/erros)
            try:
                # Retorna o número como string (sem aspas) para o SQL
                return str(int(valor)) 
            except ValueError:
                print(f"  [AVISO]: Valor '{valor}' não é um número válido. Usando NULL.")
                return 'NULL'

        demanda = get_demanda_input("  Demanda (total na catraca): ")
        demanda_int_metro = get_demanda_input("  Demanda Int. Metrô: ")
        demanda_int_stec = get_demanda_input("  Demanda Int. STEC: ")
        demanda_int_brt = get_demanda_input("  Demanda Int. BRT: ")
        
        # Formata o comando INSERT
        insert_line = (
            f"INSERT INTO demanda_pax_por_pagamento(ano, mes, tipo_pagamento, demanda, demanda_int_metro, demanda_int_stec, demanda_int_brt) "
            f"VALUES ({ano}, {mes}, '{tipo_pagamento}', {demanda}, {demanda_int_metro}, {demanda_int_stec}, {demanda_int_brt});"
        )
        sql_entries.append(insert_line)
        print("-" * 25)

    # 4. Gera e salva o arquivo SQL
    output_filename = f"insert_manual_{ano}_{tipo_pagamento.lower().replace(' ', '_')}.sql"
    
    sql_script = f"-- Script de INSERT gerado manualmente (Ano: {ano}, Tipo: {tipo_pagamento})\n\n"
    sql_script += "\n".join(sql_entries)
    
    try:
        with open(output_filename, 'w') as f:
            f.write(sql_script)
            
        print("\n" + "=" * 50)
        print(f"✅ SUCESSO! O script SQL foi gerado e salvo em: {output_filename}")
        print("=" * 50)
        
        # Exibe o conteúdo para confirmação
        print("\n--- Conteúdo Gerado (Primeiras Linhas) ---")
        print("\n".join(sql_entries[:3]))
        print("...")
        
    except Exception as e:
        print(f"\n❌ Erro ao salvar o arquivo: {e}")

# Inicia o gerador
if __name__ == "__main__":
    gerar_script_sql()