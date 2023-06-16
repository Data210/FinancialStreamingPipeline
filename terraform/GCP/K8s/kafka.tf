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
                value = "chup7ppr01qphnn2crmgchup7ppr01qphnn2crn0"
            }
            env{
              name = "KAFKA_ADVERTISED_PORT"
              value = "29092"
            }
            env{
              name = "KAFKA_ADVERTISED_HOST_NAME"
              value = "kafkabroker"
            }
            env{
              name = "KAFKA_ZOOKEEPER_CONNECT"
              value = "zookeeper:2181"
            }
            env{
              name = "KAFKA_BROKER_ID"
              value = "1"
            }
            env{
              name = "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP"
              value = "PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
            }
            env{
              name = "KAFKA_CREATE_TOPICS"
              value = "trades:1:1"
            }
            env{
              name = "KAFKA_LISTENERS"
              value = "PLAINTEXT://kafkabroker:29092,PLAINTEXT_HOST://0.0.0.0:9092"
            }
            env{
              name = "KAFKA_ADVERTISED_LISTENERS"
              value = "PLAINTEXT://kafkabroker:29092,PLAINTEXT_HOST://localhost:9092"
            }
            image = "wurstmeister/kafka"
            name = "kafka"
            port{
              container_port = 9092
            }
            port{
              container_port = 29092
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
        port = 29092
        protocol = "TCP"
        target_port = 29092
      }
    selector = {
      app = "kafka-app"
    }
  }
}
