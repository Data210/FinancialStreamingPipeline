resource "kubernetes_secret" "pipeline-secrets" {
  metadata {
    name      = "pipeline-secrets"
    namespace = "default"
  }

  # depends_on = [
  #   kubernetes_namespace.pipeline-namespace
  # ]

  data = {
    #IMPORTANT! while specifying custom password for Cassandra - remember to add password into grafana/dashboards/dashboard.json
    #file if you want to use custom one (or something else). https://community.grafana.com/t/dashboard-provisioning-with-variables/45516/9
    FINNHUB_API_KEY    = "chuq7epr01qruokjgcggchuq7epr01qruokjgch0" #insert token here
    CASSANDRA_USER     = ""                                          #insert user here
    CASSANDRA_PASSWORD = ""                                          #insert password here
  }

  type = "opaque"
}
