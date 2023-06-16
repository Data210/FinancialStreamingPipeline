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
          image = "ethanjolly/fin_grafana"
          port {
            container_port = 3000
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
    type = "NodePort"
    port {
      node_port   = 30005
      port        = 3000
      target_port = 3000
    }
    selector = {
      app = "grafana-app"
    }
  }
}
