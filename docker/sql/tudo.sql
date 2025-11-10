CREATE TABLE IF NOT EXISTS concessionarias(
    id_concessionaria VARCHAR(10) PRIMARY KEY,
    nome_concessionaria VARCHAR(60),
    endereco_garagens VARCHAR(255),
    cep VARCHAR(10),
    telefone VARCHAR(30)
);

INSERT INTO concessionarias(id_concessionaria, nome_concessionaria, endereco_garagens, cep, telefone) VALUES
-- FONTE para DADOS da SPE1 - INTEGRA SALVADOR NORTE: Página 10, Anuário 2020
('SPE1', 'INTEGRA SALVADOR NORTE', 'AV. SANTIAGO DE COMPOSTELA, 370 - Parque Bela Vista', '40.279-150', '71 3111 3134'),
-- FONTE para OUTROS DADOS - Veja anuário mais recente
('SPE2', 'OT TRANS', 'ESTRADA VELHA DE CAMPINAS, 1.175 - Pirajá', '41.280-520', '71 3525 8433'),
('SPE3', 'PLATAFORMA', 'RUA TOMAZ GONZAGA, 262 - Pernambués', '41.100-000', '71 2203 4131'),
('BRT1', 'BRT (CCO)', 'Av. Barros Reis, 1.427 - Retiro ', '41.185-300', '71 4020 1550'),
('STEC', 'STEC', 'n/a', 'n/a', 'n/a'),
('STCO', 'TOTAL - SISTEMA DE TRANSPORTE COLETIVO POR ÔNIBUS', 'n/a', 'n/a', 'n/a'),
('TOTL', 'TOTAL - STCO, BRT E STEC', 'n/a', 'n/a', 'n/a')
ON CONFLICT (id_concessionaria)
DO UPDATE SET
    nome_concessionaria = EXCLUDED.nome_concessionaria,
    endereco_garagens = EXCLUDED.endereco_garagens,
    cep = EXCLUDED.cep,
    telefone = EXCLUDED.telefone;

CREATE TABLE IF NOT EXISTS tipo_de_veiculo(
    id_tipo_veiculo SERIAL PRIMARY KEY,
    nome_tipo VARCHAR(60),
    vida_util_em_anos INTEGER
);

INSERT INTO tipo_de_veiculo(nome_tipo, vida_util_em_anos) VALUES
('micro-ônibus', 5),
('midi-ônibus', 7),
('mini-ônibus', 7),
('ônibus padron', 10),
('ônibus básico', 7),
('ônibus convencional alongado', 7),
('ônibus articulado', NULL),
('ônibus biarticulado', NULL),
('ônibus super articulado', NULL)
ON CONFLICT DO NOTHING;


CREATE TABLE IF NOT EXISTS idade_media_da_frota(
    id_idade_media_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    idade_media FLOAT
);

INSERT INTO idade_media_da_frota(id_concessionaria, mes, ano, idade_media) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2022, 7.30),
('SPE2', 2, 2022, 7.38),
('SPE2', 3, 2022, 7.34),
('SPE2', 4, 2022, 7.38),
('SPE2', 5, 2022, 7.47),
('SPE2', 6, 2022, 7.55),
('SPE2', 7, 2022, 7.63),
('SPE2', 8, 2022, 7.71),
('SPE2', 9, 2022, 7.67),
('SPE2', 10, 2022, 7.69),
('SPE2', 11, 2022, 7.77),
('SPE2', 12, 2022, 7.86),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2022, 7.39),
('SPE3', 2, 2022, 7.46),
('SPE3', 3, 2022, 7.36),
('SPE3', 4, 2022, 7.29),
('SPE3', 5, 2022, 7.36),
('SPE3', 6, 2022, 7.44),
('SPE3', 7, 2022, 7.52),
('SPE3', 8, 2022, 7.60),
('SPE3', 9, 2022, 7.47),
('SPE3', 10, 2022, 7.56),
('SPE3', 11, 2022, 7.60),
('SPE3', 12, 2022, 7.69)
ON CONFLICT DO NOTHING;CREATE TABLE IF NOT EXISTS aquisicoes_de_onibus_por_mes(
    id_aquisicao_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_onibus INTEGER,
    novo_ou_usado BOOLEAN
);

INSERT INTO aquisicoes_de_onibus_por_mes(id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
('SPE2', 4, 2024, 60, TRUE),
('SPE2', 7, 2024, 1, TRUE),
('SPE2', 8, 2024, 6, TRUE),
('SPE2', 9, 2024, 1, TRUE),
('SPE2', 10, 2024, 13, TRUE),
('SPE3', 4, 2024, 3, TRUE),
('SPE3', 8, 2024, 6, FALSE),
('SPE3', 11, 2024, 5, FALSE)
ON CONFLICT DO NOTHING;

INSERT INTO aquisicoes_de_onibus_por_mes(id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
('SPE2', 2, 2023, 39, TRUE),
('SPE2', 3, 2023, 41, TRUE),
('SPE2', 4, 2023, 9, TRUE),
('SPE2', 10, 2023, 1, TRUE),
('SPE2', 11, 2023, 1, TRUE),
('SPE3', 1, 2023, 9, TRUE),
('SPE3', 4, 2023, 15, TRUE),
('SPE3', 5, 2023, 30, TRUE),
('SPE3', 7, 2023, 20, TRUE),
('SPE3', 9, 2023, 5, TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO aquisicoes_de_onibus_por_mes(id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2022, 25, TRUE),
('SPE2', 1, 2022, 0, FALSE),
('SPE2', 2, 2022, 0, TRUE),
('SPE2', 2, 2022, 0, FALSE),
('SPE2', 3, 2022, 20, TRUE),
('SPE2', 3, 2022, 0, FALSE),
('SPE2', 4, 2022, 7, TRUE),
('SPE2', 4, 2022, 0, FALSE),
('SPE2', 5, 2022, 0, TRUE),
('SPE2', 5, 2022, 0, FALSE),
('SPE2', 6, 2022, 0, TRUE),
('SPE2', 6, 2022, 0, FALSE),
('SPE2', 7, 2022, 0, TRUE),
('SPE2', 7, 2022, 0, FALSE),
('SPE2', 8, 2022, 0, TRUE),
('SPE2', 8, 2022, 0, FALSE),
('SPE2', 9, 2022, 0, TRUE),
('SPE2', 9, 2022, 0, FALSE),
('SPE2', 10, 2022, 9, TRUE),
('SPE2', 10, 2022, 0, FALSE),
('SPE2', 11, 2022, 0, TRUE),
('SPE2', 11, 2022, 0, FALSE),
('SPE2', 12, 2022, 0, TRUE),
('SPE2', 12, 2022, 0, FALSE),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2022, 10, TRUE),
('SPE3', 1, 2022, 0, FALSE),
('SPE3', 2, 2022, 0, TRUE),
('SPE3', 2, 2022, 0, FALSE),
('SPE3', 3, 2022, 20, TRUE),
('SPE3', 3, 2022, 0, FALSE),
('SPE3', 4, 2022, 17, TRUE),
('SPE3', 4, 2022, 0, FALSE),
('SPE3', 5, 2022, 0, TRUE),
('SPE3', 5, 2022, 1, FALSE),
('SPE3', 6, 2022, 0, TRUE),
('SPE3', 6, 2022, 0, FALSE),
('SPE3', 7, 2022, 0, TRUE),
('SPE3', 7, 2022, 0, FALSE),
('SPE3', 8, 2022, 0, TRUE),
('SPE3', 8, 2022, 6, FALSE),
('SPE3', 9, 2022, 0, TRUE),
('SPE3', 9, 2022, 2, FALSE),
('SPE3', 10, 2022, 9, TRUE),
('SPE3', 10, 2022, 1, FALSE),
('SPE3', 11, 2022, 0, TRUE),
('SPE3', 11, 2022, 0, FALSE),
('SPE3', 12, 2022, 0, TRUE),
('SPE3', 12, 2022, 0, FALSE)
ON CONFLICT DO NOTHING;CREATE TABLE IF NOT EXISTS ar_condicionado_stco(
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
(2024, 'BRT', 52, 52, 100.00)
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
(2023, 'BRT', 44, 44, 100.00)
ON CONFLICT DO NOTHING;

INSERT INTO ar_condicionado_stco(ano, id_concessionaria, qtd_frota_total, qtd_frota_com_ar_condicionado, pct_frota_com_ar_condicionado) VALUES
-- COMPARAÇÃO USANDO VALORES DA FROTA TOTAL dez/22 (PG 25 ANUARIO 2022) VS. FROTA COM AR (PG 36 ANUARIO 2022)
-- TOTAL STCO 2022
-- Veículos c/ ar total stco: 194 ott + 154 plat = 348

TOTAL 1789
OTT 1044
PLAT 745CREATE TABLE IF NOT EXISTS corredores_de_onibus(
    id_corredor SERIAL PRIMARY KEY,
    nome_corredor VARCHAR(255),
    qtd_onibus_por_hora INTEGER,
    extensao_em_kms FLOAT,
    qtd_linhas_convencionais INTEGER,
    ano INTEGER
);

INSERT INTO corredores_de_onibus(nome_corredor, qtd_onibus_por_hora, extensao_em_kms, qtd_linhas_convencionais, ano) VALUES
('BR - 324', 51, 21.39, 12, 2024),
('AV. ALIOMAR BALEEIRO', 44, 19.04, 12, 2024),
('AV. AFRÂNIO PEIXOTO', 79, 14.50, 28, 2024),
('AV. LUIS VIANA FILHO (PARALELA)', 76, 13.37, 17, 2024),
('AV. OCTÁVIO MANGABEIRA', 58, 13.18, 10, 2024),
('AV. ANTONIO CARLOS MAGALHÃES', 94, 6.80, 23, 2024),
('EST. CAMPINAS / S. CAETANO', 36, 5.67, 11, 2024),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 62, 4.99, 15, 2024),
('AV. S. MARCOS/ AV. S. RAFAEL', 54, 4.59, 13, 2024),
('AV. MÁRIO LEAL FERREIRA (BONOCÔ)', 70, 4.51, 15, 2024),
('R. SILVEIRA MARTINS', 62, 4.50, 16, 2024),
('AV. TANCREDO NEVES', 121, 3.86, 28, 2024),
('AV. VASCO DA GAMA', 61, 3.60, 13, 2024),
('AV. BARROS REIS', 91, 2.00, 21, 2024),
('AV. HEITOR DIAS', 54, 2.00, 14, 2024),
('AV. DA FRANÇA', 103, 3.23, 34, 2024),
('AV. CENTENÁRIO', 66, 2.82, 12, 2024),
('AV. D. JOÃO VI', 21, 2.78, 8, 2024),
('R. LIMA E SILVA', 32, 2.60, 8, 2024),
('AV. CARDEAL DA SILVA', 25, 2.17, 4, 2024),
('AV. SETE DE SETEMBRO', 54, 2.10, 9, 2024),
('AV. JOANA ANGÉLICA', 16, 1.38, 4, 2024),
('RUA CARLOS GOMES', 52, 1.11, 16, 2024),

('BR - 324', 52, 21.39, 13, 2023),
('AV. ALIOMAR BALEEIRO', 44, 19.04, 15, 2023),
('AV. AFRÂNIO PEIXOTO', 60, 14.50, 23, 2023),
('AV. LUIS VIANA FILHO (PARALELA)', 93, 13.37, 18, 2023),
('AV. OCTÁVIO MANGABEIRA', 41, 13.18, 12, 2023),
('AV. ANTONIO CARLOS MAGALHÃES', 106, 6.80, 24, 2023),
('EST. CAMPINAS / S. CAETANO', 39, 5.67, 11, 2023),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 63, 4.99, 13, 2023),
('AV. S. MARCOS/ AV. S. RAFAEL', 63, 4.59, 14, 2023),
('AV. MÁRIO LEAL FERREIRA (BONOCÔ)', 73, 4.51, 16, 2023),
('R. SILVEIRA MARTINS', 63, 4.50, 17, 2023),
('AV. TANCREDO NEVES', 125, 3.86, 27, 2023),
('AV. VASCO DA GAMA', 65, 3.60, 13, 2023),
('AV. BARROS REIS', 97, 2.00, 22, 2023),
('AV. HEITOR DIAS', 63, 2.00, 14, 2023),
('AV. DA FRANÇA', 104, 3.23, 34, 2023),
('AV. CENTENÁRIO', 68, 2.82, 11, 2023),
('AV. D. JOÃO VI', 17, 2.78, 8, 2023),
('R. LIMA E SILVA', 32, 2.60, 8, 2023),
('AV. CARDEAL DA SILVA', 17, 2.17, 4, 2023),
('AV. SETE DE SETEMBRO', 44, 2.10, 9, 2023),
('AV. JOANA ANGÉLICA', 16, 1.38, 4, 2023),
('RUA CARLOS GOMES', 48, 1.11, 15, 2023),

('BR - 324', 58, 21.39, 16, 2022),
('AV. ALIOMAR BALEEIRO', 44, 19.04, 15, 2022),
('AV. AFRÂNIO PEIXOTO', 114, 14.50, 35, 2022),
('AV. LUIS VIANA FILHO (PARALELA)', 117, 13.37, 26, 2022),
('AV. OCTÁVIO MANGABEIRA', 51, 13.18, 14, 2022),
('AV. ANTONIO CARLOS MAGALHÃES', 165, 6.80, 39, 2022),
('EST. CAMPINAS / S. CAETANO', 60, 5.67, 14, 2022),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 88, 4.99, 22, 2022),
('AV. S. MARCOS/ AV. S. RAFAEL', 61, 4.59, 15, 2022),
('AV. MÁRIO LEAL FERREIRA (BONOCÔ)', 77, 4.51, 21, 2022),
('R. SILVEIRA MARTINS', 61, 4.50, 17, 2022),
('AV. TANCREDO NEVES', 157, 3.86, 36, 2022),
('AV. VASCO DA GAMA', 68, 3.60, 16, 2022),
('AV. DA FRANÇA', 142, 3.23, 43, 2022),
('AV. CENTENÁRIO', 63, 2.82, 12, 2022),
('AV. D. JOÃO VI', 26, 2.78, 9, 2022),
('R. LIMA E SILVA', 48, 2.60, 8, 2022),
('AV. CARDEAL DA SILVA', 26, 2.17, 4, 2022),
('AV. SETE DE SETEMBRO', 47, 2.10, 9, 2022),
('AV. JOANA ANGÉLICA', 23, 1.38, 4, 2022),
('RUA CARLOS GOMES', 69, 1.11, 18, 2022),
('AV. BARROS REIS', 113, 2.00, 30, 2022),
('AV. HEITOR DIAS', 77, 2.00, 18, 2022),

