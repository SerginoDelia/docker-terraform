# Create a Google VPC 
resource "google_compute_network" "docker_vpc" {
  project                 = var.setup.project
  name                    = var.docker_network.vpc
  auto_create_subnetworks = false
  mtu                     = 1460
}

# add subnet to the VPC
resource "google_compute_subnetwork" "docker_subnet" {
  name          = var.docker_network.subnet
  ip_cidr_range = var.docker_network.cidr
  region        = var.docker_network.region
  network       = google_compute_network.docker_vpc.id
}

# firewall rule to allow traffic on port 80
resource "google_compute_firewall" "docker_firewall" {
  name    = var.docker_network.firewall_name
  network = google_compute_network.docker_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
}
