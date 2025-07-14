# NestJS Auth Docker - Makefile

.PHONY: help install build start stop restart logs test clean docker-build docker-up docker-down

# Default target
help:
	@echo "Available commands:"
	@echo "  install      - Install dependencies"
	@echo "  build        - Build the application"
	@echo "  start        - Start development server"
	@echo "  test         - Run tests"
	@echo "  lint         - Run linting"
	@echo "  format       - Format code"
	@echo "  migration-run     - Run database migrations"
	@echo "  migration-revert  - Revert last migration"
	@echo "  migration-show    - Show migration status"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-up    - Start with Docker Compose"
	@echo "  docker-down  - Stop Docker Compose"
	@echo "  docker-logs  - View Docker logs"
	@echo "  test-api     - Test API endpoints"
	@echo "  clean        - Clean build artifacts"

# Development commands
install:
	npm install

build:
	npm run build

start:
	npm run start:dev

test:
	npm run test

lint:
	npm run lint

format:
	npm run format

# Migration commands
migration-run:
	npm run migration:run

migration-revert:
	npm run migration:revert

migration-show:
	npm run migration:show

migration-generate:
	npm run migration:generate

# Docker commands
docker-build:
	docker-compose build

docker-up:
	docker-compose up -d
	@echo "Application starting... Wait a moment then visit http://localhost:3000"

docker-down:
	docker-compose down

docker-logs:
	docker-compose logs -f

restart: docker-down docker-up

# API testing
test-api:
	@echo "Testing API endpoints..."
	@chmod +x ./test-api.sh
	@./test-api.sh

# Cleanup
clean:
	rm -rf dist/
	rm -rf node_modules/
	docker-compose down -v
	docker system prune -f

# Development workflow
dev-setup: install docker-up
	@echo "Development environment ready!"
	@echo "API available at: http://localhost:3000"
	@echo "Database available at: localhost:5432"

# Production deployment
deploy: docker-build docker-up test-api
	@echo "Deployment completed successfully!"