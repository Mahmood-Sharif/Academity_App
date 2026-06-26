# Academity Flutter App

The mobile client for Academity, a sports academy discovery and enrollment
platform. It includes authentication, localized English/Arabic copy, sports and
academy browsing, QR attendance, class schedules, and user profile management.

## Run

```bash
flutter pub get
flutter gen-l10n
flutter run
```

Tap **Preview app** on the welcome screen to explore the portfolio demo without
needing API credentials.

## Configuration

Edit `lib/env.dart` if you want the app to talk to a local API server.

## Checks

```bash
flutter analyze
flutter test
```
