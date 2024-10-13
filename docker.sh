#!/bin/bash
# Update package list
sudo apt-get update
# Install Git
sudo apt-get install -y git
# Install Docker
sudo apt-get install -y docker.io
# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker
# Install Docker Compose
sudo apt-get install -y docker-compose
# Authenticate Docker with GCR 
gcloud auth configure-docker us-docker.pkg.dev --quiet
# Pull the image from GCR (replace <PROJECT-ID> and <IMAGE-NAME>)
docker pull us-docker.pkg.dev/agwe-3/project1/lizzo:v2
# Run the pulled image with Docker
docker run -d --name lizzo-container -p 80:80 us-docker.pkg.dev/agwe-3/project1/lizzo:v2