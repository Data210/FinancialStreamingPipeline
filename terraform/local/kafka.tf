resource "kubernetes_manifest" "deployment_kafka_app" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "kafka-app"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "kafka-app"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "kafka-app"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "FINNHUB_API_KEY"
                  "value" = var.finnhub_api_key
                },
                {
                  "name" = "KAFKA_ADVERTISED_PORT"
                  "value" = var.KAFKA_ADVERTISED_PORT
                },
                {
                  "name" = "KAFKA_ADVERTISED_HOST_NAME"
                  "value" = "kafkabroker"
                },
                {
                  "name" = "KAFKA_ZOOKEEPER_CONNECT"
                  "value" = "zookeeper:${var.ZOOKEEPER_CLIENT_PORT}"
                },
                {
                  "name" = "KAFKA_BROKER_ID"
                  "value" = var.KAFKA_BROKER_ID
                },
                {
                  "name" = "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP"
                  "value" = "PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
                },
                {
                  "name" = "KAFKA_CREATE_TOPICS"
                  "value" = var.KAFKA_CREATE_TOPICS
                },
                {
                  "name" = "KAFKA_LISTENERS"
                  "value" = "PLAINTEXT://kafkabroker:${var.KAFKA_ADVERTISED_PORT},PLAINTEXT_HOST://0.0.0.0:${var.KAFKA_EXTERNAL_PORT}"
                },
                {
                  "name" = "KAFKA_ADVERTISED_LISTENERS"
                  "value" = "PLAINTEXT://kafkabroker:${var.KAFKA_ADVERTISED_PORT},PLAINTEXT_HOST://localhost:${var.KAFKA_EXTERNAL_PORT}"
                },
              ]
              "image" = var.KAFKA_IMAGE
              "name" = "kafka"
              "ports" = [
                {
                  "containerPort" = var.KAFKA_EXTERNAL_PORT
                },
                {
                  "containerPort" = var.KAFKA_ADVERTISED_PORT
                },
              ]
            },
          ]
          "hostname" = "kafkabroker"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_kafkabroker" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "default"
      "labels" = {
        "name" = "kafkabroker"
      }
      "name" = "kafkabroker"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "kafka-port-websocket"
          "port" = var.KAFKA_ADVERTISED_PORT
          "protocol" = "TCP"
          "targetPort" = var.KAFKA_ADVERTISED_PORT
        },
      ]
      "selector" = {
        "app" = "kafka-app"
      }
    }
  }
}