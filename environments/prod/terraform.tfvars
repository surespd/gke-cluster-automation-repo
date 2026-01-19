env_name       = "prod"
region         = "us-central1-a"       # DC 1
additional_zones = ["us-central1-b"]  # DC 2
nodes_per_zone = 15                   # 15 in DC1 + 15 in DC2 = 30 Total
machine_type   = "e2-standard-4"