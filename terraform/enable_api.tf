resource "google_project_service" "enabled_apis" {
  for_each = toset([
    "cloudkms.googleapis.com",
    "secretmanager.googleapis.com"
  ])
  project = "my-project-melanmeg"
  service = each.value
}
