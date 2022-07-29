

resource "google_project_iam_member" "cloudbuild_sa_roles" {
 project = var.project
 role= "roles/container.developer"
member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
} 
resource  "google_project_iam_member" "binary-test-1" {
 project = var.project
 role= "roles/container.developer"
member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
}
resource "google_project_iam_member" "qa-attestors" {
 project = var.project
 role= "roles/binaryauthorization.attestorsViewer"
member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "qa-signers" {
 project = var.project
 role= "roles/cloudkms.signerVerifier"
member  = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
}