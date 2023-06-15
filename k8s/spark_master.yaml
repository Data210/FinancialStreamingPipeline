apiVersion: apps/v1
kind: Deployment
metadata:
  name: spark-master
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spark-master
  template:
    metadata:
      labels:
        app: spark-master
    spec:
      containers:
      - name: spark-master
        image: docker.io/bitnami/spark:3.4
        ports:
        - containerPort: 7077
        - containerPort: 8080
        env:
        - name: SPARK_MODE
          value: master
        - name: SPARK_RPC_AUTHENTICATION_ENABLED
          value: "no"
        - name: SPARK_RPC_ENCRYPTION_ENABLED
          value: "no"
        - name: SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED
          value: "no"
        - name: SPARK_SSL_ENABLED
          value: "no"
        - name: SPARK_USER
          value: spark
      - name: spark-worker
        image: docker.io/bitnami/spark:3.4
        env:
        - name: SPARK_MODE
          value: worker
        - name: SPARK_MASTER_URL
          value: spark://spark-master-service:7077
        - name: SPARK_WORKER_MEMORY
          value: 1G
        - name: SPARK_WORKER_CORES
          value: "1"
        - name: SPARK_RPC_AUTHENTICATION_ENABLED
          value: "no"
        - name: SPARK_RPC_ENCRYPTION_ENABLED
          value: "no"
        - name: SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED
          value: "no"
        - name: SPARK_SSL_ENABLED
          value: "no"
        - name: SPARK_USER
          value: spark
      - name: pyspark
        image: ethanjolly/fin_pyspark
        env:
        - name: SPARK_MASTER_HOSTNAME
          value: spark-master-service
        ports:
        - containerPort: 9192
---
apiVersion: v1
kind: Service
metadata:
  name: spark-master-service
  namespace: default
spec:
  selector:
    app: spark-master
  ports:
  - port: 7077
    targetPort: 7077
    name: master-port
  - port: 9192
    targetPort: 9192
    name: pyspark-port
  - port: 8080
    targetPort: 8080
    name: web-ui

# apiVersion: v1
# kind: Service
# metadata:
#   name: spark-web-ui
#   namespace: default
# spec:
#   type: NodePort
#   selector:
#     app: spark-master
#   ports:
#   - port: 8080
#     targetPort: 8080
#     nodePort: 30002
#     name: web-ui