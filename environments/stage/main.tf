module "gke_stage" {
  source = "../../modules/gke-infra"

  project_id       = "your-gcp-project-id"
  env_name         = "stage"
  region           = "us-central1"
  primary_zone     = "us-central1-a"
  additional_zones = []               # Single DC for Stage
  
  subnet_cidr      = "10.20.0.0/24"    # Unique range for Stage
  nodes_per_zone   = 10                # Total 10 nodes
  machine_type     = "e2-standard-2"   # Balanced nodes
}

# Output the connection string specifically for Stage
output "connect_command" {
  value = module.gke_stage.kubectl_connection_command
}