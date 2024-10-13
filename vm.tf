# Define a service account
resource "google_service_account" "gcr_access" {
  account_id   = "gcr-access-sa"
  display_name = "Service Account for GCR Access"
}

# Assign the necessary roles to the service account
resource "google_project_iam_member" "storage_admin" {
  project = var.setup.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gcr_access.email}"
}

resource "google_project_iam_member" "gar_admin" {
  project = var.setup.project
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.gcr_access.email}"
}

resource "google_compute_instance" "doker_instance" {
  name         = var.docker_instance.name
  machine_type = var.docker_instance.machine_type
  zone         = var.setup.zone


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
    # true by default
    auto_delete = true
  }

  network_interface {
    network    = var.docker_network.vpc
    subnetwork = var.docker_network.subnet

    access_config {
      // Ephemeral public IP
    }
  }

  tags = ["http-server"]

  # metadata = {
  #   startup-script-url = "${file("startup.sh")}"
  # }

  metadata_startup_script = file("docker.sh")

  # Attach the service account to the VM
  service_account {
    email  = google_service_account.gcr_access.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"] # Full access; adjust if necessary
  }

  depends_on = [google_compute_network.docker_vpc,
  google_compute_subnetwork.docker_subnet, google_compute_firewall.docker_firewall]
}

# Create a repository in Artifact Registry
# resource "google_artifact_registry_repository" "my_repo" {
#   provider = google
#   location = "us-west1"
#   repository_id = "terraform-repo"
#   format = "DOCKER" # or "MAVEN", "NPM", etc.
#   description = "My Artifact Registry Repository"
