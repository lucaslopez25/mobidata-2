CREATE TABLE IF NOT EXISTS idade_media_da_frota_de_taxis (
    id_idade_media_taxis SERIAL PRIMARY KEY,
    ano INTEGER,
    idade_media FLOAT
    -- A IDADE MÉDIA É EM ANOS!
);

TRUNCATE TABLE idade_media_da_frota_de_taxis RESTART IDENTITY CASCADE;

INSERT INTO idade_media_da_frota_de_taxis (ano, idade_media) VALUES
-- PARA 2022, VER RODAPÉ DA PÁGINA 63 DE 98 DO ANUÁRIO DE 2022
(2022, 6.23)
ON CONFLICT DO NOTHING;