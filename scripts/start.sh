#!/bin/bash
set -e

# Function to wait for database
wait_for_db() {
  echo "Waiting for database to be ready..."
  until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USERNAME" -d "$DB_NAME"; do
    echo "Database is unavailable - sleeping"
    sleep 2
  done
  echo "Database is ready!"
}

# Function to run migrations
run_migrations() {
  echo "Running database migrations..."
  npm run migration:run
  echo "Migrations completed!"
}

# Wait for database to be ready
wait_for_db

# Run migrations in production
if [ "$NODE_ENV" = "production" ]; then
  run_migrations
fi

# Start the application
echo "Starting NestJS application..."
exec "$@"