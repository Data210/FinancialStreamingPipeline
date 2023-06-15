apiVersion: apps/v1
kind: Deployment
metadata:
  name: cassandra-app
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cassandra-app
  template:
    metadata:
      labels:
        app: cassandra-app
    spec:
      containers:
      - name: cassandra-app
        image: ethanjolly/fin_cassandra
        ports:
        - containerPort: 9042
---
apiVersion: v1
kind: Service
metadata:
  name: cassandra
  namespace: default
spec:
  selector:
    app: cassandra-app
  ports:
  - port: 9042
    targetPort: 9042