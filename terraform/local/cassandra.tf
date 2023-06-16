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
              "image" = "ethanjolly/fin_cassandra"
              "name" = "cassandra-app"
              "ports" = [
                {
                  "containerPort" = 9042
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
          "port" = 9042
          "targetPort" = 9042
        },
      ]
      "selector" = {
        "app" = "cassandra-app"
      }
    }
  }
}