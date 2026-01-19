resource "google_compute_network" "main" {
  name                    = "${var.env_name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "nodes_subnet" {
  name          = "${var.env_name}-subnet"
  region        = var.region
  network       = google_compute_network.main.id
  ip_cidr_range = var.subnet_cidr
}