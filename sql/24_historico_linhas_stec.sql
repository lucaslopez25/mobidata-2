CREATE TABLE IF NOT EXISTS historico_linhas_stec(
    id SERIAL PRIMARY KEY,
    ano INTEGER,
    qtd_linhas FLOAT
);

INSERT INTO historico_linhas_stec(ano, qtd_linhas) VALUES
-- ANUÁRIO 2024 PAGINA 98 DE 122
-- NÃO INFORMA MÊS, TABELA SERÁ DISCRIMINADA APENAS POR ANO!
(2024, 29);