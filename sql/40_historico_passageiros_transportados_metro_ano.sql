CREATE TABLE IF NOT EXISTS historico_passageiros_transportados_metro_ano (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    passageiros FLOAT
);

TRUNCATE TABLE historico_passageiros_transportados_metro_ano RESTART IDENTITY CASCADE;

INSERT INTO historico_passageiros_transportados_metro_ano(ano, passageiros) VALUES
(2024, 117559289),
(2023, 101684054),
(2022, 94467065),
(2021, 72411815),
(2020, 62010484),
(2019, 107431208),
(2018, 91730164),
(2017, 41989575),
(2016, 11001753),
(2015, 10523501)
ON CONFLICT DO NOTHING;