('BR - 324', 62, 21.39, 16, 2021),
('AV. ALIOMAR BALEEIRO', 47, 19.04, 14, 2021),
('AV. AFRÂNIO PEIXOTO', 99, 14.50, 34, 2021),
('AV. LUIS VIANA FILHO (PARALELA)', 110, 13.37, 25, 2021),
('AV. OCTÁVIO MANGABEIRA', 52, 13.18, 14, 2021),
('AV. ANTONIO CARLOS MAGALHÃES', 160, 6.80, 34, 2021),
('EST. CAMPINAS / S. CAETANO', 46, 5.67, 15, 2021),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 96, 4.99, 23, 2021),
('AV. S. MARCOS/ AV. S. RAFAEL', 60, 4.59, 15, 2021),
('AV. MÁRIO LEAL FERREIRA (BONOCÔ)', 87, 4.51, 21, 2021),
('R. SILVEIRA MARTINS', 70, 4.50, 17, 2021),
('AV. TANCREDO NEVES', 165, 3.86, 35, 2021),
('AV. VASCO DA GAMA', 58, 3.60, 16, 2021),
('AV. BARROS REIS', 121, 2.00, 34, 2021),
('AV. HEITOR DIAS', 70, 2.00, 17, 2021),
('AV. DA FRANÇA', 132, 3.23, 42, 2021),
('AV. CENTENÁRIO', 70, 2.82, 12, 2021),
('AV. D. JOÃO VI', 27, 2.78, 8, 2021),
('R. LIMA E SILVA', 40, 2.60, 11, 2021),
('AV. CARDEAL DA SILVA', 24, 2.17, 5, 2021),
('AV. SETE DE SETEMBRO', 46, 2.10, 9, 2021),
('AV. JOANA ANGÉLICA', 16, 1.38, 4, 2021),
('RUA CARLOS GOMES', 62, 1.11, 18, 2021),

('BR - 324', 74, 21.39, 17, 2020),
('AV. ALIOMAR BALEEIRO', 60, 19.04, 16, 2020),
('AV. AFRÂNIO PEIXOTO', 120, 14.50, 39, 2020),
('AV. LUIS VIANA FILHO (PARALELA)', 115, 13.37, 24, 2020),
('AV. OCTÁVIO MANGABEIRA', 57, 13.18, 17, 2020),
('AV. ANTONIO CARLOS MAGALHÃES', 188, 6.80, 44, 2020),
('EST. CAMPINAS / S. CAETANO', 57, 5.67, 18, 2020),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 123, 4.99, 32, 2020),
('AV. S. MARCOS/ AV. S. RAFAEL', 69, 4.59, 16, 2020),
('AV. MÁRIO LEAL FERREIRA (BONOCÔ)', 99, 4.51, 24, 2020),
('R. SILVEIRA MARTINS', 82, 4.50, 18, 2020),
('AV. TANCREDO NEVES', 196, 3.86, 42, 2020),
('AV. VASCO DA GAMA', 60, 3.60, 14, 2020),
('AV. BARROS REIS', 130, 2.00, 35, 2020),
('AV. HEITOR DIAS', 93, 2.00, 18, 2020),
('AV. DA FRANÇA', 166, 3.23, 45, 2020),
('AV. CENTENÁRIO', 82, 2.82, 15, 2020),
('AV. D. JOÃO VI', 31, 2.78, 9, 2020),
('R. LIMA E SILVA', 51, 2.60, 15, 2020),
('AV. CARDEAL DA SILVA', 27, 2.17, 8, 2020),
('AV. SETE DE SETEMBRO', 49, 2.10, 12, 2020),
('AV. JOANA ANGÉLICA', 20, 1.38, 4, 2020),
('RUA CARLOS GOMES', 79, 1.11, 23, 2020),

('BR - 324', 73, 21.39, 26, 2019),
('AV. ALIOMAR BALEEIRO', 63, 19.04, 17, 2019),
('AV. AFRÂNIO PEIXOTO', 150, 14.50, 44, 2019),
('AV. LUIS VIANA FILHO (PARALELA)', 133, 13.37, 30, 2019),
('AV. OCTÁVIO MANGABEIRA', 60, 13.18, 18, 2019),
('AV. ANTONIO CARLOS MAGALHÃES', 226, 6.80, 41, 2019),
('EST. CAMPINAS / S. CAETANO', 62, 5.67, 21, 2019),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 160, 4.99, 32, 2019),
('AV. S. MARCOS/ AV. S. RAFAEL', 74, 4.59, 18, 2019),
('AV. MÁRIO LEAL FERREIRA (BONOCÔ)', 121, 4.51, 31, 2019),
('R. SILVEIRA MARTINS', 102, 4.50, 19, 2019),
('AV. TANCREDO NEVES', 223, 3.86, 40, 2019),
('AV. VASCO DA GAMA', 59, 3.60, 13, 2019),
('AV. BARROS REIS', 144, 2.00, 39, 2019),
('AV. HEITOR DIAS', 98, 2.00, 18, 2019),
('AV. DA FRANÇA', 207, 3.23, 54, 2019),
('AV. CENTENÁRIO', 93, 2.82, 15, 2019),
('AV. D. JOÃO VI', 48, 2.78, 11, 2019),
('R. LIMA E SILVA', 58, 2.60, 16, 2019),
('AV. CARDEAL DA SILVA', 32, 2.17, 11, 2019),
('AV. SETE DE SETEMBRO', 49, 2.10, 14, 2019),
('AV. JOANA ANGÉLICA', 33, 1.38, 5, 2019),
('RUA CARLOS GOMES', 98, 1.11, 30, 2019)
ON CONFLICT DO NOTHING;

