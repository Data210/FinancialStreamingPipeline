apiVersion: apps/v1
kind: Deployment
metadata:
  name: kafka-app
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kafka-app
  template:
    metadata:
      labels:
        app: kafka-app
    spec:
      hostname: kafkabroker
      containers:
      - name: kafka
        image: wurstmeister/kafka
        ports:
        - containerPort: 9092
        - containerPort: 29092
        env:
          - name: FINNHUB_API_KEY
            value: "chup7ppr01qphnn2crmgchup7ppr01qphnn2crn0"
          # - name: KAFKA_BROKER_ID
          #   value: "1"
          # - name: KAFKA_ZOOKEEPER_CONNECT
          #   value: "zookeeper:2181"
          # - name: KAFKA_ADVERTISED_LISTENERS
          #   value: "PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092"
          # - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
          #   value: "PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
          # - name: KAFKA_INTER_BROKER_LISTENER_NAME
          #   value: "PLAINTEXT"
          # - name: KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
          #   value: "1"
          # - name: KAFKA_LISTENERS
          #   value: "PLAINTEXT://0.0.0.0:29092,PLAINTEXT_HOST://0.0.0.0:9092"
          - name: KAFKA_ADVERTISED_PORT
            value: "29092"
          - name: KAFKA_ADVERTISED_HOST_NAME
            value: kafkabroker
          - name: KAFKA_ZOOKEEPER_CONNECT
            value: zookeeper:2181
          - name: KAFKA_BROKER_ID
            value: "1"
          - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
            value: "PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
          - name: KAFKA_CREATE_TOPICS
            value: trades:1:1
          - name: KAFKA_LISTENERS
            value: "PLAINTEXT://kafkabroker:29092,PLAINTEXT_HOST://0.0.0.0:9092"
          - name: KAFKA_ADVERTISED_LISTENERS
            value: "PLAINTEXT://kafkabroker:29092,PLAINTEXT_HOST://localhost:9092"
---
apiVersion: v1
kind: Service
metadata:
  name: kafkabroker
  labels:
    name: kafkabroker
spec:
  ports:
  # - port: 9092
  #   name: kafka-port
  #   protocol: TCP
  - port: 29092
    targetPort: 29092
    name: kafka-port-websocket
    protocol: TCP
  selector:
    app: kafka-app