CREATE TABLE indicadores_financeiros_stco (
    id SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    tipo_conta VARCHAR(50) NOT NULL,
    ano INTEGER NOT NULL,
    valor NUMERIC(15,2),
    unidade_medida VARCHAR(20),
    fonte VARCHAR(100),
    observacoes TEXT,
    CONSTRAINT uk_indicador UNIQUE (id_concessionaria, tipo_conta, ano)
);

COMMENT ON TABLE indicadores_financeiros_stco IS 'Armazena os indicadores financeiros do Sistema de Transporte Coletivo por Ônibus (STCO)';
COMMENT ON COLUMN indicadores_financeiros_stco.tipo_conta IS 'Tipo de indicador financeiro (Receita Bruta, Receita Líquida, etc.)';
COMMENT ON COLUMN indicadores_financeiros_stco.ano IS 'Ano de referência do dado';
COMMENT ON COLUMN indicadores_financeiros_stco.unidade_medida IS 'Unidade de medida (R$, %)';
COMMENT ON COLUMN indicadores_financeiros_stco.fonte IS 'Fonte dos dados';
COMMENT ON COLUMN indicadores_financeiros_stco.observacoes IS 'Observações adicionais sobre o registro';

INSERT INTO indicadores_financeiros_stco (id_concessionaria, tipo_conta, ano, valor, unidade_medida, fonte, observacoes) VALUES

