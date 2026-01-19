module "gke_dev" {
  source = "../../modules/gke-infra"

  project_id       = "your-gcp-project-id"
  env_name         = "dev"
  region           = "us-central1"
  primary_zone     = "us-central1-a"
  additional_zones = []               # Single DC for Dev
  
  subnet_cidr      = "10.10.0.0/24"    # Unique range for Dev
  nodes_per_zone   = 5                 # Total 5 nodes
  machine_type     = "e2-medium"       # Cost-effective nodes
}

# Output the connection string specifically for Dev
output "connect_command" {
  value = module.gke_dev.kubectl_connection_command
}