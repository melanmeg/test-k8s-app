resource "google_storage_bucket" "my_bucket" {
  name          = "my-unique-bucket-name-hogehoge"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}
