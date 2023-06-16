# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

data "terraform_remote_state" "k8_cluster" {
  backend = "local"
  config = {
    path = "../GKE/terraform.tfstate"
  }
}

data "google_client_config" "current" {}

provider "kubernetes" {

  host     = "https://${data.terraform_remote_state.k8_cluster.outputs.kubernetes_cluster_host}"
  token = data.google_client_config.current.access_token

  # client_certificate     = base64decode(data.terraform_remote_state.k8_cluster.outputs.kubernetes_client_certificate)
  # client_key             = base64decode(data.terraform_remote_state.k8_cluster.outputs.kubernetes_client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.k8_cluster.outputs.kubernetes_cluster_ca_certificate)
}
