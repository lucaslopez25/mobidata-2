CREATE TABLE IF NOT EXISTS historico_passageiros_transportados_metro_mes (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    mes INTEGER,
    passageiros FLOAT
);

-- pg. 107 de 122, anuário 2024
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2024, 1, 8867882), 
(2024, 2, 8737633), 
(2024, 3, 9679775), 
(2024, 4, 10259653), 
(2024, 5, 10064494), 
(2024, 6, 9268785), 
(2024, 7, 10072467), 
(2024, 8, 10717066), 
(2024, 9, 10087125), 
(2024, 10, 10424478), 
(2024, 11, 9731113), 
(2024, 12, 9648818)
ON CONFLICT DO NOTHING;

-- pg. 108 de 120, anuário 2023
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2023, 1, 7952865), 
(2023, 2, 7336406), 
(2023, 3, 9021576), 
(2023, 4, 7957512), 
(2023, 5, 9017200), 
(2023, 6, 8212456), 
(2023, 7, 8545572), 
(2023, 8, 9167134), 
(2023, 9, 8548910), 
(2023, 10, 8894551), 
(2023, 11, 8809053), 
(2023, 12, 8220819)
ON CONFLICT DO NOTHING;

-- pg. 108 de 120, anuário 2023
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2023, 1, 7952865), 
(2023, 2, 7336406), 
(2023, 3, 9021576), 
(2023, 4, 7957512), 
(2023, 5, 9017200), 
(2023, 6, 8212456), 
(2023, 7, 8545572), 
(2023, 8, 9167134), 
(2023, 9, 8548910), 
(2023, 10, 8894551), 
(2023, 11, 8809053), 
(2023, 12, 8220819)
ON CONFLICT DO NOTHING;

-- pg. 87 de 98, anuário 2022
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2022, 1, 6492143), 
(2022, 2, 6608119), 
(2022, 3, 7967875), 
(2022, 4, 7359865), 
(2022, 5, 8503839), 
(2022, 6, 7335367), 
(2022, 7, 8002317), 
(2022, 8, 9006797), 
(2022, 9, 8540980), 
(2022, 10, 8418408), 
(2022, 11, 8168878), 
(2022, 12, 8062477)
ON CONFLICT DO NOTHING;

-- pg. 83 de 94, anuário 2021
-- dados corrompidos quando se copia, foi feita cópia à mão.
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2021, 1, 5676174), 
(2021, 2, 5229476), 
(2021, 3, 4186679), 
(2021, 4, 4840832), 
(2021, 5, 5792425), 
(2021, 6, 5517453), 
(2021, 7, 6234539), 
(2021, 8, 6772156), 
(2021, 9, 6746322), 
(2021, 10, 6904522), 
(2021, 11, 7141218), 
(2021, 12, 7370029)
ON CONFLICT DO NOTHING;

-- pg 69 de 79, anuário 2020
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2020, 1, 8630517), 
(2020, 2, 8391299), 
(2020, 3, 6566546), 
(2020, 4, 2364784), 
(2020, 5, 2448648), 
(2020, 6, 2927139), 
(2020, 7, 3470222), 
(2020, 8, 4351630), 
(2020, 9, 5107306), 
(2020, 10, 5611245), 
(2020, 11, 5808845), 
(2020, 12, 6332303)
ON CONFLICT DO NOTHING;

-- pg 89 de 99, anuário 2019
INSERT INTO historico_passageiros_transportados_metro_mes(ano, mes, passageiros) VALUES
(2019, 1, 8045059), 
(2019, 2, 8239263), 
(2019, 3, 8513151), 
(2019, 4, 8880748), 
(2019, 5, 9273996), 
(2019, 6, 7801605), 
(2019, 7, 8835366), 
(2019, 8, 9789332), 
(2019, 9, 9426206), 
(2019, 10, 9942315), 
(2019, 11, 9395569), 
(2019, 12, 9288598)
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS historico_passageiros_transportados_metro_ano (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    passageiros FLOAT
);

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