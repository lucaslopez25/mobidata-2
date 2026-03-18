# mobidata-2
Se mapeando:
A pasta raíz onde estarão todos os arquivos django é 'mobidata2-app'
O projeto django tem como nome 'mobidata2project'

Como exportar os requirements?
Use 'py -m pip freeze > requirements.txt'

Como executar o projeto? Apenas inicie o comando 'docker compose up' no seu terminal favorito com o docker ativado no seu computador. Note que no docker compose existe um banco de dados. Popule esse banco procurando o arquivo no caminho docker/sql/tudo.sql, basta copiar, abrir uma query no SGBD, colar e executar a query para popular o banco.