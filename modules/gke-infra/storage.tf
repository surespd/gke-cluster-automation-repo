resource "google_storage_bucket" "app_storage" {
  name          = "${var.project_id}-${var.env_name}-assets"
  location      = var.region
  force_destroy = var.env_name == "prod" ? false : true

  versioning {
    enabled = true
  }
}