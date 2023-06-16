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
                  "value" = "chup7ppr01qphnn2crmgchup7ppr01qphnn2crn0"
                },
                {
                  "name" = "KAFKA_ADVERTISED_PORT"
                  "value" = "29092"
                },
                {
                  "name" = "KAFKA_ADVERTISED_HOST_NAME"
                  "value" = "kafkabroker"
                },
                {
                  "name" = "KAFKA_ZOOKEEPER_CONNECT"
                  "value" = "zookeeper:2181"
                },
                {
                  "name" = "KAFKA_BROKER_ID"
                  "value" = "1"
                },
                {
                  "name" = "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP"
                  "value" = "PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
                },
                {
                  "name" = "KAFKA_CREATE_TOPICS"
                  "value" = "trades:1:1"
                },
                {
                  "name" = "KAFKA_LISTENERS"
                  "value" = "PLAINTEXT://kafkabroker:29092,PLAINTEXT_HOST://0.0.0.0:9092"
                },
                {
                  "name" = "KAFKA_ADVERTISED_LISTENERS"
                  "value" = "PLAINTEXT://kafkabroker:29092,PLAINTEXT_HOST://localhost:9092"
                },
              ]
              "image" = "wurstmeister/kafka"
              "name" = "kafka"
              "ports" = [
                {
                  "containerPort" = 9092
                },
                {
                  "containerPort" = 29092
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
          "port" = 29092
          "protocol" = "TCP"
          "targetPort" = 29092
        },
      ]
      "selector" = {
        "app" = "kafka-app"
      }
    }
  }
}