resource "kubernetes_deployment" "deployment_zookeeper_deploy" {
  metadata{
    namespace = "default"
    name = "zookeeper-deploy"
  }
  spec{
    replicas = 1
    selector{
      match_labels = {
        app = "zookeeper-1"
      }
    }
    template{
      metadata{
        labels = {
          app = "zookeeper-1"
        }
      }
      spec{
        container{
            env{
                name = "ZOOKEEPER_CLIENT_PORT"
                value = var.ZOOKEEPER_CLIENT_PORT
            }
            env{
                name = "ZOOKEEPER_TICK_TIME"
                value = var.ZOOKEEPER_TICK_TIME
            }
            env{
                name = "ZOOKEEPER_SERVER_1"
                value = var.ZOOKEEPER_SERVER_1
            }
            image = var.ZOOKEEPER_IMAGE
            name = "zookeeper"
            port{
                container_port = var.ZOOKEEPER_CLIENT_PORT
              }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_zookeeper" {
  metadata{
    namespace = "default"
    labels = {
      app = "zookeeper-1"
    }
    name = "zookeeper"
  }
  spec{
    port{
        name = "client"
        port = var.ZOOKEEPER_CLIENT_PORT
        protocol = "TCP"
      }
    selector = {
      app = "zookeeper-1"
    }
  }
}
