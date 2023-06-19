variable "finnhub_api_key" {
  type = string
}

variable "websocket_port" {
  type = number
}

variable "ZOOKEEPER_CLIENT_PORT" {
  type = number
}

variable "ZOOKEEPER_TICK_TIME" {
  type = number
}

variable "ZOOKEEPER_SERVER_1" {
  type = string
}

variable "ZOOKEEPER_IMAGE" {
  type = string
}

variable "KAFKA_ADVERTISED_PORT" {
  type = number
}

variable "KAFKA_EXTERNAL_PORT" {
  type = number
}

variable "KAFKA_CREATE_TOPICS" {
  type = string
}

variable "KAFKA_BROKER_ID" {
  type = number
}

variable "KAFKA_IMAGE" {
  type = string
}

variable "SPARK_IMAGE" {
  type = string
}

variable "SPARK_USER" {
  type = string
}

variable "SPARK_MASTER_INTERNAL_PORT" {
  type = number
}

variable "SPARK_MASTER_EXTERNAL_PORT" {
  type = number
}

variable "SPARK_WORKER_CORES" {
  type = number
}

variable "SPARK_WORKER_MEMORY" {
  type = string
}

variable "SPARK_MASTER_HOSTNAME" {
  type = string
}

variable "PYSPARK_CLIENT_PORT" {
  type = number
}

variable "PYSPARK_IMAGE" {
  type = string
}

variable "CASSANDRA_IMAGE" {
  type = string
}

variable "CASSANDRA_PORT" {
  type = number
}

variable "GRAFANA_IMAGE" {
  type = string
}

variable "GRAFANA_PORT" {
  type = number
}

variable "GRAFANA_NODEPORT" {
  type = number
}