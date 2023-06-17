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
              value = var.SPARK_USER
            }
            image = var.SPARK_IMAGE
            name = "spark-master"
            port{
                container_port = var.SPARK_MASTER_INTERNAL_PORT
            }
            port{
                container_port = var.SPARK_MASTER_EXTERNAL_PORT
            }
        }
        container{
            env{
                name = "SPARK_MODE"
                value = "worker"
            }
            env{
              name = "SPARK_MASTER_URL"
              value = "spark://${var.SPARK_MASTER_HOSTNAME}:${var.SPARK_MASTER_INTERNAL_PORT}"
            }
            env{
              name = "SPARK_WORKER_MEMORY"
              value = var.SPARK_WORKER_MEMORY
            }
            env{
              name = "SPARK_WORKER_CORES"
              value = var.SPARK_WORKER_CORES
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
              value = var.SPARK_USER
            }
            image = var.SPARK_IMAGE
            name = "spark-worker"
          }
        container{
            env{
              name = "SPARK_MASTER_HOSTNAME"
              value = var.SPARK_MASTER_HOSTNAME
            }
            image = var.PYSPARK_IMAGE
            name = "pyspark"
            port{
              container_port = var.PYSPARK_CLIENT_PORT
            }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_spark_master_service" {
  metadata{
    name = var.SPARK_MASTER_HOSTNAME
    namespace = "default"
  }
  spec{
    port{
        name = "master-port"
        port = var.SPARK_MASTER_INTERNAL_PORT
        target_port = var.SPARK_MASTER_INTERNAL_PORT
      }
    port{
        name = "pyspark-port"
        port = var.PYSPARK_CLIENT_PORT
        target_port = var.PYSPARK_CLIENT_PORT
      }
    port{
        name = "web-ui"
        port = var.SPARK_MASTER_EXTERNAL_PORT
        target_port = var.SPARK_MASTER_EXTERNAL_PORT
      }
    selector = {
      app = "spark-master"
    }
  }
}