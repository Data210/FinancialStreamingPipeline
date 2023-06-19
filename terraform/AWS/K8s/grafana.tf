resource "kubernetes_deployment" "deployment_grafana_app" {
  metadata {
    name      = "grafana-app"
    namespace = "default"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "grafana-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "grafana-app"
        }
      }
      spec {
        container {
          name  = "grafana-app"
          image = var.GRAFANA_IMAGE
          port {
            container_port = var.GRAFANA_PORT
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_grafana" {
  metadata {
    name      = "grafana"
    namespace = "default"
  }
  spec {
    type = "LoadBalancer"
    port {
      node_port = var.GRAFANA_NODEPORT
      port = var.GRAFANA_PORT
      target_port = var.GRAFANA_PORT
    }
    selector = {
      app = "grafana-app"
    }
  }
}
