FROM postgres:17-alpine

COPY docker/init.sh /docker-entrypoint-initdb.d/init.sh
COPY docker/sql/ /scripts/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh