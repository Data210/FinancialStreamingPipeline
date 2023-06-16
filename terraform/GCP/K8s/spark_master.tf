resource "kubernetes_deployment" "deployment_spark_master" {
  metadata{
    name = "spark-master"
    namespace = "default"
  }
  spec{
    replicas = 1
    selector{
      match_labels = {
        app = "spark-master"
      }
    }
    template{
      metadata{
        labels = {
          app = "spark-master"
        }
      }
      spec{
        container{
            env{
                name = "SPARK_MODE"
                value = "master"
            }
            env{
              name = "SPARK_RPC_AUTHENTICATION_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_RPC_ENCRYPTION_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_SSL_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_USER"
              value = "spark"
            }
            image = "docker.io/bitnami/spark:3.4"
            name = "spark-master"
            port{
                container_port = 7077
            }
            port{
                container_port = 8080
            }
        }
        container{
            env{
                name = "SPARK_MODE"
                value = "worker"
            }
            env{
              name = "SPARK_MASTER_URL"
              value = "spark://spark-master-service:7077"
            }
            env{
              name = "SPARK_WORKER_MEMORY"
              value = "1G"
            }
            env{
              name = "SPARK_WORKER_CORES"
              value = "1"
            }
            env{
              name = "SPARK_RPC_AUTHENTICATION_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_RPC_ENCRYPTION_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_SSL_ENABLED"
              value = "no"
            }
            env{
              name = "SPARK_USER"
              value = "spark"
            }
            image = "docker.io/bitnami/spark:3.4"
            name = "spark-worker"
          }
        container{
            env{
              name = "SPARK_MASTER_HOSTNAME"
              value = "spark-master-service"
            }
            image = "ethanjolly/fin_pyspark"
            name = "pyspark"
            port{
              container_port = 9192
            }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_spark_master_service" {
  metadata{
    name = "spark-master-service"
    namespace = "default"
  }
  spec{
    port{
        name = "master-port"
        port = 7077
        target_port = 7077
      }
    port{
        name = "pyspark-port"
        port = 9192
        target_port = 9192
      }
    port{
        name = "web-ui"
        port = 8080
        target_port = 8080
      }
    selector = {
      app = "spark-master"
    }
  }
}