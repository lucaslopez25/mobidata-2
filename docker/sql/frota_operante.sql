CREATE TABLE IF NOT EXISTS frota_operante(
    id_frota_operante_mes SERIAL PRIMARY KEY,
    id_concessionaria VARCHAR(10) REFERENCES concessionarias(id_concessionaria),
    mes INTEGER,
    ano INTEGER,
    qtd_operante_de_onibus INTEGER
);

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2024, 882),
('SPE2', 2, 2024, 884),
('SPE2', 3, 2024, 948),
('SPE2', 4, 2024, 950),
('SPE2', 5, 2024, 952),
('SPE2', 6, 2024, 949),
('SPE2', 7, 2024, 950),
('SPE2', 8, 2024, 962),
('SPE2', 9, 2024, 967),
('SPE2', 10, 2024, 967),
('SPE2', 11, 2024, 967),
('SPE2', 12, 2024, 945),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2024, 646),
('SPE3', 2, 2024, 644),
('SPE3', 3, 2024, 692),
('SPE3', 4, 2024, 693),
('SPE3', 5, 2024, 693),
('SPE3', 6, 2024, 687),
('SPE3', 7, 2024, 687),
('SPE3', 8, 2024, 695),
('SPE3', 9, 2024, 702),
('SPE3', 10, 2024, 703),
('SPE3', 11, 2024, 703),
('SPE3', 12, 2024, 685)
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2023, 887),
('SPE2', 2, 2023, 892),
('SPE2', 3, 2023, 968),
('SPE2', 4, 2023, 965),
('SPE2', 5, 2023, 965),
('SPE2', 6, 2023, 951),
('SPE2', 7, 2023, 965),
('SPE2', 8, 2023, 966),
('SPE2', 9, 2023, 967),
('SPE2', 10, 2023, 962),
('SPE2', 11, 2023, 959),
('SPE2', 12, 2023, 944),
-- SPE3 => PLATAFORMA
('SPE3', 1, 2023, 652),
('SPE3', 2, 2023, 654),
('SPE3', 3, 2023, 704),
('SPE3', 4, 2023, 706),
('SPE3', 5, 2023, 708),
('SPE3', 6, 2023, 696),
('SPE3', 7, 2023, 709),
('SPE3', 8, 2023, 710),
('SPE3', 9, 2023, 709),
('SPE3', 10, 2023, 703),
('SPE3', 11, 2023, 702),
('SPE3', 12, 2023, 690)
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- SPE2 => OTTRANS
('SPE2', 1, 2022, 884), -- Janeiro
('SPE2', 2, 2022, 934), -- Fevereiro
('SPE2', 3, 2022, 948), -- Março
('SPE2', 4, 2022, 958), -- Abril
('SPE2', 5, 2022, 964), -- Maio
('SPE2', 6, 2022, 961), -- Junho
('SPE2', 7, 2022, 962), -- Julho
('SPE2', 8, 2022, 969), -- Agosto
('SPE2', 9, 2022, 969), -- Setembro
('SPE2', 10, 2022, 970), -- Outubro
('SPE2', 11, 2022, 976), -- Novembro
('SPE2', 12, 2022, 942), -- Dezembro
-- SPE3 => PLATAFORMA
('SPE3', 1, 2022, 612), -- Janeiro
('SPE3', 2, 2022, 684), -- Fevereiro
('SPE3', 3, 2022, 689), -- Março
('SPE3', 4, 2022, 693), -- Abril
('SPE3', 5, 2022, 697), -- Maio
('SPE3', 6, 2022, 696), -- Junho
('SPE3', 7, 2022, 698), -- Julho
('SPE3', 8, 2022, 704), -- Agosto
('SPE3', 9, 2022, 709), -- Setembro
('SPE3', 10, 2022, 709), -- Outubro
('SPE3', 11, 2022, 710), -- Novembro
('SPE3', 12, 2022, 688) -- Dezembro
ON CONFLICT DO NOTHING;

INSERT INTO frota_operante(id_concessionaria, mes, ano, qtd_operante_de_onibus) VALUES
-- FROTA OPERANTE DE 2021
-- VER PÁGINA 21 DO ANUÁRIO DE 2021
-- SPE1 => SALVADOR NORTE
('SPE1', 1, 2021, 444), -- Janeiro
('SPE1', 2, 2021, 445), -- Fevereiro
('SPE1', 3, 2021, 412), -- Março
('SPE1', 4, 2021, 329), -- Abril
('SPE1', 5, 2021, 333), -- Maio
('SPE1', 6, 2021, 237), -- Junho
('SPE1', 7, 2021, 235), -- Julho
('SPE1', 8, 2021, 199), -- Agosto
('SPE1', 9, 2021, 145), -- Setembro
('SPE1', 10, 2021, 0), -- Outubro
('SPE1', 11, 2021, 0), -- Novembro
('SPE1', 12, 2021, 0), -- Dezembro
-- SPE2 => OTTRANS
('SPE2', 1, 2021, 803), -- Janeiro
('SPE2', 2, 2021, 787), -- Fevereiro
('SPE2', 3, 2021, 695), -- Março
('SPE2', 4, 2021, 774), -- Abril
('SPE2', 5, 2021, 793), -- Maio
('SPE2', 6, 2021, 804), -- Junho
('SPE2', 7, 2021, 802), -- Julho
('SPE2', 8, 2021, 809), -- Agosto
('SPE2', 9, 2021, 822), -- Setembro
('SPE2', 10, 2021, 908), -- Outubro
('SPE2', 11, 2021, 931), -- Novembro
('SPE2', 12, 2021, 928), -- Dezembro
-- SPE3 => PLATAFORMA
('SPE3', 1, 2021, 619), -- Janeiro
('SPE3', 2, 2021, 604), -- Fevereiro
('SPE3', 3, 2021, 490), -- Março
('SPE3', 4, 2021, 562), -- Abril
('SPE3', 5, 2021, 571), -- Maio
('SPE3', 6, 2021, 584), -- Junho
('SPE3', 7, 2021, 595), -- Julho
('SPE3', 8, 2021, 599), -- Agosto
('SPE3', 9, 2021, 671), -- Setembro
('SPE3', 10, 2021, 684), -- Outubro
('SPE3', 11, 2021, 683), -- Novembro
('SPE3', 12, 2021, 683) -- Dezembro
ON CONFLICT DO NOTHING;