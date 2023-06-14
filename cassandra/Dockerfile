FROM cassandra:latest
COPY setup.cql /cassandra-setup/setup.cql
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]