INSERT INTO corredores_de_onibus(nome_corredor, qtd_onibus_por_hora, extensao_em_kms, qtd_linhas_convencionais, ano) VALUES
('BR - 324', 71, 21.39, 19, 2018),
('AV. ALIOMAR BALEEIRO', 61, 19.04, 17, 2018),
('AV. AFRÂNIO PEIXOTO', 163, 14.50, 48, 2018),
('AV. LUIS VIANA FILHO (PARALELA)', 132, 13.37, 30, 2018),
('AV. OCTÁVIO MANGABEIRA', 64, 13.18, 17, 2018),
('AV. ANTONIO CARLOS MAGALHÃES', 226, 6.80, 41, 2018),
('EST. CAMPINAS / S. CAETANO', 75, 5.67, 22, 2018),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 163, 4.99, 31, 2018),
('AV. S. MARCOS/ AV. S. RAFAEL', 71, 4.59, 18, 2018),
('AV. MÁRIO LEAL FERREIRA (BONOCÔ)', 112, 4.51, 26, 2018),
('R. SILVEIRA MARTINS', 103, 4.50, 18, 2018),
('AV. TANCREDO NEVES', 230, 3.86, 39, 2018),
('AV. VASCO DA GAMA', 86, 3.60, 19, 2018),
('AV. BARROS REIS', 152, 2.00, 36, 2018),
('AV. HEITOR DIAS', 101, 2.00, 18, 2018),
('AV. DA FRANÇA', 208, 3.23, 53, 2018),
('AV. CENTENÁRIO', 86, 2.82, 15, 2018),
('AV. D. JOÃO VI', 41, 2.78, 10, 2018),
('R. LIMA E SILVA', 58, 2.60, 16, 2018),
('AV. CARDEAL DA SILVA', 35, 2.17, 11, 2018),
('AV. SETE DE SETEMBRO', 71, 2.10, 15, 2018),
('AV. JOANA ANGÉLICA', 30, 1.38, 6, 2018),
('RUA CARLOS GOMES', 90, 1.11, 20, 2018);CREATE TABLE IF NOT EXISTS historico_passageiros_transportados (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    mes INTEGER,
    passageiros FLOAT
);

INSERT INTO historico_passageiros_transportados(ano, mes, passageiros) VALUES
(2001, 1, 38.93), 
(2001, 2, 35.68), 
(2001, 3, 42.14), 
(2001, 4, 38.83), 
(2001, 5, 39.91), 
(2001, 6, 37.92), 
(2001, 7, 35.95), 
(2001, 8, 42.86), 
(2001, 9, 38.92), 
(2001, 10, 41.29), 
(2001, 11, 39.35), 
(2001, 12, 40.47),

(2002, 1, 37.32), 
(2002, 2, 35.08), 
(2002, 3, 40.40), 
(2002, 4, 40.80), 
(2002, 5, 38.84), 
(2002, 6, 35.75), 
(2002, 7, 40.44), 
(2002, 8, 43.13), 
(2002, 9, 39.52), 
(2002, 10, 43.65), 
(2002, 11, 40.97), 
(2002, 12, 42.33),

(2003, 1, 37.40), 
(2003, 2, 35.38), 
(2003, 3, 38.23), 
(2003, 4, 37.59), 
(2003, 5, 39.34), 
(2003, 6, 34.54), 
(2003, 7, 38.47), 
(2003, 8, 39.55), 
(2003, 9, 36.72), 
(2003, 10, 40.38), 
(2003, 11, 37.83), 
(2003, 12, 39.22),

(2004, 1, 34.69), 
(2004, 2, 33.91), 
(2004, 3, 40.14), 
(2004, 4, 36.18), 
(2004, 5, 37.39), 
(2004, 6, 33.78), 
(2004, 7, 36.20), 
(2004, 8, 39.02), 
(2004, 9, 38.00), 
(2004, 10, 38.53), 
(2004, 11, 37.95), 
(2004, 12, 40.49),

(2005, 1, 29.39), 
(2005, 2, 26.57), 
(2005, 3, 31.18), 
(2005, 4, 29.33), 
(2005, 5, 30.21), 
(2005, 6, 28.29), 
(2005, 7, 29.55), 
(2005, 8, 31.79), 
(2005, 9, 30.20), 
(2005, 10, 29.76), 
(2005, 11, 28.55), 
(2005, 12, 31.09),

(2006, 1, 37.12), 
(2006, 2, 35.31), 
(2006, 3, 40.62), 
(2006, 4, 35.90), 
(2006, 5, 36.99), 
(2006, 6, 33.19), 
(2006, 7, 38.10), 
(2006, 8, 41.32), 
(2006, 9, 38.42), 
(2006, 10, 39.42), 
(2006, 11, 38.87), 
(2006, 12, 39.98),

(2007, 1, 36.90), 
(2007, 2, 32.35), 
(2007, 3, 40.33), 
(2007, 4, 36.44), 
(2007, 5, 39.08), 
(2007, 6, 35.70), 
(2007, 7, 37.85), 
(2007, 8, 41.14), 
(2007, 9, 38.27), 
(2007, 10, 41.55), 
(2007, 11, 39.85), 
(2007, 12, 40.46),

(2008, 1, 38.63), 
(2008, 2, 36.00), 
(2008, 3, 39.66), 
(2008, 4, 40.30), 
(2008, 5, 39.62), 
(2008, 6, 37.64), 
(2008, 7, 40.83), 
(2008, 8, 42.42), 
(2008, 9, 42.74), 
(2008, 10, 44.23), 
(2008, 11, 41.69), 
(2008, 12, 41.68),

(2009, 1, 37.03), 
(2009, 2, 34.23), 
(2009, 3, 41.58), 
(2009, 4, 37.50), 
(2009, 5, 38.10), 
(2009, 6, 36.35), 
(2009, 7, 39.91), 
(2009, 8, 41.13), 
(2009, 9, 40.18), 
(2009, 10, 41.03), 
(2009, 11, 40.50), 
(2009, 12, 40.39),

(2010, 1, 36.40), 
(2010, 2, 34.52), 
(2010, 3, 42.43), 
(2010, 4, 36.90), 
(2010, 5, 40.19), 
(2010, 6, 35.21), 
(2010, 7, 38.61), 
(2010, 8, 41.13), 
(2010, 9, 39.98), 
(2010, 10, 40.35), 
(2010, 11, 39.68), 
(2010, 12, 40.19),

(2011, 1, 35.93), 
(2011, 2, 36.36), 
(2011, 3, 37.83), 
(2011, 4, 36.99), 
(2011, 5, 39.07),
(2011, 6, 35.57), 
(2011, 7, 37.91), 
(2011, 8, 40.70), 
(2011, 9, 38.80), 
(2011, 10, 38.12), 
(2011, 11, 37.39), 
(2011, 12, 38.46),

(2012, 1, 35.75), 
(2012, 2, 31.10), 
(2012, 3, 39.52), 
(2012, 4, 35.04), 
(2012, 5, 32.30), 
(2012, 6, 33.64), 
(2012, 7, 35.02), 
(2012, 8, 38.08), 
(2012, 9, 34.61), 
(2012, 10, 37.02), 
(2012, 11, 35.03), 
(2012, 12, 34.84),

(2013, 1, 33.62), 
(2013, 2, 29.82), 
(2013, 3, 33.91), 
(2013, 4, 34.50), 
(2013, 5, 34.54), 
(2013, 6, 30.00), 
(2013, 7, 33.71), 
(2013, 8, 35.70), 
(2013, 9, 34.17), 
(2013, 10, 36.17), 
(2013, 11, 34.57), 
(2013, 12, 34.39),

(2014, 1, 33.61), 
(2014, 2, 32.42), 
(2014, 3, 33.81),
(2014, 4, 31.27), 
(2014, 5, 33.07), 
(2014, 6, 29.35), 
(2014, 7, 30.04), 
(2014, 8, 35.07), 
(2014, 9, 37.09), 
(2014, 10, 38.05), 
(2014, 11, 35.88), 
(2014, 12, 34.72),

(2015, 1, 33.00),
(2015, 2, 29.92), 
(2015, 3, 38.14), 
(2015, 4, 31.69), 
(2015, 5, 33.54), 
(2015, 6, 31.29), 
(2015, 7, 35.91), 
(2015, 8, 37.01), 
(2015, 9, 36.98), 
(2015, 10, 37.59), 
(2015, 11, 36.81), 
(2015, 12, 35.42),

(2016, 1, 32.32), 
(2016, 2, 31.85), 
(2016, 3, 37.28), 
(2016, 4, 35.29), 
(2016, 5, 35.94), 
(2016, 6, 33.32), 
(2016, 7, 35.13), 
(2016, 8, 36.66), 
(2016, 9, 34.28), 
(2016, 10, 34.75), 
(2016, 11, 33.26), 
(2016, 12, 33.70),

(2017, 1, 31.49), 
(2017, 2, 29.13), 
(2017, 3, 34.29), 
(2017, 4, 29.30), 
(2017, 5, 33.98), 
(2017, 6, 30.04), 
(2017, 7, 33.92), 
(2017, 8, 36.92), 
(2017, 9, 34.90), 
(2017, 10, 37.31), 
(2017, 11, 36.62), 
(2017, 12, 35.94),

(2018, 1, 35.34), 
(2018, 2, 31.39), 
(2018, 3, 37.66), 
(2018, 4, 36.26), 
(2018, 5, 34.20), 
(2018, 6, 34.52), 
(2018, 7, 36.04), 
(2018, 8, 39.61), 
(2018, 9, 36.78), 
(2018, 10, 38.52), 
(2018, 11, 36.84), 
(2018, 12, 35.51),

(2019, 1, 34.55), 
(2019, 2, 34.66), 
(2019, 3, 34.42), 
(2019, 4, 35.56), 
(2019, 5, 36.98), 
(2019, 6, 29.88), 
(2019, 7, 34.44), 
(2019, 8, 37.14), 
(2019, 9, 35.73), 
(2019, 10, 37.28), 
(2019, 11, 35.19), 
(2019, 12, 34.76),

(2020, 1, 32.79), 
(2020, 2, 30.61), 
(2020, 3, 25.52), 
(2020, 4, 10.56), 
(2020, 5, 10.62), 
(2020, 6, 12.10), 
(2020, 7, 14.77), 
(2020, 8, 17.23), 
(2020, 9, 18.86), 
(2020, 10, 21.17), 
(2020, 11, 21.38), 
(2020, 12, 23.02),

(2021, 1, 21.35), 
(2021, 2, 20.02), 
(2021, 3, 16.93), 
(2021, 4, 17.39), 
(2021, 5, 20.47), 
(2021, 6, 19.48), 
(2021, 7, 21.81), 
(2021, 8, 23.48), 
(2021, 9, 23.42), 
(2021, 10, 23.97), 
(2021, 11, 24.45), 
(2021, 12, 24.74),

(2022, 1, 23.34), 
(2022, 2, 24.02), 
(2022, 3, 28.08),
(2022, 4, 25.61), 
(2022, 5, 28.37), 
(2022, 6, 25.16), 
(2022, 7, 27.18), 
(2022, 8, 29.69), 
(2022, 9, 28.24), 
(2022, 10, 27.66), 
(2022, 11, 27.28), 
(2022, 12, 27.29),

(2023, 1, 26.93), 
(2023, 2, 25.27), 
(2023, 3, 30.39), 
(2023, 4, 26.51), 
(2023, 5, 29.26), 
(2023, 6, 27.54), 
(2023, 7, 28.88), 
(2023, 8, 31.07), 
(2023, 9, 28.63), 
(2023, 10, 29.99), 
(2023, 11, 29.09), 
(2023, 12, 27.57),

