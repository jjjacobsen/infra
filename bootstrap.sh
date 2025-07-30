#!/bin/bash

set -euo pipefail

echo "Starting minimal bootstrap for AlmaLinux 9.4..."

# Update system packages
echo "Updating system packages..."
sudo dnf update -y

# Install essential tools
echo "Installing essential tools..."
sudo dnf install -y \
    curl \
    wget \
    git \
    unzip \
    tar \
    which

# Install AWS CLI
echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

# Install Docker
echo "Installing Docker..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Add current user to docker group (allows running docker without sudo)
echo "Adding user to docker group..."
sudo usermod -aG docker $USER

# Verify installations
echo "Verifying installations..."
sudo docker --version
sudo docker compose version
aws --version

echo "Bootstrap completed successfully!"
echo "Note: You may need to log out and back in for docker group changes to take effect."
echo "Test with: docker run hello-world"
echo "Configure AWS CLI with: aws configure"
