terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.1.0"
    }
    sops = {
      source = "carlpett/sops"
      version = "1.1.1"
    }
  }
  backend "gcs" {
    bucket  = "my-project-melanmeg-tfstate"
    prefix  = "my-project-melanmeg/state"
  }
}

provider "google" {
  project        = local.project_id
  region         = local.region
  zone           = local.zones[0]
  default_labels = local.labels
}
