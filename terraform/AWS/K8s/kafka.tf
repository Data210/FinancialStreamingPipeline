resource "kubernetes_deployment" "deployment_kafka_app" {
  metadata{
    name = "kafka-app"
    namespace = "default"
  }
  spec{
    replicas = 1
    selector{
      match_labels = {
        app = "kafka-app"
      }
    }
    template{
      metadata{
        labels = {
          app = "kafka-app"
        }
      }
      spec{
        container{
            env{
                name = "FINNHUB_API_KEY"
                value = var.finnhub_api_key
            }
            env{
              name = "KAFKA_ADVERTISED_PORT"
              value = var.KAFKA_ADVERTISED_PORT
            }
            env{
              name = "KAFKA_ADVERTISED_HOST_NAME"
              value = "kafkabroker"
            }
            env{
              name = "KAFKA_ZOOKEEPER_CONNECT"
              value = "zookeeper:${var.ZOOKEEPER_CLIENT_PORT}"
            }
            env{
              name = "KAFKA_BROKER_ID"
              value = var.KAFKA_BROKER_ID
            }
            env{
              name = "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP"
              value = "PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
            }
            env{
              name = "KAFKA_CREATE_TOPICS"
              value = var.KAFKA_CREATE_TOPICS
            }
            env{
              name = "KAFKA_LISTENERS"
              value = "PLAINTEXT://kafkabroker:${var.KAFKA_ADVERTISED_PORT},PLAINTEXT_HOST://0.0.0.0:${var.KAFKA_EXTERNAL_PORT}"
            }
            env{
              name = "KAFKA_ADVERTISED_LISTENERS"
              value = "PLAINTEXT://kafkabroker:${var.KAFKA_ADVERTISED_PORT},PLAINTEXT_HOST://localhost:${var.KAFKA_EXTERNAL_PORT}"
            }
            image = var.KAFKA_IMAGE
            name = "kafka"
            port{
              container_port = var.KAFKA_EXTERNAL_PORT
            }
            port{
              container_port = var.KAFKA_ADVERTISED_PORT
            }
          }
        hostname = "kafkabroker"
      }
    }
  }
}


resource "kubernetes_service" "service_kafkabroker" {
  metadata{
    namespace = "default"
    labels = {
      name = "kafkabroker"
    }
    name = "kafkabroker"
  }
  spec{
    port{
        name = "kafka-port-websocket"
        port = var.KAFKA_ADVERTISED_PORT
        protocol = "TCP"
        target_port = var.KAFKA_ADVERTISED_PORT
      }
    selector = {
      app = "kafka-app"
    }
  }
}
