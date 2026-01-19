variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "env_name" {
  type        = string
  description = "Environment name (dev, stage, prod)"
}

variable "region" {
  type        = string
  description = "The region for the VPC and Subnet"
}

variable "primary_zone" {
  type        = string
  description = "The main zone for the GKE Control Plane"
}

variable "additional_zones" {
  type        = list(string)
  default     = []
  description = "Used for Prod: Provides the 2nd DC (e.g. ['us-central1-b'])"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range for the node subnet"
}

variable "nodes_per_zone" {
  type        = number
  description = "Number of nodes in EACH zone (Dev: 5, Stage: 10, Prod: 15)"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}