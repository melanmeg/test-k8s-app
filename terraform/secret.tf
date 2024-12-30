resource "google_secret_manager_secret" "argocd_github_token" {
  secret_id = "argocd-github-token-sm"
  replication {
    user_managed {
      replicas {
        location = "asia-northeast1"
      }
      replicas {
        location = "asia-southeast1"
      }
    }
  }
}

resource "google_secret_manager_secret_version" "argocd_github_token" {
  secret = google_secret_manager_secret.argocd_github_token.id
  secret_data = file("argocd_github_token.secret")
}
