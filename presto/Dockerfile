FROM ahanaio/prestodb-sandbox

COPY etc/cassandra.properties /opt/presto-server/etc/catalog/cassandra.properties
COPY etc/config.properties /opt/presto-server/etc/config.properties

RUN /opt/presto-server/bin/launcher stop

ENTRYPOINT /opt/presto-server/bin/launcher run