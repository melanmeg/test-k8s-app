resource "google_iam_workload_identity_pool" "my_pool" {
  project                   = local.project_id
  workload_identity_pool_id = "my-pool"
}

############################################
# GitHub Pool Provider                     #
############################################
resource "google_iam_workload_identity_pool_provider" "github_pool_provider" {
  project                            = local.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.my_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-pool-provider"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "assertion.repository == '${local.repository}'"
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "github" {
  account_id   = "terraform"
}

resource "google_service_account_iam_member" "workload_identity_member" {
  service_account_id = google_service_account.github.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.my_pool.name}/attribute.repository/${local.repository}"
}

resource "google_project_iam_member" "owner" {
  project = "my-project-melanmeg"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.github.email}"
}


############################################
# External Secrets Pool Provider           #
############################################
