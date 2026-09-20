# Mobidata 2

![Django](https://img.shields.io/badge/Django-5.1.6-092E20?style=for-the-badge&logo=django)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17-4169E1?style=for-the-badge&logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-Enabled-2496ED?style=for-the-badge&logo=docker)

O **Mobidata** é uma plataforma de dados abertos para análise histórica da mobilidade urbana na cidade de Salvador-BA. O projeto agrega os dados e os organiza tornando a exploração mais fácil e acessível aos cidadãos e ao público comum.


## Dados disponíveis

- **Ônibus Municipal**: Idade e Renovação da Frota, Tamanho da Frota, Oferta de Linhas e Ônibus, Passageiros, Oferta de Viagens e Quilometragem Percorrida, Climatização da Frota, Receitas e Custos (dados referentes a STCO e BRT).
- **Metrô**: Histórico de Passageiros ao longo dos anos.
- **STEC (Sistema de Transporte Especial Complementar)**: Histórico de Passageiros ao longo dos anos.
- **Mobilidade Ativa**: Mapa da Rede Cicloviária de Salvador fornecido pelo CICLOMAPA.
- **Outros Indicadores**: Segurança Pública e Mobilidade, como índice de assaltos a ônibus.


## Tecnologias Utilizadas

- **Backend / Dashboard**: Python, Django, Pandas, Plotly.
- **Banco de Dados**: PostgreSQL, pgAdmin 4.
- **Infraestrutura**: Docker & Docker Compose.

## Como Executar

- No terminal:

```
git clone https://github.com/lucaslopez25/mobidata-2
cd mobidata-2
docker compose up -d
```

## Utilidades

- Para exportar dependências

```
docker exec -it mobidata_app pip freeze > requirements.txt
```

- Para acessar o contâiner e executar comandos

```
docker exec -it mobidata_app bash
```