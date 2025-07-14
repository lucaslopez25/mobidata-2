set -e

until pg_isready -U "$POSTGRES_USER" -d postgres; do
  sleep 1
done

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE dados_mobilidade;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=dados_mobilidade -f dados_operacionais.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=dados_mobilidade -f taxis.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname=dados_mobilidade -f transporte_publico.sql