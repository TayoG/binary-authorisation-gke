/*resource"google_kms_key_ring" "keyring" {
name     = "binauthz"
project = "binary-test-1"
location = "europe-west2"
}
resource "google_kms_crypto_key" "vulnz-signer" {
  name     = "vulnz-signer"
  key_ring = google_kms_key_ring.keyring.id
  purpose  = "ASYMMETRIC_SIGN"

  version_template {
    algorithm = "rsa-sign-pkcs1-4096-sha512"
  }

  lifecycle {
    prevent_destroy = true
  }
}
resource "google_kms_crypto_key" "qa-signer" {
  name     = "qa-signer"
  key_ring = google_kms_key_ring.keyring.id
  purpose  = "ASYMMETRIC_SIGN"

  version_template {
    algorithm = "rsa-sign-pkcs1-4096-sha512"
  }

  lifecycle {
    prevent_destroy = true
  }
}*/

resource "null_resource" "vulnz-note"{
  
 provisioner "local-exec" {
   when = create
     command = "sh 1.sh"
 }
}
resource "null_resource" "grant"{
  
 provisioner "local-exec"{
   when = create
     command = "sh 2.sh"
 }
}

/*resource "null_resource" "vulnz-attestor" {
  
 provisioner "local-exec"{
   when = "create"
     command = "gcloud container binauthz attestors create vulnz-attestor  --project binary-test-1 --attestation-authority-note-project binary-test-1 --attestation-authority-note vulnz-note --description Vulnerability scan attestor"
    
 }
}*/



resource "null_resource" "attestors-public-keys-add" {
  
 provisioner "local-exec"{
   
   when = create
   on_failure= continue
     command = "gcloud beta container binauthz attestors public-keys add --project binary-test-1 --attestor vulnz-attestor  --keyversion 1 --keyversion-key vulnz-signer --keyversion-keyring binauthz --keyversion-location europe-west2  --keyversion-project binary-test-1"
 }
}

/*resource "google_binary_authorization_attestor_iam_binding" "binding" {
  project = "binary-test-1"
  attestor = "vulnz-attestor"
  role = "roles/binaryauthorization.attestorsViewer"
  members = [
    "user:e-beou@gft.com",
  ]
}*/
resource "null_resource" "iam-policy-binding-qa-attestor" {
  
 provisioner "local-exec"{
   
   when = create
     command = "gcloud container binauthz attestors add-iam-policy-binding qa-attestor --project binary-test-1 --member serviceAccount:690873990773@cloudbuild.gserviceaccount.com --role roles/binaryauthorization.attestorsViewer"
 }
}
#Grant the Cloud Build service account permission to sign objects using the vulnz-signer key:
/*resource "google_binary_authorization_attestor" "attestor" {
name= "attestor"
attestation_authority_note = 
}
resource "google_binary_authorization_policy" "policy" {
     project = "binary-test-1"
  default_admission_rule {
    evaluation_mode         = "REQUIRE_ATTESTATION"
    enforcement_mode        = "ENFORCED_BLOCK_AND_AUDIT_LOG"
    require_attestations_by = [attestor]
   
  }

  global_policy_evaluation_mode = "ENABLE"
}*/

resource "null_resource" "cloud-build-vulnz-signer" {
  
 provisioner "local-exec"{
   
   when = create
     command = "gcloud kms keys add-iam-policy-binding vulnz-signer --project binary-test-1 --location europe-west2 --keyring binauthz --member serviceAccount:690873990773@cloudbuild.gserviceaccount.com --role 'roles/cloudkms.signerVerifier'"
 }
}
resource "null_resource" "qa-note"{
  
 provisioner "local-exec" {
   when = create
     command = "sh 3.sh"
 }
}
resource "null_resource" "cloudbuild-grant"{
  
 provisioner "local-exec" {
   when = create
     command = "sh 4.sh"
 }
}

/*resource "null_resource" "qa-attestor1" {
  
 provisioner "local-exec"{ #Already exist!!
   
   when = create
     command = "gcloud container binauthz attestors create qa-attestor --project binary-test-1 --attestation-authority-note-project binary-test-1 --attestation-authority-note 'qa-note' --description 'QA-attestor'"
 }
}*/

/*gcloud container binauthz attestors create "qa-attestor" \
  --project binary-test-1 \
  --attestation-authority-note-project binary-test-1 \
  --attestation-authority-note "qa-note" \
  --description "QA attestor"
  */

  resource "null_resource" "attestors-public-keys-add1" {
  
 provisioner "local-exec"{
   
   when = create
     command = "gcloud beta container binauthz attestors public-keys add --project binary-test-1 --attestor vulnz-attestor  --keyversion 1 --keyversion-key vulnz-signer --keyversion-keyring binauthz --keyversion-location europe-west2  --keyversion-project binary-test-1"
 }
}

resource "null_resource" "iam-policy-binding-qa-signer1" {
  
 provisioner "local-exec"{
   
   when = create
     command = "gcloud kms keys add-iam-policy-binding qa-signer --project binary-test-1 --location us-central1 --keyring binauthz --member user:e-beou@gft.com --role roles/cloudkms.signerVerifier"

 }
}