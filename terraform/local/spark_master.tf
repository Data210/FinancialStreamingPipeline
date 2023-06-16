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
                  "value" = "spark"
                },
              ]
              "image" = "docker.io/bitnami/spark:3.4"
              "name" = "spark-master"
              "ports" = [
                {
                  "containerPort" = 7077
                },
                {
                  "containerPort" = 8080
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
                  "value" = "spark://spark-master-service:7077"
                },
                {
                  "name" = "SPARK_WORKER_MEMORY"
                  "value" = "1G"
                },
                {
                  "name" = "SPARK_WORKER_CORES"
                  "value" = "1"
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
                  "value" = "spark"
                },
              ]
              "image" = "docker.io/bitnami/spark:3.4"
              "name" = "spark-worker"
            },
            {
              "env" = [
                {
                  "name" = "SPARK_MASTER_HOSTNAME"
                  "value" = "spark-master-service"
                },
              ]
              "image" = "ethanjolly/fin_pyspark"
              "name" = "pyspark"
              "ports" = [
                {
                  "containerPort" = 9192
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
      "name" = "spark-master-service"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "master-port"
          "port" = 7077
          "targetPort" = 7077
        },
        {
          "name" = "pyspark-port"
          "port" = 9192
          "targetPort" = 9192
        },
        {
          "name" = "web-ui"
          "port" = 8080
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "spark-master"
      }
    }
  }
}