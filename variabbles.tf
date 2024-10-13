variable "setup" {
  type = map(string)
  default = {
    project       = "agwe-3"
    "region"      = "us-east1"
    "zone"        = "us-east1-b"
    "credentials" = "key.json"
  }
}

variable "docker_network" {
  type = map(string)
  default = {
    vpc           = "docker-vpc"
    subnet        = "docker-subnet"
    region        = "us-east1"
    cidr          = "10.40.0.0/24"
    firewall_name = "docker-firewall"

  }
}

variable "docker_instance" {
  type = map(string)
  default = {
    machine_type = "e2-medium"
    name         = "docker-instance"
  }
}