(2024, 1, 27.21), 
(2024, 2, 25.57), 
(2024, 3, 29.02), 
(2024, 4, 29.77), 
(2024, 5, 29.42), 
(2024, 6, 26.73), 
(2024, 7, 30.27), 
(2024, 8, 31.50), 
(2024, 9, 29.87), 
(2024, 10, 31.24), 
(2024, 11, 28.74), 
(2024, 12, 28.59)
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS historico_quilometragem_percorrida (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    mes INTEGER,
    quilometragem FLOAT
);

INSERT INTO historico_quilometragem_percorrida(ano, mes, quilometragem) VALUES
(2001, 1, 18.97), 
(2001, 2, 17.08), 
(2001, 3, 18.88), 
(2001, 4, 17.60), 
(2001, 5, 17.68), 
(2001, 6, 17.63), 
(2001, 7, 17.44), 
(2001, 8, 19.03), 
(2001, 9, 17.58), 
(2001, 10, 18.60), 
(2001, 11, 17.51), 
(2001, 12, 18.49),

(2002, 1, 19.17), 
(2002, 2, 17.25), 
(2002, 3, 18.61), 
(2002, 4, 17.31), 
(2002, 5, 17.38), 
(2002, 6, 17.29), 
(2002, 7, 18.06), 
(2002, 8, 18.35), 
(2002, 9, 17.57), 
(2002, 10, 18.55), 
(2002, 11, 17.38), 
(2002, 12, 18.01),

(2003, 1, 18.80), 
(2003, 2, 16.91), 
(2003, 3, 18.27), 
(2003, 4, 17.49), 
(2003, 5, 18.04), 
(2003, 6, 16.83), 
(2003, 7, 18.17), 
(2003, 8, 17.98), 
(2003, 9, 17.18), 
(2003, 10, 18.55),
(2003, 11, 17.28),
(2003, 12, 17.66),

(2004, 1, 18.06), 
(2004, 2, 17.01), 
(2004, 3, 18.50), 
(2004, 4, 17.06), 
(2004, 5, 17.84), 
(2004, 6, 16.94), 
(2004, 7, 18.11), 
(2004, 8, 18.26), 
(2004, 9, 17.63), 
(2004, 10, 17.89), 
(2004, 11, 17.26), 
(2004, 12, 17.84),

(2005, 1, 18.60), 
(2005, 2, 16.73), 
(2005, 3, 18.56), 
(2005, 4, 17.44), 
(2005, 5, 17.72), 
(2005, 6, 17.66), 
(2005, 7, 18.17), 
(2005, 8, 18.70), 
(2005, 9, 17.98), 
(2005, 10, 18.15), 
(2005, 11, 17.46), 
(2005, 12, 18.20),

(2006, 1, 18.84), 
(2006, 2, 16.19), 
(2006, 3, 18.48), 
(2006, 4, 16.19), 
(2006, 5, 16.26), 
(2006, 6, 15.27), 
(2006, 7, 17.74), 
(2006, 8, 18.38), 
(2006, 9, 17.02), 
(2006, 10, 17.72), 
(2006, 11, 16.85), 
(2006, 12, 17.30),

(2007, 1, 18.44), 
(2007, 2, 15.71), 
(2007, 3, 18.09), 
(2007, 4, 16.86), 
(2007, 5, 17.95), 
(2007, 6, 17.44), 
(2007, 7, 18.24), 
(2007, 8, 18.78), 
(2007, 9, 17.26), 
(2007, 10, 18.19), 
(2007, 11, 17.45), 
(2007, 12, 17.85),

(2008, 1, 18.61), 
(2008, 2, 17.02), 
(2008, 3, 18.15), 
(2008, 4, 17.81), 
(2008, 5, 17.77), 
(2008, 6, 17.27), 
(2008, 7, 18.58), 
(2008, 8, 18.34), 
(2008, 9, 18.35), 
(2008, 10, 19.72), 
(2008, 11, 18.28), 
(2008, 12, 18.63),

(2009, 1, 18.98), 
(2009, 2, 16.39), 
(2009, 3, 19.31), 
(2009, 4, 17.72), 
(2009, 5, 17.63), 
(2009, 6, 17.33), 
(2009, 7, 18.76), 
(2009, 8, 18.90), 
(2009, 9, 19.32), 
(2009, 10, 18.74), 
(2009, 11, 17.94), 
(2009, 12, 18.91),

(2010, 1, 18.52), 
(2010, 2, 16.07), 
(2010, 3, 18.60), 
(2010, 4, 16.53), 
(2010, 5, 17.84), 
(2010, 6, 17.04), 
(2010, 7, 17.23), 
(2010, 8, 17.67), 
(2010, 9, 17.15), 
(2010, 10, 17.93), 
(2010, 11, 17.75), 
(2010, 12, 18.52),

(2011, 1, 18.42), 
(2011, 2, 16.54), 
(2011, 3, 17.59), 
(2011, 4, 16.74), 
(2011, 5, 17.34), 
(2011, 6, 16.83), 
(2011, 7, 18.29), 
(2011, 8, 18.47), 
(2011, 9, 17.40), 
(2011, 10, 17.52), 
(2011, 11, 16.53), 
(2011, 12, 17.83),

(2012, 1, 17.07), 
(2012, 2, 14.85), 
(2012, 3, 15.87), 
(2012, 4, 15.10), 
(2012, 5, 13.55), 
(2012, 6, 15.43), 
(2012, 7, 16.77), 
(2012, 8, 17.30), 
(2012, 9, 15.84), 
(2012, 10, 16.87), 
(2012, 11, 16.14), 
(2012, 12, 17.28),

(2013, 1, 14.95), 
(2013, 2, 12.70), 
(2013, 3, 13.98), 
(2013, 4, 14.96), 
(2013, 5, 14.55), 
(2013, 6, 12.74), 
(2013, 7, 14.95), 
(2013, 8, 14.64), 
(2013, 9, 14.21), 
(2013, 10, 15.34), 
(2013, 11, 14.71), 
(2013, 12, 15.37),

(2014, 1, 15.46), 
(2014, 2, 13.85), 
(2014, 3, 14.78), 
(2014, 4, 13.46), 
(2014, 5, 13.79), 
(2014, 6, 12.76), 
(2014, 7, 14.06),
(2014, 8, 13.49), 
(2014, 9, 14.07), 
(2014, 10, 14.82), 
(2014, 11, 13.88), 
(2014, 12, 14.21),

(2015, 1, 14.57), 
(2015, 2, 12.48), 
(2015, 3, 14.56), 
(2015, 4, 13.82), 
(2015, 5, 13.46), 
(2015, 6, 13.35), 
(2015, 7, 15.10), 
(2015, 8, 13.80), 
(2015, 9, 13.91), 
(2015, 10, 14.65), 
(2015, 11, 14.02), 
(2015, 12, 13.91),

(2016, 1, 13.58), 
(2016, 2, 12.80), 
(2016, 3, 14.44), 
(2016, 4, 13.80), 
(2016, 5, 14.44), 
(2016, 6, 14.19), 
(2016, 7, 14.91), 
(2016, 8, 15.16), 
(2016, 9, 14.45), 
(2016, 10, 14.49), 
(2016, 11, 14.12), 
(2016, 12, 14.50),

(2017, 1, 14.49), 
(2017, 2, 12.69), 
(2017, 3, 14.78), 
(2017, 4, 12.88), 
(2017, 5, 14.44), 
(2017, 6, 14.03), 
(2017, 7, 14.80), 
(2017, 8, 14.93), 
(2017, 9, 13.89), 
(2017, 10, 14.24), 
(2017, 11, 13.98), 
(2017, 12, 13.73),

(2018, 1, 14.67), 
(2018, 2, 12.37), 
(2018, 3, 13.76), 
(2018, 4, 13.17), 
(2018, 5, 12.09), 
(2018, 6, 13.31), 
(2018, 7, 14.20), 
(2018, 8, 14.18), 
(2018, 9, 12.91), 
(2018, 10, 13.98), 
(2018, 11, 13.15), 
(2018, 12, 12.60),

(2019, 1, 13.83), 
(2019, 2, 12.27), 
(2019, 3, 12.96), 
(2019, 4, 12.95), 
(2019, 5, 13.82), 
(2019, 6, 11.78), 
(2019, 7, 13.53), 
(2019, 8, 13.49), 
(2019, 9, 12.80), 
(2019, 10, 13.54), 
(2019, 11, 12.25), 
(2019, 12, 12.51),

(2020, 1, 12.97), 
(2020, 2, 11.76), 
(2020, 3, 11.05), 
(2020, 4, 5.35), 
(2020, 5, 5.51), 
(2020, 6, 6.22), 
(2020, 7, 7.39), 
(2020, 8, 8.43), 
(2020, 9, 8.88), 
(2020, 10, 9.83), 
(2020, 11, 10.25), 
(2020, 12, 11.00),

(2021, 1, 10.96), 
(2021, 2, 9.77), 
(2021, 3, 8.62), 
(2021, 4, 8.34), 
(2021, 5, 9.70), 
(2021, 6, 9.06), 
(2021, 7, 9.85), 
(2021, 8, 9.80), 
(2021, 9, 9.23), 
(2021, 10, 9.68), 
(2021, 11, 9.71), 
(2021, 12, 9.99),

(2022, 1, 9.78), 
(2022, 2, 9.37), 
(2022, 3, 10.28), 
(2022, 4, 9.11), 
(2022, 5, 9.70), 
(2022, 6, 9.11), 
(2022, 7, 9.66), 
(2022, 8, 9.96), 
(2022, 9, 9.44), 
(2022, 10, 9.64), 
(2022, 11, 9.38), 
(2022, 12, 9.64),

(2023, 1, 9.37), 
(2023, 2, 8.44), 
(2023, 3, 10.07), 
(2023, 4, 8.96), 
(2023, 5, 9.66), 
(2023, 6, 9.15), 
(2023, 7, 9.82), 
(2023, 8, 10.16), 
(2023, 9, 9.45), 
(2023, 10, 9.74), 
(2023, 11, 9.46), 
(2023, 12, 9.37),

(2024, 1, 9.26), 
(2024, 2, 8.67), 
(2024, 3, 9.30), 
(2024, 4, 9.30), 
(2024, 5, 9.34), 
(2024, 6, 8.78), 
(2024, 7, 9.46), 
(2024, 8, 9.61), 
(2024, 9, 9.12), 
(2024, 10, 9.75), 
(2024, 11, 8.85), 
(2024, 12, 9.14);CREATE TABLE IF NOT EXISTS demanda_pax_por_pagamento (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    mes INTEGER,
    tipo_pagamento VARCHAR(50),
    demanda BIGINT,
    demanda_int_metro BIGINT,
    demanda_int_stec BIGINT,
    demanda_int_brt BIGINT
);

