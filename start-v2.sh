#!/bin/bash

# Script to start EscolaConnect V2.0 with Docker Compose

set -e

echo "🚀 Starting EscolaConnect V2.0..."
echo ""

# Check if docker-compose V2 is available
if ! command -v docker compose &> /dev/null; then
    echo "❌ Docker Compose V2 is not installed"
    exit 1
fi

# Start services
echo "📦 Building and starting containers..."
docker compose -f docker-compose.v2.yml up -d --build

echo ""
echo "⏳ Waiting for services to be healthy..."
sleep 30

# Check health
echo ""
echo "🏥 Health Check:"
docker compose -f docker-compose.v2.yml ps

echo ""
echo "✅ EscolaConnect V2.0 is running!"
echo ""
echo "📍 Access points:"
echo "  Frontend:  http://localhost:3000"
echo "  Backend:   http://localhost:8001"
echo "  Adminer:   http://localhost:8080"
echo ""
echo "🔐 Test Credentials:"
echo "  Admin:      admin@escolaconnect.com / admin123"
echo "  Professor:  professor@escola.com / prof123"
echo "  Cantineiro: cantina@escola.com / cantina123"
echo "  Student:    aluno@escola.com / aluno123"
echo ""
echo "📝 Useful commands:"
echo "  View logs:    docker compose -f docker-compose.v2.yml logs -f"
echo "  Stop:         docker compose -f docker-compose.v2.yml down"
echo "  Full reset:   docker compose -f docker-compose.v2.yml down -v"
echo ""
