#!/bin/bash

# 🔄 Update Script
# This script pulls the latest Docker images and restarts the services

set -e  # Exit on any error

echo "🆙 Pulling latest Docker images..."
docker compose pull

echo "🚀 Starting services with latest images..."
docker compose --env-file .env up -d

echo "✅ Update complete!"
