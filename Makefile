.PHONY: help dev up down logs clean test

help:
	@echo ""
	@echo "EscolaConnect - Available Commands:"
	@echo ""
	@echo "  make dev          - Start with hot-reload (docker-compose watch)"
	@echo "  make up           - Start containers in background"
	@echo "  make down         - Stop all containers"
	@echo "  make logs         - Show all logs"
	@echo "  make logs-backend - Show backend logs"
	@echo "  make logs-frontend- Show frontend logs"
	@echo "  make logs-mongo   - Show MongoDB logs"
	@echo "  make bash         - Access backend shell"
	@echo "  make shell        - Access frontend shell"
	@echo "  make clean        - Remove containers and volumes"
	@echo "  make build        - Rebuild all images"
	@echo "  make test         - Run tests (when available)"
	@echo ""

dev:
	docker-compose watch

up:
	docker-compose up -d
	@echo ""
	@echo "✅ Containers started!"
	@echo ""
	@echo "📱 Frontend:  http://localhost:3000"
	@echo "🔌 Backend:   http://localhost:8001"
	@echo "🗄️  MongoDB:   localhost:27017"
	@echo ""

down:
	docker-compose down

logs:
	docker-compose logs -f

logs-backend:
	docker-compose logs -f backend

logs-frontend:
	docker-compose logs -f frontend

logs-mongo:
	docker-compose logs -f mongodb

bash:
	docker exec -it escolaconnect-backend bash

shell:
	docker exec -it escolaconnect-frontend sh

clean:
	docker-compose down -v
	@echo "✅ Cleaned up!"

build:
	docker-compose build --no-cache

test:
	@echo "Tests coming soon..."
