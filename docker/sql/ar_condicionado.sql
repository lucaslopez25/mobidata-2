CREATE TABLE IF NOT EXISTS ar_condicionado_stco(
    id SERIAL PRIMARY KEY,
    ano INTEGER NOT NULL,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    qtd_frota_total INTEGER, 
    qtd_frota_com_ar_condicionado INTEGER,
    pct_frota_com_ar_condicionado DECIMAL(5, 2)
);

INSERT INTO ar_condicionado_stco(ano, id_concessionaria, qtd_frota_total, qtd_frota_com_ar_condicionado, pct_frota_com_ar_condicionado) VALUES
-- COMPARAÇÃO USANDO VALORES DA FROTA TOTAL dez/24 (PG 27 ANUARIO 2024) VS. FROTA COM AR (PG 46 ANUARIO 2024)
-- TOTAL STCO 2024
-- Veículos c/ ar total stco: 356 ott + 225 plat = 581
(2024, 'STCO', 1921, 581, 30.24),
-- TOTAL PLATAFORMA 2024
(2024, 'SPE3', 845, 225, 26.63),
-- TOTAL OT TRANS 2024
(2024, 'SPE2', 1076, 356, 33.08),
-- TOTAL BRT 2024
(2024, 'BRT1', 52, 52, 100.00)
ON CONFLICT DO NOTHING;

INSERT INTO ar_condicionado_stco(ano, id_concessionaria, qtd_frota_total, qtd_frota_com_ar_condicionado, pct_frota_com_ar_condicionado) VALUES
-- COMPARAÇÃO USANDO VALORES DA FROTA TOTAL dez/23 (PG 28 ANUARIO 2023) VS. FROTA COM AR (PG 47 ANUARIO 2023)
-- TOTAL STCO 2023
-- Veículos c/ ar total stco: 282 ott + 226 plat = 508
(2023, 'STCO', 1958, 508, 25.94),
-- TOTAL PLATAFORMA 2023
(2023, 'SPE3', 859, 226, 26.30),
-- TOTAL OT TRANS 2023
(2023, 'SPE2', 1099, 282, 25.66),
-- TOTAL BRT 2023
(2023, 'BRT1', 44, 44, 100.00)
ON CONFLICT DO NOTHING;

INSERT INTO ar_condicionado_stco(ano, id_concessionaria, qtd_frota_total, qtd_frota_com_ar_condicionado, pct_frota_com_ar_condicionado) VALUES
-- COMPARAÇÃO USANDO VALORES DA FROTA TOTAL dez/22 (PG 25 ANUARIO 2022) VS. FROTA COM AR (PG 36 ANUARIO 2022)
-- TOTAL STCO 2022
-- Veículos c/ ar total stco: 194 ott + 154 plat = 348
(2022, 'STCO', 1789, 348),
-- TOTAL PLATAFORMA 2022
(2022, 'SPE3', 745, 154),
-- TOTAL OT TRANS 2022
(2022, 'SPE2', 1044, 194),
-- TOTAL BRT 2022
(2022, 'BRT1', 35, 35, 100.00)
ON CONFLICT DO NOTHING;