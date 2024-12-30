locals {
  project_id = "my-project-melanmeg"
  region     = "asia-northeast1"
  zones      = ["asia-northeast1-a"]
  labels = {
    "environment" : "my",
    "project_id" : "my-project-melanmeg",
    "owner" : "melanmeg"
  }

  repository = "melanmeg/my-k8s-app"
}
