-- Porque esse arquivo existe? O unificador precisa colocar essas tabelas primeiro para orientar as demais tabelas.

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