apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana-app
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana-app
  template:
    metadata:
      labels:
        app: grafana-app
    spec:
      containers:
      - name: grafana-app
        image: ethanjolly/fin_grafana
        ports:
        - containerPort: 3000
---
apiVersion: v1
kind: Service
metadata:
  name: grafana
  namespace: default
spec:
  type: NodePort
  selector:
    app: grafana-app
  ports:
  - port: 3000
    targetPort: 3000
    nodePort: 30005