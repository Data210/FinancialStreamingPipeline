resource "kubernetes_deployment" "deployment_cassandra_app" {
  metadata{
    name = "cassandra-app"
    namespace = "default"
  }
  spec{
    replicas = 1
    selector {
      match_labels = {
        app = "cassandra-app"
      }
    }
    template{
      metadata{
        labels = {
          app = "cassandra-app"
        }
      }
      spec{
        container{
            image = "ethanjolly/fin_cassandra"
            name = "cassandra-app"
            port{
                container_port = 9042
            }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_cassandra" {
  metadata{
    name = "cassandra"
    namespace = "default"
  }
  spec{
    port{
        port = 9042
        target_port = 9042
      }
    selector = {
      app = "cassandra-app"
    }
  }
}