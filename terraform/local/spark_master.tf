resource "kubernetes_manifest" "deployment_spark_master" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "spark-master"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "spark-master"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "spark-master"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "SPARK_MODE"
                  "value" = "master"
                },
                {
                  "name" = "SPARK_RPC_AUTHENTICATION_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_RPC_ENCRYPTION_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_SSL_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_USER"
                  "value" = var.SPARK_USER
                },
              ]
              "image" = var.SPARK_IMAGE
              "name" = "spark-master"
              "ports" = [
                {
                  "containerPort" = var.SPARK_MASTER_INTERNAL_PORT
                },
                {
                  "containerPort" = var.SPARK_MASTER_EXTERNAL_PORT
                },
              ]
            },
            {
              "env" = [
                {
                  "name" = "SPARK_MODE"
                  "value" = "worker"
                },
                {
                  "name" = "SPARK_MASTER_URL"
                  "value" = "spark://${var.SPARK_MASTER_HOSTNAME}:${var.SPARK_MASTER_INTERNAL_PORT}"
                },
                {
                  "name" = "SPARK_WORKER_MEMORY"
                  "value" = var.SPARK_WORKER_MEMORY
                },
                {
                  "name" = "SPARK_WORKER_CORES"
                  "value" = var.SPARK_WORKER_CORES
                },
                {
                  "name" = "SPARK_RPC_AUTHENTICATION_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_RPC_ENCRYPTION_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_LOCAL_STORAGE_ENCRYPTION_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_SSL_ENABLED"
                  "value" = "no"
                },
                {
                  "name" = "SPARK_USER"
                  "value" = var.SPARK_USER
                },
              ]
              "image" = var.SPARK_IMAGE
              "name" = "spark-worker"
            },
            {
              "env" = [
                {
                  "name" = "SPARK_MASTER_HOSTNAME"
                  "value" = var.SPARK_MASTER_HOSTNAME
                },
              ]
              "image" = var.PYSPARK_IMAGE
              "name" = "pyspark"
              "ports" = [
                {
                  "containerPort" = var.PYSPARK_CLIENT_PORT
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_spark_master_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = var.SPARK_MASTER_HOSTNAME
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "master-port"
          "port" = var.SPARK_MASTER_INTERNAL_PORT
          "targetPort" = var.SPARK_MASTER_INTERNAL_PORT
        },
        {
          "name" = "pyspark-port"
          "port" = var.PYSPARK_CLIENT_PORT
          "targetPort" = var.PYSPARK_CLIENT_PORT
        },
        {
          "name" = "web-ui"
          "port" = var.SPARK_MASTER_EXTERNAL_PORT
          "targetPort" = var.SPARK_MASTER_EXTERNAL_PORT
        },
      ]
      "selector" = {
        "app" = "spark-master"
      }
    }
  }
}