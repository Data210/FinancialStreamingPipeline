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
                  "value" = "2181"
                },
                {
                  "name" = "ZOOKEEPER_TICK_TIME"
                  "value" = "2000"
                },
                {
                  "name" = "ZOOKEEPER_SERVER_1"
                  "value" = "zookeeper"
                },
              ]
              "image" = "digitalwonderland/zookeeper"
              "name" = "zookeeper"
              "ports" = [
                {
                  "containerPort" = 2181
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
          "port" = 2181
          "protocol" = "TCP"
        },
      ]
      "selector" = {
        "app" = "zookeeper-1"
      }
    }
  }
}