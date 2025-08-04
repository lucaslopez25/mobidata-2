import sys

def gerar_insert_aquisicoes():
    print("""
    ╔══════════════════════════════════╗
    ║ GERADOR DE INSERTS SQL - ÔNIBUS  ║
    ╚══════════════════════════════════╝
    """)
    
    # Mapeamento de concessionárias
    concessionarias = {
        '1': ('SPE2', 'OTTRANS'),
        '2': ('SPE3', 'PLATAFORMA')
        #'3': ('SPE1', 'INTEGRA SALVADOR NORTE'),
        #'4': ('BRT1', 'BRT (CCO)')
    }
    
    # Solicitar ano de referência
    ano = input("Ano de referência: ").strip()
    
    inserts = []
    
    # Para cada concessionária
    for cod, (id_conc, nome_conc) in concessionarias.items():
        print(f"\n► Dados para {nome_conc} ({id_conc})")
        
        # Para cada mês
        meses = [
            ('1', 'Janeiro'), ('2', 'Fevereiro'), ('3', 'Março'), ('4', 'Abril'),
            ('5', 'Maio'), ('6', 'Junho'), ('7', 'Julho'), ('8', 'Agosto'),
            ('9', 'Setembro'), ('10', 'Outubro'), ('11', 'Novembro'), ('12', 'Dezembro')
        ]
        
        for num_mes, nome_mes in meses:
            print(f"\n  Mês: {nome_mes}")
            
            # Obter quantidade de ônibus novos
            while True:
                novos = input(f"  Quantidade de ônibus NOVOS adquiridos: ").strip()
                if novos.isdigit() or novos == '':
                    break
                print("  Por favor, digite um número inteiro ou deixe em branco para zero.")
            
            # Obter quantidade de ônibus usados
            while True:
                usados = input(f"  Quantidade de ônibus USADOS adquiridos: ").strip()
                if usados.isdigit() or usados == '':
                    break
                print("  Por favor, digite um número inteiro ou deixe em branco para zero.")
            
            # Processar valores (vazio = 0)
            qtd_novos = int(novos) if novos else 0
            qtd_usados = int(usados) if usados else 0
            
            # Gerar linhas INSERT
            if qtd_novos > 0:
                inserts.append(f"('{id_conc}', {num_mes}, {ano}, {qtd_novos}, TRUE)")
            if qtd_usados > 0:
                inserts.append(f"('{id_conc}', {num_mes}, {ano}, {qtd_usados}, FALSE)")
    
    # Montar o script SQL completo
    if not inserts:
        print("\nNenhum dado foi inserido. Script vazio.")
        return
    
    new_line = ',\n'
    sql_script = f"""INSERT INTO aquisicoes_de_onibus_por_mes(
    id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
{new_line.join(inserts)}
ON CONFLICT DO NOTHING;"""
    
    # Oferecer opções ao usuário
    print("\n╔═════════════════════════════════╗")
    print("║ OPERAÇÃO CONCLUÍDA COM SUCESSO  ║")
    print("╚═════════════════════════════════╝")
    print("\nEscolha uma opção:")
    print("1. Exibir script na tela")
    print("2. Salvar em arquivo SQL")
    print("3. Ambos")
    opcao = input("Digite sua escolha (1-3): ").strip()
    
    if opcao in ('1', '3'):
        print("\n" + "="*80 + "\n")
        print(sql_script)
        print("\n" + "="*80 + "\n")
    
    if opcao in ('2', '3'):
        nome_arquivo = f"insert_aquisicoes_onibus_{ano}.sql"
        with open(nome_arquivo, 'w', encoding='utf-8') as f:
            f.write(sql_script)
        print(f"\nScript salvo como '{nome_arquivo}'")

if __name__ == "__main__":
    try:
        gerar_insert_aquisicoes()
    except KeyboardInterrupt:
        print("\nOperação cancelada pelo usuário.")
        sys.exit(0)
    except Exception as e:
        print(f"\nOcorreu um erro: {str(e)}")
        sys.exit(1)