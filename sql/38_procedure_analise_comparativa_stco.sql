CREATE OR REPLACE PROCEDURE analise_comparativa_stco()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    salario_minimo_ano NUMERIC(10,2);
    custo_por_km NUMERIC(15,2);
    percentual_tarifa_sm NUMERIC(10,2);
    qtd_passagens_compra_um_sm NUMERIC(10,2);
BEGIN
    DROP TABLE IF EXISTS resultado_analise;
    CREATE TEMP TABLE resultado_analise (
        ano INT,
        salario_minimo_ano NUMERIC(10,2),
        tarifa_sobre_sm NUMERIC(10,2),
        custo_operacional_por_km NUMERIC(15,2),
        qtd_passagens_compra_um_sm NUMERIC(10,2)
    );
    
    FOR rec IN 
        SELECT DISTINCT d.ano 
        FROM dados_stco d
        JOIN tarifa_preco_stco t ON d.ano = t.ano
        ORDER BY d.ano DESC
    LOOP
        -- Obter salário mínimo do ano
        SELECT valor_salario INTO salario_minimo_ano
        FROM salario_minimo
        WHERE ano = rec.ano
        ORDER BY data_ajuste DESC
        LIMIT 1;
        
        -- Calcular custo operacional por km
        SELECT (passageiros_equivalente / quilometragem_total) INTO custo_por_km
        FROM dados_stco
        WHERE ano = rec.ano;
        
        -- Calcular percentual da tarifa sobre o salário mínimo
        SELECT ((t.valor / sm.valor_salario) * 100) INTO percentual_tarifa_sm
        FROM tarifa_preco_stco t
        JOIN salario_minimo sm ON t.ano = sm.ano
        WHERE t.ano = rec.ano
        ORDER BY sm.data_ajuste DESC
        LIMIT 1;
        
        -- Calcular total de passagens possíveis com 1 salário mínimo
        SELECT FLOOR(sm.valor_salario / t.valor)::NUMERIC(10,2) INTO qtd_passagens_compra_um_sm
        FROM tarifa_preco_stco t
        JOIN salario_minimo sm ON t.ano = sm.ano
        WHERE t.ano = rec.ano
        ORDER BY sm.data_ajuste DESC
        LIMIT 1;
        
        -- Inserir resultados na tabela temporária
        INSERT INTO resultado_analise VALUES (
            rec.ano,
            salario_minimo_ano,
            percentual_tarifa_sm,
            custo_por_km,
            qtd_passagens_compra_um_sm
        );
    END LOOP;
END;
$$;