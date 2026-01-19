output "cluster_name" {
  value       = google_container_cluster.primary.name
  description = "The name of the GKE cluster"
}

output "cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "The IP address of the cluster master"
}

output "vpc_name" {
  value       = google_compute_network.main.name
  description = "The name of the VPC created"
}

output "subnet_name" {
  value       = google_compute_subnetwork.nodes_subnet.name
  description = "The name of the subnet used for nodes"
}

output "storage_bucket_url" {
  value       = google_storage_bucket.app_storage.url
  description = "The URL of the GCS bucket for application assets"
}

output "kubectl_connection_command" {
  value       = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location} --project ${var.project_id}"
  description = "Run this command to connect your terminal to the cluster"
}