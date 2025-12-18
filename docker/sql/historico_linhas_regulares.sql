CREATE TABLE IF NOT EXISTS historico_linhas_regulares(
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    mes INTEGER,
    qtd_linhas FLOAT
);

INSERT INTO historico_linhas_regulares (ano, mes, qtd_linhas) VALUES
-- página 14 anuário 2024
-- NÃO INCLUI LINHAS BRT
-- não aparece destacado por mês
-- levado dezembro em consideração
(2024, 12, 233),
-- página 16 anuário 2023
-- NÃO INCLUI LINHAS BRT
-- não aparece destacado por mês
-- levado dezembro em consideração
(2023, 12, 212),
-- página 14 anuário 2022
-- NÃO INCLUI LINHAS BRT
-- não aparece destacado por mês
-- levado dezembro em consideração
(2022, 12, 253),
-- página 12 anuário 2021
-- não aparece destacado por mês
-- levado dezembro em consideração
(2021, 12, 234),
-- página 11 anuário 2020
-- apenas aparece mês de janeiro
(2020, 1, 315),
-- página 12 anuário 2019
-- último anuário que teve qtd de linhas mês a mês
(2019, 1, 327),
(2019, 2, 315),
(2019, 3, 327),
(2019, 4, 326),
(2019, 5, 326),
(2019, 6, 326),
(2019, 7, 326),
(2019, 8, 315),
(2019, 9, 315),
(2019, 10, 315),
(2019, 11, 314),
(2019, 12, 321),
-- página 13 anuário 2018
-- anuário possui qtd de linhas mês a mês
(2018, 1, 357),
(2018, 2, 336),
(2018, 3, 335),
(2018, 4, 332),
(2018, 5, 331),
(2018, 6, 331),
(2018, 7, 331),
(2018, 8, 330),
(2018, 9, 330),
(2018, 10, 310),
(2018, 11, 331),
(2018, 12, 328),
-- faltando anuário 2017

-- página 5 anuário 2016
(2016, 1, 431),
(2016, 2, 430),
(2016, 3, 430),
(2016, 4, 431),
(2016, 5, 435),
(2016, 6, 435),
(2016, 7, 435),
(2016, 8, 435),
(2016, 9, 435),
(2016, 19, 427),
(2016, 11, 421),
(2016, 12, 427);