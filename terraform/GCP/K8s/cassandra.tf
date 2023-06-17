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
            image = var.CASSANDRA_IMAGE
            name = "cassandra-app"
            port{
                container_port = var.CASSANDRA_PORT
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
        port = var.CASSANDRA_PORT
        target_port = var.CASSANDRA_PORT
      }
    selector = {
      app = "cassandra-app"
    }
  }
}