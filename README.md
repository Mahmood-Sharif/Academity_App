# Development Guide

## Dart

In `academity_app/lib/`, **copy `env.dart` to `.env.dart`** and change the
variables for your environment (e.g. IP address).

Remember to run `> flutter gen-l10n` every time you change localizations or
start in a fresh clone.

## PHP

In `api_and_admin_portal/`, **copy `env` to `.env`** and change the variables
for your environment (e.g. IP address).

Run `> composer i` to install the necessary libraries, and
`> php spark serve --host 0.0.0.0` to start the development server.

It is also a good idea to run `> php spark cache:clear` every time you change
the `.env` file to clear any cached responses with the wrong IP address.
