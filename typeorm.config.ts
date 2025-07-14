import { DataSource } from 'typeorm';
import { User } from './src/users/entities/user.entity';
import * as dotenv from 'dotenv';

// Load environment variables from .env file
dotenv.config();

export default new DataSource({
  type: 'postgres',
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT) || 5432,
  username: process.env.DB_USERNAME || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
  database: process.env.DB_NAME || 'nestjs_auth',
  entities: [User],
  migrations: ['src/migrations/*.ts'],
  migrationsTableName: 'migrations',
  synchronize: false, // Always false for migrations
  logging: process.env.NODE_ENV === 'development',
});