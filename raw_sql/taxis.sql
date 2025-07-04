-- PAGINA 58 DE 98 DO ANUARIO 2022
-- EVOLUÇÃO DA FROTA DE TÁXIS
CREATE TABLE frota_de_taxis (
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

-- PAGINA 59 DE 98 DO ANUARIO 2022
-- DISTRIBUIÇÃO DA FROTA DE TAXIS POR SERVIÇO
CREATE TABLE distribuicao_taxis_por_tipo_de_servico (
    id_distribuicao_taxis_por_tipo_de_servico SERIAL PRIMARY KEY,
    ano INTEGER,
    tipo_de_servico TEXT,
    entidade_operadora TEXT,
    total_de_veiculos INTEGER
);

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
(2022, 12, 'OUTROS / NI', 'OUTROS / NI', 74);