INSERT INTO demanda_pax_por_pagamento(ano, mes, tipo_pagamento, demanda, demanda_int_metro, demanda_int_stec, demanda_int_brt) VALUES
-- Dados de VALE-TRANSPORTE - 2024 (REVISADO)
(2024, 1, 'VALE-TRANSPORTE', 6616634, 3077066, 192102, 71173),
(2024, 2, 'VALE-TRANSPORTE', 6036209, 2795122, 172931, 71056),
(2024, 3, 'VALE-TRANSPORTE', 6507373, 3189873, 186870, 76684),
(2024, 4, 'VALE-TRANSPORTE', 6648075, 3407295, 191672, 82255),
(2024, 5, 'VALE-TRANSPORTE', 6672768, 3394621, 192123, 82918),
(2024, 6, 'VALE-TRANSPORTE', 6087755, 3105782, 171017, 73239),
(2024, 7, 'VALE-TRANSPORTE', 7006992, 3487962, 191768, 91557),
(2024, 8, 'VALE-TRANSPORTE', 7176217, 3630674, 201808, 96340),
(2024, 9, 'VALE-TRANSPORTE', 6706623, 3389685, 189419, 91793),
(2024, 10, 'VALE-TRANSPORTE', 7136392, 3518283, 199515, 100637),
(2024, 11, 'VALE-TRANSPORTE', 6570099, 3272272, 182348, 90412),
(2024, 12, 'VALE-TRANSPORTE', 6615238, 3199235, 185005, 87182),

-- Dados de BILHETE AVULSO - 2024 (REVISADO)
(2024, 1, 'BILHETE AVULSO', 5414629, 3585220, 174020, 74693),
(2024, 2, 'BILHETE AVULSO', 5173955, 3392303, 155748, 75450),
(2024, 3, 'BILHETE AVULSO', 5643203, 3864025, 175918, 85069),
(2024, 4, 'BILHETE AVULSO', 5784056, 4158477, 179707, 91343),
(2024, 5, 'BILHETE AVULSO', 5710597, 4084465, 175877, 92056),
(2024, 6, 'BILHETE AVULSO', 5197529, 3675168, 155519, 82297),
(2024, 7, 'BILHETE AVULSO', 5771766, 4022682, 167463, 100807),
(2024, 8, 'BILHETE AVULSO', 5919976, 4186601, 174023, 105100),
(2024, 9, 'BILHETE AVULSO', 5703098, 3898903, 169007, 100257),
(2024, 10, 'BILHETE AVULSO', 5842609, 4050556, 178409, 105655),
(2024, 11, 'BILHETE AVULSO', 5362639, 3740567, 159249, 94823),
(2024, 12, 'BILHETE AVULSO', 5484382, 3737806, 164394, 94556)
ON CONFLICT DO NOTHING;

-- Dados de MEIA PASSAGEM - 2024

-- Dados de PAGAMENTO EM ESPÉCIE - 2024

-- Dados de GRATUIDADE - 2024

ON CONFLICT DO NOTHING;

INSERT INTO demanda_pax_por_pagamento(ano, mes, tipo_pagamento, demanda, demanda_int_metro, demanda_int_stec, demanda_int_brt) VALUES
-- Dados de VALE-TRANSPORTE - 2023 REVISADO MANUALMENTE


-- Dados de BILHETE AVULSO - 2023

-- Dados de MEIA PASSAGEM - 2023

-- Dados de PAGANTES EM ESPÉCIE - 2023

