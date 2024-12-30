resource "google_project_service" "enabled_apis" {
  for_each = toset([
    "cloudkms.googleapis.com",
    "secretmanager.googleapis.com"
  ])
  project = "my-project-melanmeg"
  service = each.value
}

# cloudresourcemanager.googleapis.com
# secretmanager.googleapis.com
# cloudkms.googleapis.com
# iam.googleapis.com

# resource "google_project_iam_member" "service_account_admin" {
#   project = "my-project-melanmeg"

#   role   = "roles/iam.serviceAccountAdmin"
#   member = "serviceAccount:terraform@my-project-melanmeg.iam.gserviceaccount.com"
# }
