-- pg. 53 de 122, anuário 2024
CREATE TABLE IF NOT EXISTS veiculos_novos_adquiridos_por_ano (
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    veiculos INTEGER
);

INSERT INTO veiculos_novos_adquiridos_por_ano(ano, veiculos) VALUES
(2001, 355),
(2002, 304),
(2003, 272),
(2004, 141),
(2005, 193),
(2006, 259),
(2007, 426),
(2008, 380),
(2009, 274),
(2010, 364),
(2011, 278),
(2012, 264),
(2013, 419),
(2014, 454),
(2015, 253),
(2016, 26),
(2017, 0),
(2018, 0),
(2019, 199),
(2020, 0),
(2021, 70),
(2022, 143),
(2023, 170),
(2024, 84)
ON CONFLICT DO NOTHING;