#!/bin/bash

# TPS Admin Portal Deployment Script
# Usage: ./deploy.sh

set -e

echo "🚀 Starting deployment..."

# Navigate to project directory
cd "$(dirname "$0")/.."

echo "📥 Pulling latest code from GitHub..."
git pull origin main

echo "🐳 Building Docker image..."
cd gateway
docker compose build

echo "🔄 Stopping old containers..."
docker compose down

echo "▶️  Starting new containers..."
docker compose up -d

echo "🧹 Cleaning up old images..."
docker image prune -f

echo "✅ Deployment completed successfully!"
echo "🌐 Application is running on http://localhost"

# Show running containers
docker compose ps
