resource "google_container_cluster" "primary" {
  name     = "${var.env_name}-cluster"
  location = var.primary_zone # e.g., us-central1-a

  # This is empty for Dev/Stage, but contains ["us-central1-b"] for Prod
  node_locations = var.additional_zones 

  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.name
  subnetwork               = google_compute_subnetwork.nodes_subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.env_name}-node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = var.nodes_per_zone # 5 for Dev, 10 for Stage, 15 for Prod

  node_config {
    machine_type = var.machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}