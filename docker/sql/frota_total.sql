CREATE TABLE IF NOT EXISTS frota_total(
    id_frota_total_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_total_de_onibus INTEGER
);

INSERT INTO frota_total(id_concessionaria, mes, ano, qtd_total_de_onibus) VALUES
-- FROTA TOTAL DE 2021
-- VER PÁGINA 21 DO ANUÁRIO DE 2021
-- Infelizmente os dados não estão discriminados por concessionária para Frota Total em 2021
('STCO', 1, 2021, 2244),
('STCO', 2, 2021, 2231),
('STCO', 3, 2021, 2178),
('STCO', 4, 2021, 2280),
('STCO', 5, 2021, 2277),
('STCO', 6, 2021, 2267),
('STCO', 7, 2021, 2268),
('STCO', 8, 2021, 2266),
('STCO', 9, 2021, 2169),
('STCO', 10, 2021, 2032),
('STCO', 11, 2021, 2101),
('STCO', 12, 2021, 1776)
ON CONFLICT DO NOTHING;

INSERT INTO frota_total(id_concessionaria, mes, ano, qtd_total_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2022, 1041),
('SPE2', 2, 2022, 1041),
('SPE2', 3, 2022, 1056),
('SPE2', 4, 2022, 1063),
('SPE2', 5, 2022, 1061),
('SPE2', 6, 2022, 1061),
('SPE2', 7, 2022, 1060),
('SPE2', 8, 2022, 1060),
('SPE2', 9, 2022, 1034),
('SPE2', 10, 2022, 1044),
('SPE2', 11, 2022, 1044),
('SPE2', 12, 2022, 1044),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2022, 772),
('SPE3', 2, 2022, 770),
('SPE3', 3, 2022, 790),
('SPE3', 4, 2022, 807),
('SPE3', 5, 2022, 807),
('SPE3', 6, 2022, 807),
('SPE3', 7, 2022, 806),
('SPE3', 8, 2022, 812),
('SPE3', 9, 2022, 769),
('SPE3', 10, 2022, 771),
('SPE3', 11, 2022, 745),
('SPE3', 12, 2022, 745)
ON CONFLICT DO NOTHING;

INSERT INTO frota_total(id_concessionaria, mes, ano, qtd_total_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2023, 1033),
('SPE2', 2, 2023, 1005),
('SPE2', 3, 2023, 1085),
('SPE2', 4, 2023, 1119),
('SPE2', 5, 2023, 1083),
('SPE2', 6, 2023, 1083),
('SPE2', 7, 2023, 1083),
('SPE2', 8, 2023, 1082),
('SPE2', 9, 2023, 1100),
('SPE2', 10, 2023, 1101),
('SPE2', 11, 2023, 1102),
('SPE2', 12, 2023, 1099),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2023, 773),
('SPE3', 2, 2023, 775),
('SPE3', 3, 2023, 775),
('SPE3', 4, 2023, 795),
('SPE3', 5, 2023, 841),
('SPE3', 6, 2023, 840),
('SPE3', 7, 2023, 840),
('SPE3', 8, 2023, 854),
('SPE3', 9, 2023, 858),
('SPE3', 10, 2023, 858),
('SPE3', 11, 2023, 858),
('SPE3', 12, 2023, 859)
ON CONFLICT DO NOTHING;

INSERT INTO frota_total(id_concessionaria, mes, ano, qtd_total_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2024, 1098),
('SPE2', 2, 2024, 1098),
('SPE2', 3, 2024, 1078),
('SPE2', 4, 2024, 1138),
('SPE2', 5, 2024, 1136),
('SPE2', 6, 2024, 1136),
('SPE2', 7, 2024, 1083),
('SPE2', 8, 2024, 1083),
('SPE2', 9, 2024, 1090),
('SPE2', 10, 2024, 1080),
('SPE2', 11, 2024, 1076),
('SPE2', 12, 2024, 1076),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2024, 857),
('SPE3', 2, 2024, 857),
('SPE3', 3, 2024, 858),
('SPE3', 4, 2024, 861),
('SPE3', 5, 2024, 857),
('SPE3', 6, 2024, 847),
('SPE3', 7, 2024, 847),
('SPE3', 8, 2024, 833),
('SPE3', 9, 2024, 837),
('SPE3', 10, 2024, 836),
('SPE3', 11, 2024, 842),
('SPE3', 12, 2024, 845)
ON CONFLICT DO NOTHING;