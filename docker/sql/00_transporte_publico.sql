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
ON CONFLICT DO NOTHING;