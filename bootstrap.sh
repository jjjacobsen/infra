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

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker --version
sudo docker compose version

echo "Bootstrap completed successfully!"
echo "Note: You may need to log out and back in for docker group changes to take effect."
echo "Test with: docker run hello-world"
