resource "kubernetes_manifest" "deployment_grafana_app" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "grafana-app"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "grafana-app"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "grafana-app"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "ethanjolly/fin_grafana"
              "name" = "grafana-app"
              "ports" = [
                {
                  "containerPort" = 3000
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_grafana" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "grafana"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "nodePort" = 30005
          "port" = 3000
          "targetPort" = 3000
        },
      ]
      "selector" = {
        "app" = "grafana-app"
      }
      "type" = "NodePort"
    }
  }
}