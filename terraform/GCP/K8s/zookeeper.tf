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
                value = "2181"
            }
            env{
                name = "ZOOKEEPER_TICK_TIME"
                value = "2000"
            }
            env{
                name = "ZOOKEEPER_SERVER_1"
                value = "zookeeper"
            }
            image = "digitalwonderland/zookeeper"
            name = "zookeeper"
            port{
                container_port = 2181
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
        port = 2181
        protocol = "TCP"
      }
    selector = {
      app = "zookeeper-1"
    }
  }
}
