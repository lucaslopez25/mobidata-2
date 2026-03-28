CREATE TABLE demanda_pax_ascensores (
    id_demanda SERIAL PRIMARY KEY,
    id_ascensor_urbano VARCHAR(4) REFERENCES ascensores_urbanos(id),
    mes INTEGER,
    ano INTEGER,
    qtd_pax INTEGER,
);

INSERT INTO demanda_pax_ascensores (id_ascensor_urbano, mes, ano, qtd_pax) VALUES
-- ANO 2024
-- Elevador Lacerda (LCRD)
-- Elevador Lacerda fechado para reforma desde 09/04/2024
('lcrd', 1, 2024, 188222),
('lcrd', 2, 2024, 223158),
('lcrd', 3, 2024, 82702),
('lcrd', 4, 2024, 70938),
('lcrd', 5, 2024, 0),
('lcrd', 6, 2024, 0),
('lcrd', 7, 2024, 0),
('lcrd', 8, 2024, 0),
('lcrd', 9, 2024, 0),
('lcrd', 10, 2024, 0),
('lcrd', 11, 2024, 0),
('lcrd', 12, 2024, 0),

-- Elevador do Taboão (TABO)
-- Dados de passageiros a partir de Julho (07)
('tabo', 7, 2024, 59917),
('tabo', 8, 2024, 49044),
('tabo', 9, 2024, 37886),
('tabo', 10, 2024, 54103),
('tabo', 11, 2024, 44624),
('tabo', 12, 2024, 42705),

-- Plano Inclinado Liberdade Calçada (PILC)
('pilc', 1, 2024, 108416),
('pilc', 2, 2024, 122010),
('pilc', 3, 2024, 97948),
('pilc', 4, 2024, 128651),
('pilc', 5, 2024, 134355),
('pilc', 6, 2024, 126979),
('pilc', 7, 2024, 128342),
('pilc', 8, 2024, 118932),
('pilc', 9, 2024, 111992),
('pilc', 10, 2024, 0),
('pilc', 11, 2024, 111143),
('pilc', 12, 2024, 119233),

-- Plano Inclinado Gonçalves (GONC)
('gonc', 1, 2024, 25471),
('gonc', 2, 2024, 19431),
('gonc', 3, 2024, 26477),
('gonc', 4, 2024, 72639),
('gonc', 5, 2024, 76730),
('gonc', 6, 2024, 117473),
('gonc', 7, 2024, 0),
('gonc', 8, 2024, 101966),
('gonc', 9, 2024, 98161),
('gonc', 10, 2024, 96843),
('gonc', 11, 2024, 104673),
('gonc', 12, 2024, 118441),

-- Plano Inclinado Pilar (PILR)
('pilr', 1, 2024, 9120),
('pilr', 2, 2024, 4585),
('pilr', 3, 2024, 5393),
('pilr', 4, 2024, 9711),
('pilr', 5, 2024, 5214),
('pilr', 6, 2024, 6711),
('pilr', 7, 2024, 0),
('pilr', 8, 2024, 11018),
('pilr', 9, 2024, 9409),
('pilr', 10, 2024, 8880),
('pilr', 11, 2024, 4560),
('pilr', 12, 2024, 9576);