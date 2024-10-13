# 1. Pull the image from Docker Hub
docker pull serge716/lizzo:v2 

# 2. Tag the image for GCR
docker tag serge716/lizzo:v2 us-docker.pkg.dev/agwe-3/project1/lizzo:v2


# 3. Authenticate Docker with GCR
gcloud auth configure-docker --quiet


# 4. Push the image to GCR
docker push us-docker.pkg.dev/agwe-3/project1/lizzo:v2
