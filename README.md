# Academity

Academity is a sports academy platform for discovering academies, enrolling in
classes, managing schedules, and recording attendance with QR scanning. The
repository contains a Flutter mobile app plus a CodeIgniter-based API/admin
portal.

## Why This Project Matters

- Player and parent experience for browsing sports academies.
- Coach/admin workflows for classes, students, enrollments, and attendance.
- API-backed mobile features with authentication, localization, and profile
  management.
- Portfolio-friendly demo mode in the Flutter app, so reviewers can open the
  product experience even without a live backend.

## Project Structure

- `academity_app/` - Flutter mobile app.
- `api_and_admin_portal/` - PHP API and admin portal.
- `api_and_admin_portal/app/Database/` - migrations and seeders.
- `api_and_admin_portal/public/images/` - portal and sports media assets.

## Run The Flutter App

```bash
cd academity_app
flutter pub get
flutter gen-l10n
flutter run
```

The committed `academity_app/lib/env.dart` points at the default Academity API
host. Change it for local development if you are running the backend yourself.

For a quick portfolio review, launch the app and tap **Preview app** on the
welcome screen. The preview uses graceful demo data when the API is unavailable.

## Run The API/Admin Portal

```bash
cd api_and_admin_portal
composer install
cp env .env
php spark serve --host 0.0.0.0
```

After changing `.env`, clear cached configuration:

```bash
php spark cache:clear
```

## Quality Checks

```bash
cd academity_app
flutter analyze
flutter test
```

```bash
cd api_and_admin_portal
composer test
```
