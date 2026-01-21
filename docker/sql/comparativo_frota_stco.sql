CREATE TABLE IF NOT EXISTS comparativo_frota_stco (
    ano INTEGER PRIMARY KEY,
    frota_operante INTEGER,
    frota_total INTEGER,
    idade_media NUMERIC(4,2),
    percentual_operante_total NUMERIC(5,2)
);

INSERT INTO comparativo_frota_stco(ano, frota_operante, frota_total, idade_media, percentual_operante_total) VALUES
-- ANUÁRIO 2024
-- pg. 50 de 122
(2012, 2479, 2811, 4.96, 88.00),
(2013, 2431, 2839, 4.64, 86.00),
(2014, 2401, 2863, 4.54, 84.00),
(2015, 2247, 2685, 3.61, 84.00),
(2016, 2317, 2588, 4.40, 90.00),
(2017, 2110, 2552, 5.38, 83.00),
(2018, 2068, 2401, 6.30, 86.00),
(2019, 2033, 2423, 6.53, 84.00),
(2020, 1853, 2256, 7.29, 82.00),
(2021, 1611, 1776, 7.39, 91.00),
(2022, 1630, 1789, 7.79, 91.00),
(2023, 1634, 1958, 8.05, 83.00),
(2024, 1630, 1921, 8.42, 85.00);