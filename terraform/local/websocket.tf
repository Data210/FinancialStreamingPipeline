resource "kubernetes_deployment" "websocket-app"{
  metadata{
    name="websocket-test"
    namespace="default"
  }
  spec{
    replicas=1
    selector{
      match_labels{
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
        containers{
          name="websocket"
          image="ethanjolly/fin_websocket"
          env={
            name="FINNHUB_API_KEY"
            value="chup7ppr01qphnn2crmgchup7ppr01qphnn2crn0"
          }
        }
      }
    }
  }
}
---
apiVersion: v1
kind: Service
metadata:
  name: websocket-entrypoint
  namespace: default
spec:
  selector:
    app: websocket-test
  ports:
  - port: 8001
    targetPort: 8001