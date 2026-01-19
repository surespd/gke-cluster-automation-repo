resource "google_compute_firewall" "allow_internal" {
  name    = "${var.env_name}-allow-internal"
  network = google_compute_network.main.name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = [var.subnet_cidr]
}