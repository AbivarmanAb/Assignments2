#!/bin/bash

echo "==> Checking Docker installation..."
if ! command -v docker &> /dev/null
then
    echo "Docker is NOT installed. Install Docker first."
    exit 1
fi

echo "==> Checking Docker Compose..."
if ! command -v docker compose &> /dev/null
then
    echo "Docker Compose not found. Install Docker Compose v2."
    exit 1
fi

echo "==> Creating required directories..."
mkdir -p sample-app

echo "==> Starting all services using Docker Compose..."
docker compose up -d --build

echo "==> Waiting for containers to become healthy..."
sleep 10

echo "==> Containers Status:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo "==> Showing Jenkins initial password..."
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

echo "==> Logs Available:"
echo "  - Jenkins: docker logs -f jenkins"
echo "  - Redis: docker logs -f redis"
echo "  - Sample App: docker logs -f sample-app"
echo "  - Nginx: docker logs -f nginx"
