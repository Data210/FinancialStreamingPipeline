output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "zone" {
  value       = var.zone
  description = "GCloud Zone"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_client_certificate" {
  value       = google_container_cluster.primary.master_auth.0.client_certificate
  description = "GKE Cluster Client Certificate"
  sensitive = true
}

output "kubernetes_client_key" {
  value       = google_container_cluster.primary.master_auth.0.client_key
  description = "GKE Cluster Client Key"
  sensitive = true
}

output "kubernetes_cluster_ca_certificate" {
  value       = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  description = "GKE Cluster CA Certificate"
  sensitive = true
}