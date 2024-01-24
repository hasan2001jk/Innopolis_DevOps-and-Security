#!/bin/bash

# Set our Docker image names and tags
DOCKER_IMAGE_A="nginx-container-a"
DOCKER_TAG_A="latest"

DOCKER_IMAGE_B="nginx-container-b"
DOCKER_TAG_B="latest"

# Set the path to our Nginx configuration file for the load balancer
NGINX_CONF_PATH="/etc/nginx/sites-available/load-balancer"

# Set the path to the directory with both Dockerfiles (container A and container B)
DOCKERFILES_DIR="./dockerfiles"

# Set the path to the directory containing index.html files for Container A and Container B
HTML_FILES_DIR="./html-files"

# Set the repository URL for Version Control System (VCS)
VCS_REPO_URL="https://github.com/hasan2001jk/Innopolis_DevOps-and-Security.git"

# Build Docker images for Container A and Container B
docker build -t $DOCKER_IMAGE_A:$DOCKER_TAG_A "$DOCKERFILES_DIR/container_a" # Build image for container A
docker build -t $DOCKER_IMAGE_B:$DOCKER_TAG_B "$DOCKERFILES_DIR/container_b" # Build image for container B

# Run containers using Docker Compose
docker-compose up -d # Start containers in detached mode

# Install Nginx on the host machine
sudo apt-get update
sudo apt-get install -y nginx # Install Nginx

# Configure Nginx as an L7 load balancer
echo "upstream backend {
    server localhost:8080;
    server localhost:9090;
}" | sudo tee "$NGINX_CONF_PATH" # Configure Nginx with load balancer settings

# Restart Nginx to apply the load balancer configuration
sudo service nginx restart

# Push the code to Version Control System (Git example)
git init
git add .
git commit -m "Initial commit"
git remote add origin $VCS_REPO_URL # Add remote repository
git push -u origin master # Push code to remote repository

echo "Deployment complete." # Output completion message
