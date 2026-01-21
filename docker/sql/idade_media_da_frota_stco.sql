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