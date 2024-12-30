resource "google_kms_key_ring" "sops" {
  name     = "sops"
  location = "global"

  depends_on = [
    google_project_service.enabled_apis["cloudkms.googleapis.com"]
  ]
}

resource "google_kms_crypto_key" "sops_key" {
  name     = "sops-key"
  key_ring = google_kms_key_ring.sops.id
  purpose  = "ENCRYPT_DECRYPT"
}
