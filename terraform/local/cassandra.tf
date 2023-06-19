resource "kubernetes_manifest" "deployment_cassandra_app" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "cassandra-app"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "cassandra-app"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "cassandra-app"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = var.CASSANDRA_IMAGE
              "name" = "cassandra-app"
              "ports" = [
                {
                  "containerPort" = var.CASSANDRA_PORT
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_cassandra" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "cassandra"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port" = var.CASSANDRA_PORT
          "targetPort" = var.CASSANDRA_PORT
        },
      ]
      "selector" = {
        "app" = "cassandra-app"
      }
    }
  }
}