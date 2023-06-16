terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable "host" {
  type = string
  default = "https://127.0.0.1:51605"
}

variable "client_certificate" {
    type = string
}

variable "client_key" {
    type = string
}

variable "cluster_ca_certificate" {
    type = string
}

variable "finnhub_api_key" {
    type = string
}

provider "kubernetes" {
  load_config_file = "false"

  host     = google_container_cluster.primary.endpoint
  username = var.gke_username
  password = var.gke_password

  client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
  client_key             = google_container_cluster.primary.master_auth.0.client_key
  cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}
