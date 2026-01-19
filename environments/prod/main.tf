module "gke_prod" {
  source = "../../modules/gke-infra"

  project_id       = "your-gcp-project-id"
  env_name         = "prod"
  region           = "us-central1"
  primary_zone     = "us-central1-a"       # DC 1
  additional_zones = ["us-central1-b"]     # DC 2 (The 2nd Datacenter)
  
  # Larger CIDR to accommodate 30 nodes + growth
  subnet_cidr      = "10.0.0.0/20"    
  
  # Logic: 15 nodes in DC1 + 15 nodes in DC2 = 30 Nodes Total
  nodes_per_zone   = 15                    
  
  machine_type     = "e2-standard-4"       # High-performance nodes
}

output "prod_connection" {
  value = module.gke_prod.kubectl_connection_command
}