-- Dados de GRATUIDADE - 2023CREATE TABLE IF NOT EXISTS frota_operante(
    id_frota_operante_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_operante_de_onibus INTEGER
);

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2024, 882),
('SPE2', 2, 2024, 884),
('SPE2', 3, 2024, 948),
('SPE2', 4, 2024, 950),
('SPE2', 5, 2024, 952),
('SPE2', 6, 2024, 949),
('SPE2', 7, 2024, 950),
('SPE2', 8, 2024, 962),
('SPE2', 9, 2024, 967),
('SPE2', 10, 2024, 967),
('SPE2', 11, 2024, 967),
('SPE2', 12, 2024, 945),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2024, 646),
('SPE3', 2, 2024, 644),
('SPE3', 3, 2024, 692),
('SPE3', 4, 2024, 693),
('SPE3', 5, 2024, 693),
('SPE3', 6, 2024, 687),
('SPE3', 7, 2024, 687),
('SPE3', 8, 2024, 695),
('SPE3', 9, 2024, 702),
('SPE3', 10, 2024, 703),
('SPE3', 11, 2024, 703),
('SPE3', 12, 2024, 685)
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2023, 887),
('SPE2', 2, 2023, 892),
('SPE2', 3, 2023, 968),
('SPE2', 4, 2023, 965),
('SPE2', 5, 2023, 965),
('SPE2', 6, 2023, 951),
('SPE2', 7, 2023, 965),
('SPE2', 8, 2023, 966),
('SPE2', 9, 2023, 967),
('SPE2', 10, 2023, 962),
('SPE2', 11, 2023, 959),
('SPE2', 12, 2023, 944),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2023, 652),
('SPE3', 2, 2023, 654),
('SPE3', 3, 2023, 704),
('SPE3', 4, 2023, 706),
('SPE3', 5, 2023, 708),
('SPE3', 6, 2023, 696),
('SPE3', 7, 2023, 709),
('SPE3', 8, 2023, 710),
('SPE3', 9, 2023, 709),
('SPE3', 10, 2023, 703),
('SPE3', 11, 2023, 702),
('SPE3', 12, 2023, 690)
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2022, 884), -- Janeiro
('SPE2', 2, 2022, 934), -- Fevereiro
('SPE2', 3, 2022, 948), -- Março
('SPE2', 4, 2022, 958), -- Abril
('SPE2', 5, 2022, 964), -- Maio
('SPE2', 6, 2022, 961), -- Junho
('SPE2', 7, 2022, 962), -- Julho
('SPE2', 8, 2022, 969), -- Agosto
('SPE2', 9, 2022, 969), -- Setembro
('SPE2', 10, 2022, 970), -- Outubro
('SPE2', 11, 2022, 976), -- Novembro
('SPE2', 12, 2022, 942), -- Dezembro
-- SPE3 => PLATAFORMA
('SPE3', 1, 2022, 612), -- Janeiro
('SPE3', 2, 2022, 684), -- Fevereiro
('SPE3', 3, 2022, 689), -- Março
('SPE3', 4, 2022, 693), -- Abril
('SPE3', 5, 2022, 697), -- Maio
('SPE3', 6, 2022, 696), -- Junho
('SPE3', 7, 2022, 698), -- Julho
('SPE3', 8, 2022, 704), -- Agosto
('SPE3', 9, 2022, 709), -- Setembro
('SPE3', 10, 2022, 709), -- Outubro
('SPE3', 11, 2022, 710), -- Novembro
('SPE3', 12, 2022, 688) -- Dezembro
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- FROTA OPERANTE DE 2021
-- VER PÁGINA 21 DO ANUÁRIO DE 2021
-- SPE1 => SALVADOR NORTE
('SPE1', 1, 2021, 444), -- Janeiro
('SPE1', 2, 2021, 445), -- Fevereiro
('SPE1', 3, 2021, 412), -- Março
('SPE1', 4, 2021, 329), -- Abril
('SPE1', 5, 2021, 333), -- Maio
('SPE1', 6, 2021, 237), -- Junho
('SPE1', 7, 2021, 235), -- Julho
('SPE1', 8, 2021, 199), -- Agosto
('SPE1', 9, 2021, 145), -- Setembro
('SPE1', 10, 2021, 0), -- Outubro
('SPE1', 11, 2021, 0), -- Novembro
('SPE1', 12, 2021, 0), -- Dezembro
-- SPE2 => OTTRANS
('SPE2', 1, 2021, 803), -- Janeiro
('SPE2', 2, 2021, 787), -- Fevereiro
('SPE2', 3, 2021, 695), -- Março
('SPE2', 4, 2021, 774), -- Abril
('SPE2', 5, 2021, 793), -- Maio
('SPE2', 6, 2021, 804), -- Junho
('SPE2', 7, 2021, 802), -- Julho
('SPE2', 8, 2021, 809), -- Agosto
('SPE2', 9, 2021, 822), -- Setembro
('SPE2', 10, 2021, 908), -- Outubro
('SPE2', 11, 2021, 931), -- Novembro
('SPE2', 12, 2021, 928), -- Dezembro
-- SPE3 => PLATAFORMA
('SPE3', 1, 2021, 619), -- Janeiro
('SPE3', 2, 2021, 604), -- Fevereiro
('SPE3', 3, 2021, 490), -- Março
('SPE3', 4, 2021, 562), -- Abril
('SPE3', 5, 2021, 571), -- Maio
('SPE3', 6, 2021, 584), -- Junho
('SPE3', 7, 2021, 595), -- Julho
('SPE3', 8, 2021, 599), -- Agosto
('SPE3', 9, 2021, 671), -- Setembro
('SPE3', 10, 2021, 684), -- Outubro
('SPE3', 11, 2021, 683), -- Novembro
('SPE3', 12, 2021, 683) -- Dezembro
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- INTEGRA SALVADOR NORTE (SPE1) - 2020
('SPE1', 1, 2020, 691),
('SPE1', 2, 2020, 693),
('SPE1', 3, 2020, 585),
('SPE1', 4, 2020, 280),
('SPE1', 5, 2020, 301),
('SPE1', 6, 2020, 390),
('SPE1', 7, 2020, 307),
('SPE1', 8, 2020, 337),
('SPE1', 9, 2020, 361),
('SPE1', 10, 2020, 394),
('SPE1', 11, 2020, 437),
('SPE1', 12, 2020, 440),
-- OT-TRANS (SPE2) - 2020
('SPE2', 1, 2020, 803),
('SPE2', 2, 2020, 762),
('SPE2', 3, 2020, 672),
('SPE2', 4, 2020, 422),
('SPE2', 5, 2020, 462),
('SPE2', 6, 2020, 507),
('SPE2', 7, 2020, 587),
('SPE2', 8, 2020, 648),
('SPE2', 9, 2020, 662),
('SPE2', 10, 2020, 749),
('SPE2', 11, 2020, 802),
('SPE2', 12, 2020, 801),
-- INTEGRA PLATAFORMA (SPE3) - 2020
('SPE3', 1, 2020, 655),
('SPE3', 2, 2020, 606),
('SPE3', 3, 2020, 541),
('SPE3', 4, 2020, 305),
('SPE3', 5, 2020, 319),
('SPE3', 6, 2020, 370),
('SPE3', 7, 2020, 413),
('SPE3', 8, 2020, 473),
('SPE3', 9, 2020, 525),
('SPE3', 10, 2020, 567),
('SPE3', 11, 2020, 598),
('SPE3', 12, 2020, 612)
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- INTEGRA SALVADOR NORTE (SPE1) - 2019
('SPE1', 1, 2019, 602),
('SPE1', 2, 2019, 620),
('SPE1', 3, 2019, 628),
('SPE1', 4, 2019, 638),
('SPE1', 5, 2019, 630),
('SPE1', 6, 2019, 620),
('SPE1', 7, 2019, 615),
('SPE1', 8, 2019, 593),
('SPE1', 9, 2019, 631),
('SPE1', 10, 2019, 629),
('SPE1', 11, 2019, 607),
('SPE1', 12, 2019, 604),
-- OT-TRANS (SPE2) - 2019
('SPE2', 1, 2019, 741),
('SPE2', 2, 2019, 749),
('SPE2', 3, 2019, 755),
('SPE2', 4, 2019, 751),
('SPE2', 5, 2019, 775),
('SPE2', 6, 2019, 768),
('SPE2', 7, 2019, 761),
('SPE2', 8, 2019, 762),
('SPE2', 9, 2019, 776),
('SPE2', 10, 2019, 770),
('SPE2', 11, 2019, 769),
('SPE2', 12, 2019, 775),
-- INTEGRA PLATAFORMA (SPE3) - 2019
('SPE3', 1, 2019, 652),
('SPE3', 2, 2019, 666),
('SPE3', 3, 2019, 647),
('SPE3', 4, 2019, 655),
('SPE3', 5, 2019, 660),
('SPE3', 6, 2019, 645),
('SPE3', 7, 2019, 659),
('SPE3', 8, 2019, 661),
('SPE3', 9, 2019, 662),
('SPE3', 10, 2019, 662),
('SPE3', 11, 2019, 587),
('SPE3', 12, 2019, 653)
ON CONFLICT DO NOTHING;CREATE TABLE IF NOT EXISTS frota_total(
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
ON CONFLICT DO NOTHING;-- PAGINA 38 DE 98 DO ANUARIO 2022
-- HISTÓRICO DA IDADE MÉDIA DA FROTA DE ÔNIBUS

CREATE TABLE IF NOT EXISTS historico_idade_media_frota(
    id_historico SERIAL PRIMARY KEY,
    ano INTEGER,
	mes INTEGER,
    idade_media FLOAT
);

INSERT INTO historico_idade_media_frota(ano, mes, idade_media) VALUES
(2001, 01, 3.98),
(2001, 02, 3.90),
(2001, 03, 3.83),
(2001, 04, 3.80),
(2001, 05, 3.80),
(2001, 06, 3.79),
(2001, 07, 3.71),
(2001, 08, 3.73),
(2001, 09, 3.81),
(2001, 10, 3.84),
(2001, 11, 3.86),
(2001, 12, 3.87),

(2002, 01, 3.85),
(2002, 02, 3.90),
(2002, 03, 3.97),
(2002, 04, 3.96),
(2002, 05, 3.89),
(2002, 06, 3.88),
(2002, 07, 2.92),
(2002, 08, 3.96),
(2002, 09, 3.96),
(2002, 10, 3.94),
(2002, 11, 3.89),
(2002, 12, 3.90),

(2003, 01, 3.96),
(2003, 02, 3.90),
(2003, 03, 3.90),
(2003, 04, 3.88),
(2003, 05, 3.86),
(2003, 06, 3.89),
(2003, 07, 3.92),
(2003, 08, 3.91),
(2003, 09, 3.98),
(2003, 10, 4.06),
(2003, 11, 4.13),
(2003, 12, 4.14),

(2004, 01, 4.22),
(2004, 02, 4.26),
(2004, 03, 4.31),
(2004, 04, 4.36),
(2004, 05, 4.40),
(2004, 06, 4.44),
(2004, 07, 4.51),
(2004, 08, 4.63),
(2004, 09, 4.70),
(2004, 10, 4.76),
(2004, 11, 4.81),
(2004, 12, 4.76),

(2005, 01, 4.77),
(2005, 02, 4.81),
(2005, 03, 4.90),
(2005, 04, 4.95),
(2005, 05, 4.96),
(2005, 06, 4.96),
(2005, 07, 4.93),
(2005, 08, 4.98),
(2005, 09, 5.05),
(2005, 10, 5.07),
(2005, 11, 5.10),
(2005, 12, 5.09),

(2006, 01, 5.17),
(2006, 02, 5.19),
(2006, 03, 5.12),
(2006, 04, 5.08),
(2006, 05, 5.01),
(2006, 06, 5.05),
(2006, 07, 5.07),
(2006, 08, 5.09),
(2006, 09, 5.14),
(2006, 10, 5.12),
(2006, 11, 5.15),
(2006, 12, 5.23),

(2007, 01, 5.30),
(2007, 02, 5.29),
(2007, 03, 5.29),
(2007, 04, 5.23),
(2007, 05, 5.28),
(2007, 06, 5.25),
(2007, 07, 5.16),
(2007, 08, 4.97),
(2007, 09, 4.79),
(2007, 10, 4.77),
(2007, 11, 4.80),
(2007, 12, 4.85),

(2008, 01, 4.86),
(2008, 02, 4.93),
(2008, 03, 4.99),
(2008, 04, 5.07),
(2008, 05, 5.15),
(2008, 06, 5.11),
(2008, 07, 5.07),
(2008, 08, 5.06),
(2008, 09, 4.87),
(2008, 10, 4.77),
(2008, 11, 4.77),
(2008, 12, 4.78),

(2009, 01, 4.71),
(2009, 02, 4.76),
(2009, 03, 4.85),
(2009, 04, 4.92),
(2009, 05, 4.96),
(2009, 06, 4.95),
(2009, 07, 4.89),
(2009, 08, 4.90),
(2009, 09, 4.90),
(2009, 10, 4.91),
(2009, 11, 4.91),
(2009, 12, 4.92),

(2010, 01, 4.95),
(2010, 02, 4.89),
(2010, 03, 4.80),
(2010, 04, 4.80),
(2010, 05, 4.72),
(2010, 06, 4.77),
(2010, 07, 4.78),
(2010, 08, 4.76),
(2010, 09, 4.81),
(2010, 10, 4.76),
(2010, 11, 4.70),
(2010, 12, 4.72),

(2011, 01, 4.74),
(2011, 02, 4.79),
(2011, 03, 4.71),
(2011, 04, 4.77),
(2011, 05, 4.83),
(2011, 06, 4.87),
(2011, 07, 4.86),
(2011, 08, 4.89),
(2011, 09, 4.92),
(2011, 10, 4.84),
(2011, 11, 4.79),
(2011, 12, 4.86),

(2012, 01, 4.89),
(2012, 02, 4.95),
(2012, 03, 4.93),
(2012, 04, 4.87),
(2012, 05, 4.92),
(2012, 06, 4.98),
(2012, 07, 5.01),
(2012, 08, 5.07),
(2012, 09, 5.12),
(2012, 10, 5.18),
(2012, 11, 4.96),
(2012, 12, 4.96),

(2013, 01, 5.00),
(2013, 02, 5.05),
(2013, 03, 5.03),
(2013, 04, 4.92),
(2013, 05, 4.77),
(2013, 06, 4.72),
(2013, 07, 4.74),
(2013, 08, 4.74),
(2013, 09, 4.79),
(2013, 10, 4.72),
(2013, 11, 4.68),
(2013, 12, 4.64),

(2014, 01, 4.62),
(2014, 02, 4.61),
(2014, 03, 4.63),
(2014, 04, 4.61),
(2014, 05, 4.67),
(2014, 06, 4.83),
(2014, 07, 4.76),
(2014, 08, 4.69),
(2014, 09, 4.72),
(2014, 10, 4.79),
(2014, 11, 4.81),
(2014, 12, 4.54),

(2015, 01, 4.33),
(2015, 02, 4.33),
(2015, 03, 3.79),
(2015, 04, 3.79),
(2015, 05, 3.68),
(2015, 06, 3.75),
(2015, 07, 3.63),
(2015, 08, 3.70),
(2015, 09, 3.60),
(2015, 10, 3.55),
(2015, 11, 3.54),
(2015, 12, 3.61),

(2016, 01, 3.54),
(2016, 02, 3.62),
(2016, 03, 3.69),
(2016, 04, 3.76),
(2016, 05, 3.84),
(2016, 06, 3.92),
(2016, 07, 4.00),
(2016, 08, 4.09),
(2016, 09, 4.16),
(2016, 10, 4.25),
(2016, 11, 4.33),
(2016, 12, 4.40),

(2017, 01, 4.49),
(2017, 02, 4.56),
(2017, 03, 4.65),
(2017, 04, 4.74),
(2017, 05, 4.82),
(2017, 06, 4.89),
(2017, 07, 4.97),
(2017, 08, 5.05),
(2017, 09, 5.13),
(2017, 10, 5.22),
(2017, 11, 5.30),
(2017, 12, 5.38),

(2018, 01, 5.44),
(2018, 02, 5.47),
(2018, 03, 5.47),
(2018, 04, 5.54),
(2018, 05, 5.63),
(2018, 06, 5.70),
(2018, 07, 5.88),
(2018, 08, 5.96),
(2018, 09, 6.23),
(2018, 10, 6.14),
(2018, 11, 6.22),
(2018, 12, 6.30),

(2019, 01, 6.38),
(2019, 02, 6.46),
(2019, 03, 6.54),
(2019, 04, 6.62),
(2019, 05, 6.71),
(2019, 06, 6.78),
(2019, 07, 6.60),
(2019, 08, 6.56),
(2019, 09, 6.47),
(2019, 10, 6.51),
(2019, 11, 6.51),
(2019, 12, 6.53),

(2020, 01, 6.61),
(2020, 02, 6.69),
(2020, 03, 6.80),
(2020, 04, 6.88),
(2020, 05, 6.96),
(2020, 06, 7.05),
(2020, 07, 7.21),
(2020, 08, 7.21),
(2020, 09, 7.03),
(2020, 10, 7.11),
(2020, 11, 7.28),
(2020, 12, 7.29),

(2021, 01, 7.30),
(2021, 02, 7.35),
(2021, 03, 7.34),
(2021, 04, 7.49),
(2021, 05, 7.57),
(2021, 06, 7.65),
(2021, 07, 7.73),
(2021, 08, 7.98),
(2021, 09, 7.73),
(2021, 10, 7.47),
(2021, 11, 7.55),
(2021, 12, 7.39),

(2022, 01, 7.34),
(2022, 02, 7.41),
(2022, 03, 7.35),
(2022, 04, 7.34),
(2022, 05, 7.42),
(2022, 06, 7.50),
(2022, 07, 7.58),
(2022, 08, 7.66),
(2022, 09, 7.58),
(2022, 10, 7.63),
(2022, 11, 7.70),
(2022, 12, 7.79),

-- FONTE: ANUÁRIO 2024
-- HISTÓRICO DE IDADE MÉDIA
-- PÁGINA 40 DE 122
(2023, 01, 7.89),
(2023, 02, 7.73),
(2023, 03, 7.79),
(2023, 04, 7.70),
(2023, 05, 7.52),
(2023, 06, 7.61),
(2023, 07, 7.61),
(2023, 08, 7.69),
(2023, 09, 7.81),
(2023, 10, 7.89),
(2023, 11, 7.97),
(2023, 12, 8.05),

(2024, 01, 8.14),
(2024, 02, 8.21),
(2024, 03, 8.24),
(2024, 04, 8.06),
(2024, 05, 8.14),
(2024, 06, 8.21),
(2024, 07, 8.16),
(2024, 08, 8.23),
(2024, 09, 8.27),
(2024, 10, 8.24),
(2024, 11, 8.33),
(2024, 12, 8.42)
ON CONFLICT DO NOTHING;CREATE TABLE indicadores_financeiros_stco (
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
$$;INSERT INTO aquisicoes_de_onibus_por_mes(
    id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
('SPE2', 2, 2023, 39, TRUE),
('SPE2', 3, 2023, 41, TRUE),
('SPE2', 4, 2023, 9, TRUE),
('SPE2', 10, 2023, 1, TRUE),
('SPE2', 11, 2023, 1, TRUE),
('SPE3', 1, 2023, 9, TRUE),
('SPE3', 4, 2023, 15, TRUE),
('SPE3', 5, 2023, 30, TRUE),
('SPE3', 7, 2023, 20, TRUE),
('SPE3', 9, 2023, 5, TRUE)
ON CONFLICT DO NOTHING;CREATE TABLE IF NOT EXISTS historico_passageiros_transportados_metro_mes (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    mes INTEGER,
    passageiros FLOAT
);

-- pg. 107 de 122, anuário 2024
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2024, 1, 8867882), 
(2024, 2, 8737633), 
(2024, 3, 9679775), 
(2024, 4, 10259653), 
(2024, 5, 10064494), 
(2024, 6, 9268785), 
(2024, 7, 10072467), 
(2024, 8, 10717066), 
(2024, 9, 10087125), 
(2024, 10, 10424478), 
(2024, 11, 9731113), 
(2024, 12, 9648818)
ON CONFLICT DO NOTHING;

-- pg. 108 de 120, anuário 2023
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2023, 1, 7952865), 
(2023, 2, 7336406), 
(2023, 3, 9021576), 
(2023, 4, 7957512), 
(2023, 5, 9017200), 
(2023, 6, 8212456), 
(2023, 7, 8545572), 
(2023, 8, 9167134), 
(2023, 9, 8548910), 
(2023, 10, 8894551), 
(2023, 11, 8809053), 
(2023, 12, 8220819)
ON CONFLICT DO NOTHING;

-- pg. 108 de 120, anuário 2023
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2023, 1, 7952865), 
(2023, 2, 7336406), 
(2023, 3, 9021576), 
(2023, 4, 7957512), 
(2023, 5, 9017200), 
(2023, 6, 8212456), 
(2023, 7, 8545572), 
(2023, 8, 9167134), 
(2023, 9, 8548910), 
(2023, 10, 8894551), 
(2023, 11, 8809053), 
(2023, 12, 8220819)
ON CONFLICT DO NOTHING;

