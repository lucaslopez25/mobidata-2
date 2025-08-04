INSERT INTO aquisicoes_de_onibus_por_mes(
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
ON CONFLICT DO NOTHING;