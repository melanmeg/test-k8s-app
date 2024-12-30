resource "google_storage_bucket" "my_bucket" {
  name          = "my-unique-bucket-name-hogehoge"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 365
    }
  }
}