-- pg. 87 de 98, anuário 2022
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2022, 1, 6492143), 
(2022, 2, 6608119), 
(2022, 3, 7967875), 
(2022, 4, 7359865), 
(2022, 5, 8503839), 
(2022, 6, 7335367), 
(2022, 7, 8002317), 
(2022, 8, 9006797), 
(2022, 9, 8540980), 
(2022, 10, 8418408), 
(2022, 11, 8168878), 
(2022, 12, 8062477)
ON CONFLICT DO NOTHING;

-- pg. 83 de 94, anuário 2021
-- dados corrompidos quando se copia, foi feita cópia à mão.
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2021, 1, 5676174), 
(2021, 2, 5229476), 
(2021, 3, 4186679), 
(2021, 4, 4840832), 
(2021, 5, 5792425), 
(2021, 6, 5517453), 
(2021, 7, 6234539), 
(2021, 8, 6772156), 
(2021, 9, 6746322), 
(2021, 10, 6904522), 
(2021, 11, 7141218), 
(2021, 12, 7370029)
ON CONFLICT DO NOTHING;

-- pg 69 de 79, anuário 2020
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2020, 1, 8630517), 
(2020, 2, 8391299), 
(2020, 3, 6566546), 
(2020, 4, 2364784), 
(2020, 5, 2448648), 
(2020, 6, 2927139), 
(2020, 7, 3470222), 
(2020, 8, 4351630), 
(2020, 9, 5107306), 
(2020, 10, 5611245), 
(2020, 11, 5808845), 
(2020, 12, 6332303)
ON CONFLICT DO NOTHING;

-- pg 89 de 99, anuário 2019
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2019, 1, 8045059), 
(2019, 2, 8239263), 
(2019, 3, 8513151), 
(2019, 4, 8880748), 
(2019, 5, 9273996), 
(2019, 6, 7801605), 
(2019, 7, 8835366), 
(2019, 8, 9789332), 
(2019, 9, 9426206), 
(2019, 10, 9942315), 
(2019, 11, 9395569), 
(2019, 12, 9288598)
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS historico_passageiros_transportados_metro_ano (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    passageiros FLOAT
);

INSERT INTO historico_passageiros_transportados_metro_ano(ano, passageiros) VALUES
(2024, 117559289),
(2023, 101684054),
(2022, 94467065),
(2021, 72411815),
(2020, 62010484),
(2019, 107431208),
(2018, 91730164),
(2017, 41989575),
(2016, 11001753),
(2015, 10523501)
ON CONFLICT DO NOTHING;-- PAGINA 58 DE 98 DO ANUARIO 2022
-- EVOLUÇÃO DA FROTA DE TÁXIS
CREATE TABLE IF NOT EXISTS frota_de_taxis (
    id_frota_taxis SERIAL PRIMARY KEY,
    ano INTEGER,
    taxis_comum_autonomos INTEGER,
    taxis_comum_empresas INTEGER,
    total_taxis_comum INTEGER,
    taxis_especiais INTEGER,
    total_geral INTEGER
);

INSERT INTO frota_de_taxis (ano, taxis_comum_autonomos, taxis_comum_empresas, total_taxis_comum, taxis_especiais, total_geral ) VALUES
(1984, 7163, 141, 7304, 174, 7478),
(1985, 7156, 138, 7294, 177, 7471),
(1986, 7165, 87, 7252, 276, 7528),
(1987, 7110, 78, 7188, 272, 7460),
(1988, 7108, 91, 7199, 267, 7466),
(1989, 7125, 168, 7293, 281, 7574),
(1990, 7063, 189, 7252, 279, 7531),
(1991, 6480, 189, 6669, 261, 6930),
(1992, 6428, 192, 6620, 266, 6886),
(1993, 6428, 194, 6622, 263, 6885),
(1994, 6458, 197, 6655, 270, 6925),
(1995, 6458, 240, 6698, 269, 6967),
(1996, 6449, 348, 6797, 269, 7066),
(1997, 6327, 398, 6725, 267, 6992),
(1998, 6397, 416, 6813, 269, 7082),
(1999, 6433, 422, 6855, 269, 7124),
(2000, 6475, 428, 6903, 269, 7172),
(2001, 6481, 432, 6913, 269, 7182),
(2002, 6539, 405, 6944, 269, 7213),
(2003, 6618, 349, 6967, 269, 7236),
(2004, 6665, 326, 6991, 269, 7260),
(2005, 6709, 285, 6994, 269, 7263),
(2006, 6721, 274, 6995, 269, 7264),
(2007, 6758, 238, 6996, 269, 7265),
(2008, 6781, 215, 6996, 269, 7265),
(2009, 6806, 190, 6996, 268, 7264),
(2010, 6809, 187, 6996, 269, 7265),
(2011, 6996, 186, 7182, 270, 7452),
(2012, 6813, 182, 6995, 270, 7265),
(2013, 6819, 175, 6994, 270, 7264),
(2014, 6820, 176, 6996, 270, 7266),
(2015, 6824, 172, 6996, 270, 7266),
(2016, 6824, 172, 6996, 270, 7266),
(2017, 6824, 162, 6986, 270, 7256),
(2018, 6851, 119, 6970, 270, 7240),
(2019, 6880, 65, 6945, 270, 7215),
(2020, 6943, 53, 6996, 270, 7266),
(2021, 6996, 50, 7046, 263, 7309),
(2022, 6642, 31, 6673, 263, 6936);

-- PAGINA 74/122 DO ANUARIO 2024 - páginas absolutas, a página é 66, se seguir o número na folha
-- EVOLUÇÃO DA FROTA DE TÁXIS
INSERT INTO frota_de_taxis (ano, taxis_comum_autonomos, taxis_comum_empresas, total_taxis_comum, taxis_especiais, total_geral ) VALUES
(2023, 6680, 10, 6690, 248, 6938),
(2024, 6789, 8, 6797, 247, 7044);

CREATE TABLE distribuicao_taxis_por_tipo_de_servico (
    id_distribuicao_taxis_por_tipo_de_servico SERIAL PRIMARY KEY,
    ano INTEGER,
    tipo_de_servico TEXT,
    entidade_operadora TEXT,
    total_de_veiculos INTEGER
);

