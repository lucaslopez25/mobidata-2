CREATE TABLE IF NOT EXISTS indicadores_financeiros_stco (
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

TRUNCATE TABLE indicadores_financeiros_stco RESTART IDENTITY CASCADE;

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
('SPE2', 'Margem EBITDA', 2023, 1831, '%', 'ASSAL', '18.31%'),

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
('SPE3', 'Margem EBITDA', 2023, 1150, '%', 'ASSAL', '11.50%'),

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