# Academity - Flutter + CodeIgniter Academy Management Platform

Academity is a legacy academy management platform modernized for local
development and portfolio demonstration. The project includes a Flutter app for
students/coaches and a CodeIgniter 4 backend with an admin portal, API, clean
demo database migrations, and seeded demo accounts.

## Tech Stack

- Flutter
- Dart
- CodeIgniter 4
- PHP 8.2
- MySQL 8
- CodeIgniter Shield
- Docker Compose

## Features

Backend/admin:

- Admin login
- Academies
- Classes
- Coaches
- Students
- Enrollments
- Prices
- Demo seeded data

Flutter app:

- Student login
- Browse sports
- Browse academies
- Academy details
- Class details/prices
- My Academy
- Schedule
- Profile
- QR scanner safe handling

## Demo Accounts

```txt
Admin:
admin@academity.test / Password123!

Owner:
owner@academity.test / Password123!

Coach:
coach@academity.test / Password123!

Student:
student@academity.test / Password123!
```

## Quick Start With Docker

From the project root:

```bash
git clone <repo-url>
cd Academity_App

docker compose up -d --build

docker compose exec academity-api php spark migrate --all
docker compose exec academity-api php spark db:seed DemoSeeder
```

Open:

```txt
Backend/Admin:
http://localhost:8080
http://localhost:8080/en/admin-portal

phpMyAdmin:
http://localhost:8081
```

The Docker database is available inside the Compose network as:

```txt
hostname: academity-mysql
database: academitydb
username: academity_user
password: academity_password
port: 3306
```

For host tools such as desktop database clients, use:

```txt
hostname: localhost
port: 3307
```

## Running The Flutter App

Flutter is not Dockerized. Run it separately:

```bash
cd academity_app
flutter pub get
flutter run -d chrome
```

The Flutter app expects the backend at:

```txt
http://localhost:8080
```

## Useful Docker Commands

```bash
docker compose ps
docker compose logs -f academity-api
docker compose exec academity-api php spark migrate:status
docker compose exec academity-api php spark db:seed DemoSeeder
docker compose down
docker compose down -v
```

Use `docker compose down -v` when you want to delete the local MySQL volume and
start from a completely clean database.

## Local Non-Docker Backend Setup

You can still run the backend without Docker:

1. Start MySQL manually, or start only the Docker database on host port `3307`.
2. Create `api_and_admin_portal/.env` from `api_and_admin_portal/env`.
3. Configure the database values for local access:

```txt
database.default.hostname = localhost
database.default.database = academitydb
database.default.username = academity_user
database.default.password = academity_password
database.default.DBDriver = MySQLi
database.default.port = 3307
```

Then run:

```bash
cd api_and_admin_portal
composer install
php spark migrate --all
php spark db:seed DemoSeeder
php spark serve --host 127.0.0.1 --port 8080
```

## Environment Notes

- The Docker Compose setup provides the CodeIgniter database settings through
  container environment variables.
- `api_and_admin_portal/.env.docker.example` documents the same values for
  reference.
- Real `.env` files are intentionally ignored and should not be committed.
- Demo credentials are intentionally public for portfolio review.

## Troubleshooting

- If port `8080` is busy, stop the old PHP server or change the Compose port
  mapping in `docker-compose.yml`.
- If port `3307` is busy, change the MySQL host port mapping in
  `docker-compose.yml`.
- If the database is dirty or migrations fail from old local data, run
  `docker compose down -v`, then rebuild and reseed.
- If Flutter cannot log in, confirm the backend is running at
  `http://localhost:8080`.
- If images do not show, confirm backend image URLs return `200`, for example
  `http://localhost:8080/images/Basketball.jpg`.
- If phpMyAdmin cannot connect, confirm `academity-mysql` is healthy with
  `docker compose ps`.

## Project Status

This is a modernized legacy project prepared for portfolio review. The backend
now has a clean fresh-database migration strategy, Dockerized MySQL/PHP runtime,
seeded demo data, working admin portal routes, and Flutter integration for local
development.

## Screenshots

Screenshots can be added here for the admin portal and Flutter app walkthrough.
