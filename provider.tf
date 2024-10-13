terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.27.0"
    }
  }
}

provider "google" {
  # Configuration option
  project = var.setup.project
  region  = var.setup.region
  zone    = var.setup.zone
  # credentials = var.setup.credentials
}
