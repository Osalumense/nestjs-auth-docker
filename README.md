# NestJS Authentication API with Docker

A simple NestJS application with user authentication, JWT tokens, and Docker support. This project demonstrates basic CRUD operations, user registration/login, and containerization with Docker.

## Features

- 🔐 User Authentication (Register/Login)
- 🎫 JWT Token-based Authorization
- 🐘 PostgreSQL Database Integration
- 🐳 Docker & Docker Compose Support
- 📝 Input Validation with Class Validators
- 🔒 Password Hashing with bcrypt
- 🏗️ TypeORM for Database Operations

## Tech Stack

- **Framework**: NestJS
- **Database**: PostgreSQL
- **ORM**: TypeORM
- **Authentication**: JWT + Passport
- **Validation**: Class Validator
- **Containerization**: Docker

## Quick Start

### Using Docker (Recommended)

1. Clone the repository:
```bash
git clone <your-repo-url>
cd nestjs-auth-docker
```

2. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your desired configuration
```

3. Start the application with Docker Compose:
```bash
docker-compose up --build
```

4. The API will be available at `http://localhost:3000`

### Local Development

1. Install dependencies:
```bash
npm install
```

2. Set up environment variables:
```bash
cp .env.example .env
# Edit .env and uncomment the development overrides:
# NODE_ENV=development
# DB_HOST=localhost
```

3. Start PostgreSQL database (or use Docker):
```bash
docker run --name postgres-dev -e POSTGRES_PASSWORD=password -e POSTGRES_DB=nestjs_auth -p 5432:5432 -d postgres:15-alpine
```

4. Run the application:
```bash
# Development mode
npm run start:dev

# Production mode
npm run build
npm run start:prod
```

## API Endpoints

### Authentication

#### Register User
```http
POST /auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123",
  "firstName": "John",
  "lastName": "Doe"
}
```

#### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

#### Get Profile (Protected)
```http
GET /auth/profile
Authorization: Bearer <your-jwt-token>
```

## Example Usage

### 1. Register a new user
```bash
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123",
    "firstName": "John",
    "lastName": "Doe"
  }'
```

### 2. Login
```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

### 3. Access protected route
```bash
curl -X GET http://localhost:3000/auth/profile \
  -H "Authorization: Bearer <your-jwt-token>"
```

## Project Structure

```
src/
├── auth/
│   ├── dto/
│   │   └── login.dto.ts
│   ├── guards/
│   │   └── jwt-auth.guard.ts
│   ├── strategies/
│   │   └── jwt.strategy.ts
│   ├── auth.controller.ts
│   ├── auth.module.ts
│   └── auth.service.ts
├── users/
│   ├── dto/
│   │   └── create-user.dto.ts
│   ├── entities/
│   │   └── user.entity.ts
│   ├── users.module.ts
│   └── users.service.ts
├── app.module.ts
└── main.ts
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_HOST` | Database host | `localhost` |
| `DB_PORT` | Database port | `5432` |
| `DB_USERNAME` | Database username | `postgres` |
| `DB_PASSWORD` | Database password | `password` |
| `DB_NAME` | Database name | `nestjs_auth` |
| `JWT_SECRET` | JWT secret key | `your-secret-key` |
| `PORT` | Application port | `3000` |
| `NODE_ENV` | Environment | `development` |

## Docker Commands

```bash
# Build and start services
docker-compose up --build

# Start services in background
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild only the app
docker-compose build app
```

## Development

```bash
# Install dependencies
npm install

# Start development server
npm run start:dev

# Run tests
npm run test

# Run e2e tests
npm run test:e2e

# Lint code
npm run lint

# Format code
npm run format
```

### Database Migrations

```bash
# Run migrations
npm run migration:run
# or
make migration-run

# Revert last migration
npm run migration:revert
# or
make migration-revert

# Show migration status
npm run migration:show
# or
make migration-show

# Generate new migration (after entity changes)
npm run migration:generate src/migrations/MigrationName
# or
make migration-generate
```

## Security Notes

- Change the `JWT_SECRET` in production
- Use strong passwords for database
- Enable HTTPS in production
- Consider rate limiting for authentication endpoints
- Validate and sanitize all inputs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.