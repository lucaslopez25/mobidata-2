CREATE TABLE ascensores_urbanos (
    id VARCHAR(4) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_de_inauguracao DATE,
    horario_operacao TEXT,
    quantidade_bondes INTEGER,
    capacidade_por_bonde INTEGER,
    observacoes TEXT
);

-- Formato da data é YYYY-MM-DD

INSERT INTO ascensores_urbanos(id, nome, data_de_inauguracao, horario_operacao, quantidade_bondes, capacidade_por_bonde, observacoes) VALUES
('gonc', 'Plano Inclinado Gonçalves', '1889-01-01', 'Dias úteis: 08:00 às 18:00 | Sábados, domingos e feriados: não opera', 2, 15, 'Funicular histórico'),
('pilc', 'Plano Inclinado Liberdade-Calçada', '1981-03-13', 'Dias úteis: 06:00 às 18:00 | Sábados: 07:00 às 13:00 | Domingos e feriados: não opera', 2, 15, 'N/A'),
('lcrd', 'Elevador Lacerda', '1873-12-08', 'Dias úteis: 07:00 às 22:00 | Sábados, domingos e feriados: 07:00 às 19:00', 4, 20, 'N/A'),
('pilr', 'Plano Inclinado Pilar', '1889-01-01', 'Dias úteis: 07:00 às 17:00 | Sábados, domingos e feriados: não opera', 2, 12, 'Reinagurado em 29/03/2006'),
('tabo', 'Elevador do Taboão', '1896-06-19', 'Dias úteis: 08:00 às 17:00 | Sábados, domingos e feriados: não opera', 2, 13, 'Reinagurado em 30/09/2021');