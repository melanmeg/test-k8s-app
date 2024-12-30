resource "google_kms_key_ring" "sops" {
  name     = "sops"
  location = "global"
}

resource "google_kms_crypto_key" "sops_key" {
  name     = "sops-key"
  key_ring = google_kms_key_ring.sops.id
  purpose  = "ENCRYPT_DECRYPT"
}
