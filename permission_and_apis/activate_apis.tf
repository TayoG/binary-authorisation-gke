resource "google_project_service" "project-services" {
  project                     = var.project
  disable_dependent_services  = true
  service                     = each.value 
  for_each                    = toset(var.apis_to_activate) 
}
