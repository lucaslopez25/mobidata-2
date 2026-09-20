CREATE TABLE IF NOT EXISTS tarifa_preco_stco (
    ano INT,
    valor DECIMAL(10, 2),
    data_alteracao DATE
);

TRUNCATE TABLE tarifa_preco_stco RESTART IDENTITY CASCADE;

INSERT INTO tarifa_preco_stco (ano, valor, data_alteracao) VALUES
(2015, 3.00, '2015-02-01'),
(2016, 3.00, '2015-02-01'),
(2017, 3.60, '2017-02-01'),
(2018, 3.60, '2017-02-01'),
(2019, 4.00, '2019-02-04'),
(2020, 4.00, '2019-02-04'),
(2021, 4.40, '2021-04-26'),
(2022, 4.40, '2021-04-26'),
(2023, 5.20, '2023-11-13'),
(2024, 5.20, '2023-11-13')
ON CONFLICT DO NOTHING;