CREATE TABLE IF NOT EXISTS aquisicoes_de_onibus_por_mes(
    id_aquisicao_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_onibus INTEGER,
    novo_ou_usado BOOLEAN
);

TRUNCATE TABLE aquisicoes_de_onibus_por_mes RESTART IDENTITY CASCADE;

INSERT INTO aquisicoes_de_onibus_por_mes (id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
-- OTTRANS (SPE2) 2024
-- Página 52 de 122 Anuário 2024
-- Item 2.2.6 VEÍCULOS CADASTRADOS: NOVOS E USADOS
('SPE2', 4, 2024, 60, TRUE),
('SPE2', 7, 2024, 1, TRUE),
('SPE2', 8, 2024, 6, TRUE),
('SPE2', 9, 2024, 1, TRUE),
('SPE2', 10, 2024, 13, TRUE),

-- PLATAFORMA (SPE3) 2024
-- Página 52 de 122 Anuário 2024
-- Item 2.2.6 VEÍCULOS CADASTRADOS: NOVOS E USADOS
('SPE3', 4, 2024, 3, TRUE),
('SPE3', 8, 2024, 6, FALSE),
('SPE3', 12, 2024, 5, FALSE),

-- OTTRANS (SPE2) 2023
('SPE2', 2, 2023, 39, TRUE),
('SPE2', 3, 2023, 41, TRUE),
('SPE2', 4, 2023, 9, TRUE),
('SPE2', 10, 2023, 1, TRUE),
('SPE2', 11, 2023, 1, TRUE),

-- PLATAFORMA (SPE3)
('SPE3', 1, 2023, 9, TRUE),
('SPE3', 4, 2023, 15, TRUE),
('SPE3', 5, 2023, 30, TRUE),
('SPE3', 7, 2023, 20, TRUE),
('SPE3', 9, 2023, 5, TRUE),

-- OTTRANS (SPE2) 2022
('SPE2', 1, 2022, 25, TRUE),
('SPE2', 3, 2022, 20, TRUE),
('SPE3', 3, 2022, 20, TRUE),
('SPE2', 4, 2022, 7, TRUE),
('SPE2', 10, 2022, 9, TRUE),

-- PLATAFORMA (SPE3) 2022
('SPE3', 1, 2022, 10, TRUE),
('SPE3', 4, 2022, 17, TRUE),
('SPE3', 5, 2022, 1, FALSE),
('SPE3', 8, 2022, 6, FALSE),
('SPE3', 9, 2022, 2, FALSE),
('SPE3', 10, 2022, 1, FALSE),

-- CONSÓRCIO SALVADOR NORTE (CSN) (SPE1)
-- Observação: nessa época a CSN estava sob crise e era administrada diretamente pela prefeitura
-- Conferir https://www.correio24horas.com.br/salvador/prefeitura-rescinde-contrato-com-a-csn-e-assume-de-vez-operacao-dos-onibus-0321
-- Página 36 de 94 Anuário 2021
-- Item 2.2.5 VEÍCULOS CADASTRADOS: NOVOS E USADOS
-- N/A

-- OTTRANS (SPE2) 2021
-- Página 36 de 94 Anuário 2021
-- Item 2.2.5 VEÍCULOS CADASTRADOS: NOVOS E USADOS
-- id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado
('SPE2', 5, 2021, 1, FALSE),
('SPE2', 8, 2021, 1, FALSE),
('SPE2', 9, 2021, 43, FALSE),
('SPE2', 10, 2021, 40, TRUE),
('SPE2', 10, 2021, 64, FALSE),
('SPE2', 11, 2021, 1, FALSE),

-- PLATAFORMA (SPE3) 2021
-- Página 36 de 94 Anuário 2021
-- Item 2.2.5 VEÍCULOS CADASTRADOS: NOVOS E USADOS
-- id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado
('SPE3', 9, 2021, 50, FALSE),
('SPE3', 10, 2021, 30, TRUE)
ON CONFLICT DO NOTHING;