('SPE2', 'Receita Bruta', 2015, 236432000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Bruta', 2016, 346131000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Bruta', 2017, 374098000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Bruta', 2018, 360368000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Bruta', 2019, 365287000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Receita Bruta', 2020, 292504000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Receita Bruta', 2021, 336840000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE2', 'Receita Bruta', 2022, 565213000, 'R$', 'ASSAL', NULL),
('SPE2', 'Receita Bruta', 2023, 582054000, 'R$', 'ASSAL', NULL),

('SPE2', 'Receita Líquida', 2015, 225794000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Líquida', 2016, 330521000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Líquida', 2017, 357301000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Líquida', 2018, 343618000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Receita Líquida', 2019, 351927000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Receita Líquida', 2020, 286518000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Receita Líquida', 2021, 330100000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE2', 'Receita Líquida', 2022, 537704000, 'R$', 'ASSAL', NULL),
('SPE2', 'Receita Líquida', 2023, 570413000, 'R$', 'ASSAL', NULL),

('SPE2', 'Custos Operacionais', 2015, 213887000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Custos Operacionais', 2016, 315879000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Custos Operacionais', 2017, 324660000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Custos Operacionais', 2018, 281487000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Custos Operacionais', 2019, 270735000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Custos Operacionais', 2020, 208143000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Custos Operacionais', 2021, 290640000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE2', 'Custos Operacionais', 2022, 450522000, 'R$', 'ASSAL', NULL),
('SPE2', 'Custos Operacionais', 2023, 420182000, 'R$', 'ASSAL', NULL),

('SPE2', 'Despesas Administrativas', 2015, 17647000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Despesas Administrativas', 2016, 28471000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Despesas Administrativas', 2017, 32397000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Despesas Administrativas', 2018, 34500000, 'R$', 'Auditoria de balanço', NULL),
('SPE2', 'Despesas Administrativas', 2019, 38251000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Despesas Administrativas', 2020, 31887000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE2', 'Despesas Administrativas', 2021, 58060000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE2', 'Despesas Administrativas', 2022, 44442000, 'R$', 'ASSAL', NULL),
('SPE2', 'Despesas Administrativas', 2023, 45764000, 'R$', 'ASSAL', NULL),

('SPE2', 'Margem EBITDA', 2015, -254, '%', 'Auditoria de balanço', '2.54% negativo'),
('SPE2', 'Margem EBITDA', 2016, -418, '%', 'Auditoria de balanço', '4.18% negativo'),
('SPE2', 'Margem EBITDA', 2017, 7, '%', 'Auditoria de balanço', '0.07%'),
('SPE2', 'Margem EBITDA', 2018, 804, '%', 'Auditoria de balanço', '8.04%'),
('SPE2', 'Margem EBITDA', 2019, 1220, '%', 'FIPECAFI (balanços)', '12.20%'),
('SPE2', 'Margem EBITDA', 2020, 1623, '%', 'FIPECAFI (balanços)', '16.23%'),
('SPE2', 'Margem EBITDA', 2021, -563, '%', 'FIPECAFI (até out/2021)', '5.63% negativo'),
('SPE2', 'Margem EBITDA', 2022, 795, '%', 'ASSAL', '7.95%'),
('SPE2', 'Margem EBITDA', 2023, 1831, '%', 'ASSAL', '18.31%')
ON CONFLICT DO NOTHING;

INSERT INTO indicadores_financeiros_stco (id_concessionaria, tipo_conta, ano, valor, unidade_medida, fonte, observacoes) VALUES
('SPE3', 'Receita Bruta', 2015, 194976000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Bruta', 2016, 290738000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Bruta', 2017, 287828000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Bruta', 2018, 313738000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Bruta', 2019, 362271000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Receita Bruta', 2020, 224526000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Receita Bruta', 2021, 238520000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE3', 'Receita Bruta', 2022, 412690000, 'R$', 'ASSAL', NULL),
('SPE3', 'Receita Bruta', 2023, 404422000, 'R$', 'ASSAL', NULL),

('SPE3', 'Receita Líquida', 2015, 186238000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Líquida', 2016, 227684000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Líquida', 2017, 279923000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Líquida', 2018, 298857000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Receita Líquida', 2019, 293884000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Receita Líquida', 2020, 220163000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Receita Líquida', 2021, 233750000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE3', 'Receita Líquida', 2022, 393195000, 'R$', 'ASSAL', NULL),
('SPE3', 'Receita Líquida', 2023, 396533000, 'R$', 'ASSAL', NULL),

('SPE3', 'Custos Operacionais', 2015, 185948000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Custos Operacionais', 2016, 267130000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Custos Operacionais', 2017, 270281000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Custos Operacionais', 2018, 230406000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Custos Operacionais', 2019, 231052000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Custos Operacionais', 2020, 162056000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Custos Operacionais', 2021, 220670000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE3', 'Custos Operacionais', 2022, 308569000, 'R$', 'ASSAL', NULL),
('SPE3', 'Custos Operacionais', 2023, 316468000, 'R$', 'ASSAL', NULL),

('SPE3', 'Despesas Administrativas', 2015, 22750000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Despesas Administrativas', 2016, 33566000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Despesas Administrativas', 2017, 38170000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Despesas Administrativas', 2018, 34500000, 'R$', 'Auditoria de balanço', NULL),
('SPE3', 'Despesas Administrativas', 2019, 41993000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Despesas Administrativas', 2020, 27461000, 'R$', 'FIPECAFI (balanços)', NULL),
('SPE3', 'Despesas Administrativas', 2021, 33770000, 'R$', 'FIPECAFI (até out/2021)', NULL),
('SPE3', 'Despesas Administrativas', 2022, 32353000, 'R$', 'ASSAL', NULL),
('SPE3', 'Despesas Administrativas', 2023, 34446000, 'R$', 'ASSAL', NULL),

('SPE3', 'Margem EBITDA', 2015, -1206, '%', 'Auditoria de balanço', '12.06% negativo'),
('SPE3', 'Margem EBITDA', 2016, -3207, '%', 'Auditoria de balanço', '32.07% negativo'),
('SPE3', 'Margem EBITDA', 2017, -1019, '%', 'Auditoria de balanço', '10.19% negativo'),
('SPE3', 'Margem EBITDA', 2018, 1186, '%', 'Auditoria de balanço', '11.86%'),
('SPE3', 'Margem EBITDA', 2019, 709, '%', 'FIPECAFI (balanços)', '7.09%'),
('SPE3', 'Margem EBITDA', 2020, 1392, '%', 'FIPECAFI (balanços)', '13.92%'),
('SPE3', 'Margem EBITDA', 2021, -885, '%', 'FIPECAFI (até out/2021)', '8.85% negativo'),
('SPE3', 'Margem EBITDA', 2022, 1329, '%', 'ASSAL', '13.29%'),
('SPE3', 'Margem EBITDA', 2023, 1150, '%', 'ASSAL', '11.50%')
ON CONFLICT DO NOTHING;

INSERT INTO indicadores_financeiros_stco (id_concessionaria, tipo_conta, ano, valor, unidade_medida, fonte, observacoes) VALUES
('SPE1', 'Receita Bruta', 2015, 200996000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Bruta', 2016, 294584000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Bruta', 2017, 294971000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Bruta', 2018, 356778000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Bruta', 2019, 311231000, 'R$', 'FIPECAFI (balanços)', NULL),

('SPE1', 'Receita Líquida', 2015, 191447000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Líquida', 2016, 281232000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Líquida', 2017, 281482000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Líquida', 2018, 340754000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Receita Líquida', 2019, 295207000, 'R$', 'FIPECAFI (balanços)', NULL),

('SPE1', 'Custos Operacionais', 2015, 180045000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Custos Operacionais', 2016, 302525000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Custos Operacionais', 2017, 307644000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Custos Operacionais', 2018, 265184000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Custos Operacionais', 2019, 258554000, 'R$', 'FIPECAFI (balanços)', NULL),

('SPE1', 'Despesas Administrativas', 2015, 36057000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Despesas Administrativas', 2016, 37574000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Despesas Administrativas', 2017, 42207000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Despesas Administrativas', 2018, 41588000, 'R$', 'Auditoria de balanço', NULL),
('SPE1', 'Despesas Administrativas', 2019, 44135000, 'R$', 'FIPECAFI (balanços)', NULL),

('SPE1', 'Margem EBITDA', 2015, -1288, '%', 'Auditoria de balanço', '12.88% negativo'),
('SPE1', 'Margem EBITDA', 2016, -2093, '%', 'Auditoria de balanço', '20.93% negativo'),
('SPE1', 'Margem EBITDA', 2017, -2429, '%', 'Auditoria de balanço', '24.29% negativo'),
('SPE1', 'Margem EBITDA', 2018, 997, '%', 'Auditoria de balanço', '9.97%'),
('SPE1', 'Margem EBITDA', 2019, -255, '%', 'FIPECAFI (balanços)', '2.55% negativo')
ON CONFLICT DO NOTHING;

CREATE TABLE salario_minimo (
    id SERIAL PRIMARY KEY,
    ano INTEGER NOT NULL,
    data_ajuste DATE NOT NULL,
    valor_salario NUMERIC(10,2) NOT NULL,
    ato_legal VARCHAR(50) NOT NULL,
    percentual_ajuste NUMERIC(5,2) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_ano_data UNIQUE (ano, data_ajuste)
);

INSERT INTO salario_minimo (ano, data_ajuste, valor_salario, ato_legal, percentual_ajuste) VALUES
(2024, '2024-01-01', 1412.00, 'DECRETO 11.864/2023', 6.97),
(2023, '2023-05-01', 1320.00, 'Lei 14.663/2023', 1.38),
(2023, '2023-01-01', 1302.00, 'MP 1143/2022', 7.43),
(2022, '2022-01-01', 1212.00, 'Lei 14.358/2022', 10.18),
(2021, '2021-01-01', 1100.00, 'Lei 14.158/2021', 5.26),
(2020, '2020-02-01', 1045.00, 'Lei 14.013/2020', 0.58),
(2020, '2020-01-01', 1039.00, 'MP 916/2019', 4.11),
(2019, '2019-01-01', 998.00, 'Decreto 9.661/2019', 4.61),
(2018, '2018-01-01', 954.00, 'Decreto 9.255/2017', 1.81),
(2017, '2017-01-01', 937.00, 'Decreto 8.948/2016', 6.48),
(2016, '2016-01-01', 880.00, 'Decreto 8.618/2015', 11.68),
(2015, '2015-01-01', 788.00, 'Decreto 8.381/2014', 8.84)
ON CONFLICT DO NOTHING;

CREATE TABLE tarifa_preco_stco (
    ano INT,
    valor DECIMAL(10, 2),
    data_alteracao DATE
);

INSERT INTO tarifa_preco_stco (ano, valor, data_alteracao) VALUES
(2015, 3.00, '2015-02-01'),
(2016, 3.00, '2015-02-01'),
(2017, 3.60, '2017-02-01'),
(2018, 3.60, '2017-02-01'),
(2019, 4.00, '2019-02-04'),
(2020, 4.00, '2019-02-04'),
(2021, 4.40, '2021-04-26'),
(2022, 4.40, '2021-04-26'),
(2023, 5.20, '2023-11-13'),
(2024, 5.20, '2023-11-13')
ON CONFLICT DO NOTHING;

CREATE TABLE dados_stco (
    id SERIAL PRIMARY KEY,
    ano INT,
    passageiros_total BIGINT,
    passageiros_equivalente BIGINT,
    quilometragem_total DECIMAL(15, 2),
    frota_operante INT,
    viagens DECIMAL(10, 1),
    desempenho_operacional DECIMAL(5, 2),
    passageiros_por_viagem DECIMAL(10, 2),
    passageiros_por_veiculo DECIMAL(10, 2),
    kms_por_viagem DECIMAL(10, 2)
);

INSERT INTO dados_stco (ano, passageiros_total, passageiros_equivalente, quilometragem_total, frota_operante, viagens, desempenho_operacional, passageiros_por_viagem, passageiros_por_veiculo, kms_por_viagem) VALUES
(2017, 403818811, 263026450, 168874361.17, 2110, 4234784.5, 87.08, 95.36, 15948.61, 39.88),
(2018, 432678744, 254778903, 160386559.81, 2068, 4234894.5, 85.50, 100.17, 17435.47, 37.87),
(2019, 420590723, 241396429, 155718163.55, 2093, 4145199.0, 85.71, 101.46, 17240.15, 37.57),
(2020, 238638367, 140077214, 108647284.32, 1853, 3198645.5, NULL, 74.61, 10731.94, 33.97),
(2021, 257512403, 148905018, 114708574.88, 1657, 3378552.0, 97.90, 76.22, 12950.73, 33.95),
(2022, 321124599, 179883898, 114966206.58, 1644, 3547772.5, 98.40, 90.52, 16277.61, 32.41),
(2023, 333356137, 177992973, 112475140.14, 1684, 3668109.0, 98.30, 90.93, 17001.03, 30.68),
(2024, 331970762, 172822359, 108539331.22, 1629, 3713886.5, 97.70, 89.39, 16982.34, 29.23)
ON CONFLICT DO NOTHING;

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