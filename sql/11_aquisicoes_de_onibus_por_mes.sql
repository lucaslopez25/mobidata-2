CREATE TABLE IF NOT EXISTS aquisicoes_de_onibus_por_mes(
    id_aquisicao_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_onibus INTEGER,
    novo_ou_usado BOOLEAN
);

INSERT INTO aquisicoes_de_onibus_por_mes (id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
-- OTTRANS (SPE2)
('SPE2', 4, 2024, 60, TRUE),
('SPE2', 7, 2024, 1, TRUE),
('SPE2', 8, 2024, 6, TRUE),
('SPE2', 9, 2024, 1, TRUE),
('SPE2', 10, 2024, 13, TRUE),

-- PLATAFORMA (SPE3)
('SPE3', 4, 2024, 3, TRUE),
('SPE3', 8, 2024, 6, FALSE),
('SPE3', 12, 2024, 5, FALSE)
ON CONFLICT DO NOTHING;

INSERT INTO aquisicoes_de_onibus_por_mes (id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
-- OTTRANS (SPE2)
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
('SPE3', 9, 2023, 5, TRUE)
ON CONFLICT DO NOTHING;

INSERT INTO aquisicoes_de_onibus_por_mes (id_concessionaria, mes, ano, qtd_onibus, novo_ou_usado) VALUES
-- OTTRANS (SPE2)
('SPE2', 1, 2022, 25, TRUE),
('SPE2', 3, 2022, 20, TRUE),
('SPE3', 3, 2022, 20, TRUE),
('SPE2', 4, 2022, 7, TRUE),
('SPE2', 10, 2022, 9, TRUE),

-- PLATAFORMA (SPE3)
('SPE3', 1, 2022, 10, TRUE),
('SPE3', 4, 2022, 17, TRUE),
('SPE3', 5, 2022, 1, FALSE),
('SPE3', 8, 2022, 6, FALSE),
('SPE3', 9, 2022, 2, FALSE),
('SPE3', 10, 2022, 1, FALSE)
ON CONFLICT DO NOTHING;

