CREATE TABLE IF NOT EXISTS corredores_de_onibus(
    id_corredor SERIAL PRIMARY KEY,
    nome_corredor VARCHAR(255),
    qtd_onibus_por_hora INTEGER,
    extensao_em_kms FLOAT,
    qtd_linhas_convencionais INTEGER,
    ano INTEGER
);

INSERT INTO corredores_de_onibus(nome_corredor, qtd_onibus_por_hora, extensao_em_kms, qtd_linhas_convencionais, ano) VALUES
('BR - 324(Coca-Cola)', 58, 21.39, 16, 2022),
('AV. ALIOMAR BALEEIRO(Mansão do Caminho)', 44, 19.04, 15, 2022),
('AV. AFRÂNIO PEIXOTO(Baixa do Fiscal)', 114, 14.50, 35, 2022),
('AV. LUIS VIANA FILHO(PARALELA) - Shopping Amazonas', 117, 13.37, 26, 2022),
('AV. OCTÁVIO MANGABEIRA(Sol Plaza Hotel)', 51, 13.18, 14, 2022),
('AV. ANTONIO CARLOS MAGALHÃES(Mc Donald''s)', 165, 6.80, 39, 2022),
('EST. CAMPINAS / S. CAETANO(Bompreço)', 60, 5.67, 14, 2022),
('AV. JURACY MAGALHÃES JR. / Vale das Pedrinhas', 88, 4.99, 22, 2022),
('AV. S. MARCOS/ AV. S. RAFAEL(Hospital São Rafael)', 61, 4.59, 15, 2022),
('AV. MÁRIO LEAL FERREIRA(BONOCÔ) Escola da Bíblia', 77, 4.51, 21, 2022),
('R. SILVEIRA MARTINS(Chácara Cabula)', 61, 4.50, 17, 2022),
('AV. TANCREDO NEVES(Hospital Sarah)', 157, 3.86, 36, 2022),
('AV. VASCO DA GAMA(Perini)', 68, 3.60, 16, 2022),
('AV. DA FRANÇA(Fuzileiros Navais)', 142, 3.23, 43, 2022),
('AV. CENTENÁRIO(Hospital Santo Amaro)', 63, 2.82, 12, 2022),
('AV. D. JOÃO VI(Hospital Aristides Maltez)', 26, 2.78, 9, 2022),
('R. LIMA E SILVA(Plano Inclinado)', 48, 2.60, 8, 2022),
('AV. CARDEAL DA SILVA(Unifacs)', 26, 2.17, 4, 2022),
('AV. SETE DE SETEMBRO(Porto da Barra)', 47, 2.10, 9, 2022),
('AV. JOANA ANGÉLICA(Colégio Central)', 23, 1.38, 4, 2022),
('RUA CARLOS GOMES(Igreja Universal)', 69, 1.11, 18, 2022),
('AV. BARROS REIS(Madeireira Cristo Rei)', 113, 2.00, 30, 2022),
('AV. HEITOR DIAS(Bar Sertanejo)', 77, 2.00, 18, 2022)
ON CONFLICT DO NOTHING;

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

CREATE TABLE IF NOT EXISTS aquisicoes_de_onibus_por_mes(
    id_aquisicao_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_onibus INTEGER,
    novo_ou_usado BOOLEAN
);

-- SPE2 => OTTRANS
INSERT INTO aquisicoes_de_onibus_por_mes(id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
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
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS frota_operante(
    id_frota_operante_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_operante_de_onibus INTEGER
);

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

CREATE TABLE IF NOT EXISTS frota_total(
    id_frota_total_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_total_de_onibus INTEGER
);

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
ON CONFLICT DO NOTHING;

-- PAGINA 38 DE 98 DO ANUARIO 2022
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
ON CONFLICT DO NOTHING;