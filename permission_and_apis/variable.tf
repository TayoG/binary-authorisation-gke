
variable "project" { }
variable "project_number" { }
variable "project_id" { }
variable "region" {}
variable "apis_to_activate" {
  description = "apis that will be enabled"
  type        = list(string)
  default     = ["iam.googleapis.com",
  "servicenetworking.googleapis.com", 
  "artifactregistry.googleapis.com", 
  "container.googleapis.com", 
  "clouddeploy.googleapis.com", 
  "cloudbuild.googleapis.com", 
  "sourcerepo.googleapis.com", 
  "cloudresourcemanager.googleapis.com", 
  "compute.googleapis.com",
  "binaryauthorization.googleapis.com",
    "containeranalysis.googleapis.com",
    "containerscanning.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudkms.googleapis.com",]
}