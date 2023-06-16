resource "kubernetes_deployment" "websocket" {
  metadata {
    name = "websocket"
    namespace = "${var.namespace}"
    labels = {
      "k8s.service" = "websocket"
    }
  }

#   depends_on = [
#       "kubernetes_deployment.kafka_service",
#       "kubernetes_deployment.cassandra"
#   ]

  spec {
    replicas = 1

    selector {
      match_labels = {
        "k8s.service" = "websocket"
      }
    }

    template {
      metadata {
        labels = {
          "k8s.network/pipeline-network" = "true"

          "k8s.service" = "websocket"
        }
      }

      spec {
        container {
          name  = "websocket"
          image = "ethanjolly/fin_websocket"

          env_from {
            config_map_ref {
              name = "pipeline-config"
            }
          }

          env_from {
            secret_ref {
              name = "pipeline-secrets"
            }
          }

          image_pull_policy = "Never"
        }

        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "websocket" {
  metadata {
    name  = "websocket"
    namespace = "${var.namespace}"
    labels = {
      "k8s.service" = "websocket"
    }
  }

  depends_on = [
        kubernetes_deployment.websocket
  ]
  
  spec {
    port {
      name        = "8001"
      port        = 8001
      target_port = "8001"
    }

    selector = {
      "k8s.service" = "websocket"
    }

    cluster_ip = "None"
  }
}