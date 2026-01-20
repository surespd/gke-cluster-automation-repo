# The primary Google provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# The Kubernetes provider (Allows you to manage K8s objects via Terraform)
provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

# Fetches the authentication token for the current gcloud user/service account
data "google_client_config" "default" {}