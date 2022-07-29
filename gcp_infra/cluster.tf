


resource "google_service_account" "default" {
  account_id   = "service-account-id"
  project          = var.project
  display_name = "Service Account"
}

resource "google_container_cluster" "staging" {
  project          = var.project
  name     = var.gke_staging_name
  location = var.region
 enable_binary_authorization = true

  remove_default_node_pool = true
  initial_node_count       = 1
}


resource "google_container_node_pool" "staging_preemptible_nodes" {
  name       = "my-node-pool-3"
  location   = var.region
  project          = var.project
  cluster    = google_container_cluster.staging.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

   
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_cluster" "production" {
  project          = var.project
  name     = var.gke_prod_name
  location = var.region
 enable_binary_authorization = true
  remove_default_node_pool = true
  initial_node_count       = 1
}
resource "google_container_node_pool" "production_preemptible_nodes" {
  name       = "my-node-pool-4"
  location   = var.region
  project          = var.project
  cluster    = google_container_cluster.production.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

  
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}