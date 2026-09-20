CREATE TABLE IF NOT EXISTS dados_stco (
    id SERIAL PRIMARY KEY,
    ano INT,
    passageiros_total BIGINT,
    passageiros_equivalente BIGINT,
    quilometragem_total DECIMAL(15, 2),
    frota_operante INT,
    viagens DECIMAL(10, 1),
    desempenho_operacional DECIMAL(5, 2),
    passageiros_por_viagem DECIMAL(10, 2),
    passageiros_por_veiculo DECIMAL(10, 2),
    kms_por_viagem DECIMAL(10, 2)
);

TRUNCATE TABLE dados_stco RESTART IDENTITY CASCADE;

INSERT INTO dados_stco (ano, passageiros_total, passageiros_equivalente, quilometragem_total, frota_operante, viagens, desempenho_operacional, passageiros_por_viagem, passageiros_por_veiculo, kms_por_viagem) VALUES
(2017, 403818811, 263026450, 168874361.17, 2110, 4234784.5, 87.08, 95.36, 15948.61, 39.88),
(2018, 432678744, 254778903, 160386559.81, 2068, 4234894.5, 85.50, 100.17, 17435.47, 37.87),
(2019, 420590723, 241396429, 155718163.55, 2093, 4145199.0, 85.71, 101.46, 17240.15, 37.57),
(2020, 238638367, 140077214, 108647284.32, 1853, 3198645.5, NULL, 74.61, 10731.94, 33.97),
(2021, 257512403, 148905018, 114708574.88, 1657, 3378552.0, 97.90, 76.22, 12950.73, 33.95),
(2022, 321124599, 179883898, 114966206.58, 1644, 3547772.5, 98.40, 90.52, 16277.61, 32.41),
(2023, 333356137, 177992973, 112475140.14, 1684, 3668109.0, 98.30, 90.93, 17001.03, 30.68),
(2024, 331970762, 172822359, 108539331.22, 1629, 3713886.5, 97.70, 89.39, 16982.34, 29.23)
ON CONFLICT DO NOTHING;