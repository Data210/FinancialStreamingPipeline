data "kubernetes_service" "websocket" {
  depends_on = [kubernetes_service.websocket]
  metadata {
    name = "nginx"
  }
}

output "websocket_endpoint" {
    value = "http://${data.kubernetes_service.websocket.status.0.load_balancer.0.ingress.0.hostname}"
}