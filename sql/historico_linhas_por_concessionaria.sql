CREATE TABLE IF NOT EXISTS historico_linhas_por_concessionaria(
    id SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    ano INTEGER,
    mes INTEGER,
    qtd_linhas INTEGER
);

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 14 anuário 2024
-- INCLUI LINHAS BRT
-- não aparece destacado por mês
-- levado dezembro em consideração
('SPE2', 2024, 12, 137), -- OT TRANS SPE2
('SPE3', 2024, 12, 96), -- PLATAFORMA SPE3
('BRT1', 2024, 12, 4); -- BRT

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 16 anuário 2023
-- INCLUI LINHAS BRT
-- não aparece destacado por mês
-- levado dezembro em consideração
('SPE2', 2023, 12, 121), -- OT TRANS SPE2
('SPE3', 2023, 12, 91), -- PLATAFORMA SPE3
('BRT1', 2023, 12, 3); -- BRT

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 14 anuário 2022
-- INCLUI LINHAS BRT
-- não aparece destacado por mês
-- levado dezembro em consideração
('SPE2', 2022, 12, 144), -- OT TRANS SPE2
('SPE3', 2022, 12, 109), -- PLATAFORMA SPE3
('BRT1', 2022, 12, 1); -- BRT operação assistida em Setembro 22

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 12 anuário 2021
-- não aparece destacado por mês
-- levado dezembro em consideração
('SPE2', 2021, 12, 130), -- OT TRANS SPE2
('SPE3', 2021, 12, 104); -- PLATAFORMA SPE3

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 11 anuário 2020
-- apenas aparece mês de janeiro
('SPE1', 2020, 1, 110), -- SALVADOR NORTE CSN SPE1
('SPE2', 2020, 1, 103), -- OT TRANS SPE2
('SPE3', 2020, 1, 102); -- PLATAFORMA SPE3

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 12 anuário 2019
-- último anuário que teve qtd de linhas mês a mês

-- SALVADOR NORTE CSN SPE1
('SPE1', 2019, 1, 115),
('SPE1', 2019, 2, 110),
('SPE1', 2019, 3, 116),
('SPE1', 2019, 4, 115),
('SPE1', 2019, 5, 115),
('SPE1', 2019, 6, 115),
('SPE1', 2019, 7, 115),
('SPE1', 2019, 8, 110),
('SPE1', 2019, 9, 110),
('SPE1', 2019, 10, 110),
('SPE1', 2019, 11, 110),
('SPE1', 2019, 12, 113),

-- OT TRANS SPE2
('SPE2', 2019, 1, 108),
('SPE2', 2019, 2, 103),
('SPE2', 2019, 3, 110),
('SPE2', 2019, 4, 110),
('SPE2', 2019, 5, 110),
('SPE2', 2019, 6, 110),
('SPE2', 2019, 7, 110),
('SPE2', 2019, 8, 106),
('SPE2', 2019, 9, 106),
('SPE2', 2019, 10, 106),
('SPE2', 2019, 11, 104),
('SPE2', 2019, 12, 106),

-- PLATAFORMA SPE3
('SPE3', 2019, 1, 104),
('SPE3', 2019, 2, 102),
('SPE3', 2019, 3, 101),
('SPE3', 2019, 4, 101),
('SPE3', 2019, 5, 101),
('SPE3', 2019, 6, 101),
('SPE3', 2019, 7, 101),
('SPE3', 2019, 8, 99),
('SPE3', 2019, 9, 99),
('SPE3', 2019, 10, 99),
('SPE3', 2019, 11, 100),
('SPE3', 2019, 12, 102);

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 13 anuário 2018
-- anuário possui qtd de linhas mês a mês

-- SALVADOR NORTE CSN SPE1
('SPE1', 2018, 1, 127),
('SPE1', 2018, 2, 117),
('SPE1', 2018, 3, 117),
('SPE1', 2018, 4, 115),
('SPE1', 2018, 5, 115),
('SPE1', 2018, 6, 115),
('SPE1', 2018, 7, 117),
('SPE1', 2018, 8, 117),
('SPE1', 2018, 9, 117),
('SPE1', 2018, 10, 108),
('SPE1', 2018, 11, 118),
('SPE1', 2018, 12, 115),

-- OT TRANS SPE2
('SPE2', 2018, 1, 117),
('SPE2', 2018, 2, 108),
('SPE2', 2018, 3, 107),
('SPE2', 2018, 4, 106),
('SPE2', 2018, 5, 106),
('SPE2', 2018, 6, 106),
('SPE2', 2018, 7, 106),
('SPE2', 2018, 8, 106),
('SPE2', 2018, 9, 106),
('SPE2', 2018, 10, 101),
('SPE2', 2018, 11, 105),
('SPE2', 2018, 12, 108),

-- PLATAFORMA SPE3
('SPE3', 2018, 1, 113),
('SPE3', 2018, 2, 111),
('SPE3', 2018, 3, 111),
('SPE3', 2018, 4, 111),
('SPE3', 2018, 5, 110),
('SPE3', 2018, 6, 110),
('SPE3', 2018, 7, 108),
('SPE3', 2018, 8, 107),
('SPE3', 2018, 9, 107),
('SPE3', 2018, 10, 101),
('SPE3', 2018, 11, 108),
('SPE3', 2018, 12, 105);

-- 2017 em falta ainda

INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- página 5 anuário 2016

-- SALVADOR NORTE CSN SPE1
('SPE1', 2016, 1, 146),
('SPE1', 2016, 2, 146),
('SPE1', 2016, 3, 146),
('SPE1', 2016, 4, 147),
('SPE1', 2016, 5, 147),
('SPE1', 2016, 6, 147),
('SPE1', 2016, 7, 147),
('SPE1', 2016, 8, 147),
('SPE1', 2016, 9, 147),
('SPE1', 2016, 10, 147),
('SPE1', 2016, 11, 144),
('SPE1', 2016, 12, 145),

-- OT TRANS SPE2
('SPE2', 2016, 1, 153),
('SPE2', 2016, 2, 153),
('SPE2', 2016, 3, 152),
('SPE2', 2016, 4, 152),
('SPE2', 2016, 5, 154),
('SPE2', 2016, 6, 154),
('SPE2', 2016, 7, 154),
('SPE2', 2016, 8, 154),
('SPE2', 2016, 9, 154),
('SPE2', 2016, 10, 149),
('SPE2', 2016, 11, 147),
('SPE2', 2016, 12, 150),

-- PLATAFORMA SPE3
('SPE3', 2016, 1, 134),
('SPE3', 2016, 2, 132),
('SPE3', 2016, 3, 132),
('SPE3', 2016, 4, 132),
('SPE3', 2016, 5, 134),
('SPE3', 2016, 6, 134),
('SPE3', 2016, 7, 134),
('SPE3', 2016, 8, 134),
('SPE3', 2016, 9, 134),
('SPE3', 2016, 10, 133),
('SPE3', 2016, 11, 133),
('SPE3', 2016, 12, 135);

-- INSERT INTO historico_linhas_por_concessionaria(id_concessionaria, ano, mes, qtd_linhas) VALUES
-- -- LINHAS EM POOL (COMPARTILHADAS) PARA O ANO DE 2016
-- ('POOL', 2016, 1, 2),
-- ('POOL', 2016, 2, 1),
-- ('POOL', 2016, 10, 2),
-- ('POOL', 2016, 11, 3),
-- ('POOL', 2016, 12, 3);