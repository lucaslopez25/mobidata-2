CREATE TABLE IF NOT EXISTS salario_minimo (
    id SERIAL PRIMARY KEY,
    ano INTEGER NOT NULL,
    data_ajuste DATE NOT NULL,
    valor_salario NUMERIC(10,2) NOT NULL,
    ato_legal VARCHAR(50) NOT NULL,
    percentual_ajuste NUMERIC(5,2) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_ano_data UNIQUE (ano, data_ajuste)
);

TRUNCATE TABLE salario_minimo RESTART IDENTITY CASCADE;

INSERT INTO salario_minimo (ano, data_ajuste, valor_salario, ato_legal, percentual_ajuste) VALUES
(2024, '2024-01-01', 1412.00, 'DECRETO 11.864/2023', 6.97),
(2023, '2023-05-01', 1320.00, 'Lei 14.663/2023', 1.38),
(2023, '2023-01-01', 1302.00, 'MP 1143/2022', 7.43),
(2022, '2022-01-01', 1212.00, 'Lei 14.358/2022', 10.18),
(2021, '2021-01-01', 1100.00, 'Lei 14.158/2021', 5.26),
(2020, '2020-02-01', 1045.00, 'Lei 14.013/2020', 0.58),
(2020, '2020-01-01', 1039.00, 'MP 916/2019', 4.11),
(2019, '2019-01-01', 998.00, 'Decreto 9.661/2019', 4.61),
(2018, '2018-01-01', 954.00, 'Decreto 9.255/2017', 1.81),
(2017, '2017-01-01', 937.00, 'Decreto 8.948/2016', 6.48),
(2016, '2016-01-01', 880.00, 'Decreto 8.618/2015', 11.68),
(2015, '2015-01-01', 788.00, 'Decreto 8.381/2014', 8.84)
ON CONFLICT DO NOTHING;