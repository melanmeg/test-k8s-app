resource "google_secret_manager_secret" "argocd_github_token" {
  secret_id = "argocd-github-token-sm"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "argocd_github_token" {
  secret = google_secret_manager_secret.argocd_github_token.id
  secret_data = file("db-password.secret")
}
