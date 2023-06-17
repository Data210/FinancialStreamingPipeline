resource "kubernetes_manifest" "deployment_zookeeper_deploy" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "default"
      "name" = "zookeeper-deploy"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "zookeeper-1"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "zookeeper-1"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "ZOOKEEPER_CLIENT_PORT"
                  "value" = var.ZOOKEEPER_CLIENT_PORT
                },
                {
                  "name" = "ZOOKEEPER_TICK_TIME"
                  "value" = var.ZOOKEEPER_TICK_TIME
                },
                {
                  "name" = "ZOOKEEPER_SERVER_1"
                  "value" = var.ZOOKEEPER_SERVER_1
                },
              ]
              "image" = var.ZOOKEEPER_IMAGE
              "name" = "zookeeper"
              "ports" = [
                {
                  "containerPort" = var.ZOOKEEPER_CLIENT_PORT
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_zookeeper" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "default"
      "labels" = {
        "app" = "zookeeper-1"
      }
      "name" = "zookeeper"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "client"
          "port" = var.ZOOKEEPER_CLIENT_PORT
          "protocol" = "TCP"
        },
      ]
      "selector" = {
        "app" = "zookeeper-1"
      }
    }
  }
}