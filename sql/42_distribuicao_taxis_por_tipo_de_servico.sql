CREATE TABLE IF NOT EXISTS distribuicao_taxis_por_tipo_de_servico (
    id_distribuicao_taxis_por_tipo_de_servico SERIAL PRIMARY KEY,
    ano INTEGER,
    tipo_de_servico TEXT,
    entidade_operadora TEXT,
    total_de_veiculos INTEGER
);

TRUNCATE TABLE distribuicao_taxis_por_tipo_de_servico RESTART IDENTITY CASCADE;

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
(2022, 'Moto-táxis', 'Moto-táxis', 1196)
ON CONFLICT DO NOTHING;