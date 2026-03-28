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