-- PAGINA 60 DE 98 DO ANUARIO 2022 ==== OBS FINAL DA PÁGINA, RODAPÉ
-- TÁXIS POR TIPO DE COMBUSTIVEL
CREATE TABLE IF NOT EXISTS taxis_por_combustivel (
    id_taxis_por_combustivel SERIAL PRIMARY KEY,
    ano INTEGER,
    tipo_combustivel TEXT,
    quantidade INTEGER
);

TRUNCATE TABLE taxis_por_combustivel RESTART IDENTITY CASCADE;

INSERT INTO taxis_por_combustivel (ano, tipo_combustivel, quantidade) VALUES
(2022, 'Álcool', 10),
(2022, 'Álcool/GNV', 21),
(2022, 'Álcool/Gasolina', 5371),
(2022, 'Álcool/Gasolina/GNV', 1260),
(2022, 'Gasolina/GNV', 17),
(2022, 'Gasolina', 36),
(2022, 'Gasolina/Álcool/Elétrico', 18),
(2022, 'Óleo Diesel', 1),
(2022, 'Não Informado', 202),
-- O TOTAL CONFERE COM O TOTAL DE TÁXIS NA PÁGINA 59

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
(2024, 'Não Informado', 0)
ON CONFLICT DO NOTHING;