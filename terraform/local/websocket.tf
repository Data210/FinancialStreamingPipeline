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

resource "kubernetes_manifest" "service_websocket_entrypoint" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "websocket-entrypoint"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 8001
          "targetPort" = 8001
        },
      ]
      "selector" = {
        "app" = "websocket-test"
      }
    }
  }
}