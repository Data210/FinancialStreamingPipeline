FROM grafana/grafana-oss

RUN grafana-cli plugins install hadesarchitect-cassandra-datasource
USER root
RUN sed -i 's/;min_refresh_interval = 5s/min_refresh_interval = 1s/g' /etc/grafana/grafana.ini
COPY ./provisioning /etc/grafana/provisioning
COPY ./dashboards /var/lib/grafana/dashboards