CREATE TABLE demanda_pax_stec(
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    mes INTEGER,
    pax_total BIGINT,
    pax_equivalente BIGINT,
    percentual_comparativo_equivalente_total NUMERIC(5,2)
);

INSERT INTO demanda_pax_stec(ano, mes, pax_total, pax_equivalente, percentual_comparativo_equivalente_total) VALUES
-- Página 98 de 122
(2024, 1, 1757495, 1074250, 61.00),
(2024, 2, 1616859, 971696, 60.00),
(2024, 3, 1789193, 1048976, 59.00),
(2024, 4, 1770425, 1042343, 59.00),
(2024, 5, 1767499, 1056325, 60.00),
(2024, 6, 1547370, 919613, 59.00),
(2024, 7, 1683329, 994107, 59.00),
(2024, 8, 1785940, 1037372, 58.00),
(2024, 9, 1766245, 1021779, 58.00),
(2024, 10, 1828322, 1071822, 59.00),
(2024, 11, 1690195, 996193, 59.00),
(2024, 12, 1721674, 1026182, 60.00);