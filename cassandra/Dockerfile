FROM cassandra:latest
COPY setup.cql /cassandra-setup/setup.cql
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

CMD /usr/local/bin/docker-entrypoint.sh