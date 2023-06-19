resource "kubernetes_deployment" "websocket-app"{
  metadata{
    name="websocket-test"
    namespace="default"
  }
  spec{
    replicas=1
    selector{
      match_labels={
        app="websocket-test"
      }
    }
    template{
      metadata{
        labels={
          app="websocket-test"
        }
      }
      spec{
        container{
          name="websocket"
          image="ethanjolly/fin_websocket"
          env{
            name="FINNHUB_API_KEY"
            value=var.finnhub_api_key
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_websocket_entrypoint" {
  metadata{
    name = "websocket-entrypoint"
    namespace = "default"
  }
  spec{
    port{
        port = var.websocket_port
        target_port = var.websocket_port
      }
    selector = {
      app = "websocket-test"
    }
  }
}