-- PAGINA 59 DE 98 DO ANUARIO 2022
-- DISTRIBUIÇÃO DA FROTA DE TAXIS POR SERVIÇO
INSERT INTO distribuicao_taxis_por_tipo_de_servico (ano, tipo_de_servico, entidade_operadora, total_de_veiculos) VALUES
(2022, 'Táxis Especiais', 'COMTAS - Cooperativa Mista de Trabalho dos Motoristas Autônomos de Salvador', 147),
(2022, 'Táxis Especiais', 'COOMETAS - Cooperativa Metropolitana de Táxis Especiais de Salvador', 116),
(2022, 'Táxis Comuns - Empresas', 'IRACEMA OLIVEIRA', 2),
(2022, 'Táxis Comuns - Empresas', 'POTIGUAR', 8),
(2022, 'Táxis Comuns - Empresas', 'IRIANE', 2),
(2022, 'Táxis Comuns - Empresas', 'COSME E DAMIÃO', 1),
(2022, 'Táxis Comuns - Empresas', 'N. Sra. DA CONCEIÇÃO', 10),
(2022, 'Táxis Comuns - Empresas', 'ST - Empresa Salvador', 2),
(2022, 'Táxis Comuns - Empresas', 'GASCOM', 6),
(2022, 'Táxis Comuns - Rádio Táxis', 'ALÔ TÁXI', 278),
(2022, 'Táxis Comuns - Rádio Táxis', 'BAHIA TÁXI (EMBATTUR)', 175),
(2022, 'Táxis Comuns - Rádio Táxis', 'LIGUE TÁXI', 143),
(2022, 'Táxis Comuns - Rádio Táxis', 'COOPTELETAXI', 50),
(2022, 'Táxis Comuns - Rádio Táxis', 'RODOTÁXI', 112),
(2022, 'Táxis Comuns - Rádio Táxis', 'USETÁXI (BATUR)', 188),
-- CÁLCULO:
-- 6642 É O NUMERO DE TÁXIS AUTONOMOS INCLUINDO RÁDIO TÁXIS
-- 946 É O TOTAL DE RÁDIO TÁXIS
-- O NÚMERO DE AUTONOMOS É 6642 - 946 = 5696
(2022, 'Táxis Comuns - Autônomos', 'Autônomos', 5696),
(2022, 'Moto-táxis', 'Moto-táxis', 1196);

-- PAGINA 60 DE 98 DO ANUARIO 2022 ==== OBS FINAL DA PÁGINA, RODAPÉ
-- TÁXIS POR TIPO DE COMBUSTIVEL
CREATE TABLE taxis_por_combustivel (
    id_taxis_por_combustivel SERIAL PRIMARY KEY,
    ano INTEGER,
    tipo_combustivel TEXT,
    quantidade INTEGER
);

INSERT INTO taxis_por_combustivel (ano, tipo_combustivel, quantidade) VALUES
(2022, 'Álcool', 10),
(2022, 'Álcool/GNV', 21),
(2022, 'Álcool/Gasolina', 5371),
(2022, 'Álcool/Gasolina/GNV', 1260),
(2022, 'Gasolina/GNV', 17),
(2022, 'Gasolina', 36),
(2022, 'Gasolina/Álcool/Elétrico', 18),
(2022, 'Óleo Diesel', 1),
(2022, 'Não Informado', 202);
-- O TOTAL CONFERE COM O TOTAL DE TÁXIS NA PÁGINA 59

INSERT INTO taxis_por_combustivel (ano, tipo_combustivel, quantidade) VALUES
-- PAGINA 76/122 - ANUÁRIO 2024
-- TÁXIS POR TIPO DE COMBUSTÍVEL; RODAPÉ
(2024, 'Álcool', 11),
(2024, 'Álcool/GNV', 36),
(2024, 'Álcool/Gasolina', 5321),
(2024, 'Álcool/Gasolina/GNV', 1554),
(2024, 'Gasolina/GNV', 14),
(2024, 'Gasolina', 40),
(2024, 'Gasolina/Álcool/Elétrico', 49),
(2024, 'Elétrico', 15),
(2024, 'Óleo Diesel', 3),
(2024, 'Não Informado', 0);

CREATE TABLE idade_media_da_frota_de_taxis (
    id_idade_media_taxis SERIAL PRIMARY KEY,
    ano INTEGER,
    idade_media FLOAT
    -- A IDADE MÉDIA É EM ANOS!
);

INSERT INTO idade_media_da_frota_de_taxis (ano, idade_media) VALUES
-- PARA 2022, VER RODAPÉ DA PÁGINA 63 DE 98 DO ANUÁRIO DE 2022
(2022, 6.23);

-- PAGINA 63 DE 98 DO ANUARIO 2022
-- TÁXIS POR TIPO DE COMBUSTIVEL
CREATE TABLE tipos_veiculos_servico_taxis (
    id_tipos_veiculos_taxis SERIAL PRIMARY KEY,
    ano_registro INTEGER,
    mes_registro INTEGER,
    marca TEXT,
    modelo TEXT,
    quantidade INTEGER
);

INSERT INTO tipos_veiculos_servico_taxis (ano_registro, mes_registro, marca, modelo, quantidade) VALUES
(2022, 12, 'GENERAL MOTORS', 'SPIN', 1474),
(2022, 12, 'GENERAL MOTORS', 'PRISMA', 725),
(2022, 12, 'GENERAL MOTORS', 'ONIX', 633),
(2022, 12, 'FIAT', 'SIENA', 552),
(2022, 12, 'GENERAL MOTORS', 'COBALT', 510),
(2022, 12, 'VOLKSWAGEN', 'VOYAGE', 351),
(2022, 12, 'GENERAL MOTORS', 'CORSA CLASSIC', 261),
(2022, 12, 'TOYOTA', 'COROLLA', 202),
(2022, 12, 'TOYOTA', 'ETTIOS', 156),
(2022, 12, 'GENERAL MOTORS', 'TRACKER', 156),
(2022, 12, 'GENERAL MOTORS', 'CORSA SEDAN', 137),
(2022, 12, 'RENAULT', 'DUSTER', 135),
(2022, 12, 'RENAULT', 'LOGAN', 129),
(2022, 12, 'GENERAL MOTORS', 'MERIVA', 113),
(2022, 12, 'TOYOTA', 'YARIS', 109),
(2022, 12, 'FORD', 'KA', 107),
(2022, 12, 'VOLKSWAGEN', 'VIRTUS', 104),
(2022, 12, 'RENAULT', 'KWID', 91),
(2022, 12, 'FIAT', 'CRONOS', 82),
(2022, 12, 'NISSAN', 'KICKS', 56), -- FOI REGISTRADO NISSAN KICKS DUAS VEZES NO DOCUMENTO ORIGINAL - ANUÁRIO DE 2022!
(2022, 12, 'NISSAN', 'VERSA', 55),
(2022, 12, 'HONDA', 'HRV', 50),
(2022, 12, 'FIAT', 'DOBLÓ', 41),
(2022, 12, 'FIAT', 'PALIO', 41),
(2022, 12, 'NISSAN', 'KICKS', 40), -- FOI REGISTRADO NISSAN KICKS DUAS VEZES NO DOCUMENTO ORIGINAL - ANUÁRIO DE 2022!
(2022, 12, 'VOLKSWAGEN', 'GOL', 38),
(2022, 12, 'FIAT', 'UNO', 34),
(2022, 12, 'VOLKSWAGEN', 'SPACEFOX', 29),
(2022, 12, 'GENERAL MOTORS', 'CRUZE', 26),
(2022, 12, 'FIAT', 'IDEA', 25),
(2022, 12, 'RENAULT', 'SANDERO', 23),
(2022, 12, 'FIAT', 'ARGO', 22),
(2022, 12, 'HONDA', 'CITY', 21),
(2022, 12, 'CHERRY', 'TIGGO', 21),
(2022, 12, 'VOLKSWAGEN', 'SPACEFOX', 20),
(2022, 12, 'HONDA', 'CIVIC', 19),
(2022, 12, 'VOLKSWAGEN', 'FOX', 18),
(2022, 12, 'JEEP', 'COMPASS', 17),
(2022, 12, 'JEEP', 'RENEGADE', 16),
(2022, 12, 'FIAT', 'WEEKEND', 16),
(2022, 12, 'FORD', 'FIESTA', 15),
(2022, 12, 'FIAT', 'MOBI', 14),
(2022, 12, 'FIAT', 'LINEA', 13),
(2022, 12, 'HYUNDAI', 'HB20', 12),
(2022, 12, 'VOLKSWAGEN', 'POLO', 11),
(2022, 12, 'JEEP', 'RENEGADE', 11),
(2022, 12, 'JEEP', 'COMPASS', 11),
(2022, 12, 'GENERAL MOTORS', 'ZAFIRA', 10),
(2022, 12, 'GENERAL MOTORS', 'ASTRA', 10),
(2022, 12, 'FIAT', 'PULSE', 10),
(2022, 12, 'VOLKSWAGEN', 'CROSS', 9),
(2022, 12, 'RENAULT', 'CAPTUR', 8),
(2022, 12, 'VOLKSWAGEN', 'PARATI', 7),
(2022, 12, 'GENERAL MOTORS', 'VECTRA', 7),
(2022, 12, 'FORD', 'ECOSPORT', 7),
(2022, 12, 'FORD', 'FOCUS', 7),
(2022, 12, 'HONDA', 'WRV', 6),
(2022, 12, 'VOLKSWAGEN', 'NIVUS', 5),
(2022, 12, 'HONDA', 'FIT', 5),
(2022, 12, 'GENERAL MOTORS', 'KADETT', 4),
(2022, 12, 'CHERRY', 'CELLER', 4),
(2022, 12, 'JAC', 'J3', 3),
(2022, 12, 'VOLKSWAGEN', 'SANTANA', 2),
(2022, 12, 'VOLKSWAGEN', 'POINTER', 2),
(2022, 12, 'RENAULT', 'FLUENCE', 2),
(2022, 12, 'RENAULT', 'CLIO', 2),
(2022, 12, 'NISSAN', 'LIVINA', 2),
(2022, 12, 'NISSAN', 'GRAN LIVINA', 2),
(2022, 12, 'NISSAN', 'MARCH', 2),
(2022, 12, 'GENERAL MOTORS', 'AGILE', 2),
(2022, 12, 'CHERRY', 'CELLER', 2),
(2022, 12, 'OUTROS / NI', 'OUTROS / NI', 74);-- pg. 53 de 122, anuário 2024
CREATE TABLE IF NOT EXISTS veiculos_novos_adquiridos_por_ano (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    veiculos INTEGER
);

INSERT INTO veiculos_novos_adquiridos_por_ano(ano, veiculos) VALUES
(2001, 355),
(2002, 304),
(2003, 272),
(2004, 141),
(2005, 193),
(2006, 259),
(2007, 426),
(2008, 380),
(2009, 274),
(2010, 364),
(2011, 278),
(2012, 264),
(2013, 419),
(2014, 454),
(2015, 253),
(2016, 26),
(2017, 0),
(2018, 0),
(2019, 199),
(2020, 0),
(2021, 70),
(2022, 143),
(2023, 170),
(2024, 84)
ON CONFLICT DO NOTHING;