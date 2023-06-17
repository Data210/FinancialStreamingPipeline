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
              "image" = var.GRAFANA_IMAGE
              "name" = "grafana-app"
              "ports" = [
                {
                  "containerPort" = var.GRAFANA_PORT
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
          "nodePort" = var.GRAFANA_NODEPORT
          "port" = var.GRAFANA_PORT
          "targetPort" = var.GRAFANA_PORT
        },
      ]
      "selector" = {
        "app" = "grafana-app"
      }
      "type" = "NodePort"
    }
  }
}