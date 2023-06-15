kind: Deployment
apiVersion: apps/v1
metadata:
  name: zookeeper-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: zookeeper-1
  template:
    metadata:
      labels:
        app: zookeeper-1
    spec:
      containers:
      - name: zookeeper
        image: digitalwonderland/zookeeper
        ports:
        - containerPort: 2181
        env:
        - name: ZOOKEEPER_CLIENT_PORT
          value: "2181"
        - name: ZOOKEEPER_TICK_TIME
          value: "2000"
        - name: ZOOKEEPER_SERVER_1
          value: zookeeper
---
apiVersion: v1
kind: Service
metadata:
  name: zookeeper
  labels:
    app: zookeeper-1
spec:
  ports:
  - name: client
    port: 2181
    protocol: TCP
  selector:
    app: zookeeper-1