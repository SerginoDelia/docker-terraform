# Docker Terraform

#### Create:
create a Google Artifact Registry Repository

#### Update:
In `variables.tf' file update `credentials` and `project`. In provider file uncomment `credentials`.
Update the image URLs in `docker.sh` and `docker-push-gar.sh`

#### This project will provision a GCP:
- Network
- Subnet
- Service Account with Storage Admin and GAR Admin Roles
  - Create a GAR Repository 
- VM
  - Install Docker in the VM
  - Pull image from Google Artifact Registry
  - Run container
- Service Account with Storage Admin and GAR Admin Roles