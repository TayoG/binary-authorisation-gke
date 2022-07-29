resource "google_compute_subnetwork" "custom_subnet" {
  name          = "gke-use"
  project       = var.project
  ip_cidr_range = "10.0.0.0/17"
  region        = var.region
  network       = google_compute_network.vpc_network.id


  secondary_ip_range {
    range_name    = "prod-pods-range"
    ip_cidr_range = "10.21.0.0/17"
  }
  secondary_ip_range {
    range_name    = "prod-svc-range"
    ip_cidr_range = "10.21.128.0/22"
  }
  secondary_ip_range {
    range_name    = "stg-pods-range"
    ip_cidr_range = "10.78.0.0/17"
  }
  secondary_ip_range {
    range_name    = "stg-svc-range"
    ip_cidr_range = "10.78.128.0/22"
  }
}

