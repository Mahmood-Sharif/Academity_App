import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

interface class LocalizedErrorMessage {
  String localizedMessage(BuildContext context) => '';
}

/// Generic error
class UnknownError implements Exception, LocalizedErrorMessage {
  @override
  @override
  String localizedMessage(context) =>
      AppLocalizations.of(context)!.errorUnknown;
}

/// Generic error for not found 404
class NotFound implements Exception {}

class CannotDeleteAccount implements Exception, LocalizedErrorMessage {
  @override
  String localizedMessage(context) =>
      AppLocalizations.of(context)!.errorCannotDeleteAccount;
}

class CouldNotDeleteAccount implements Exception, LocalizedErrorMessage {
  @override
  String localizedMessage(context) =>
      AppLocalizations.of(context)!.errorCouldNotDeleteAccount;
}

class InvalidCredentials implements Exception, LocalizedErrorMessage {
  @override
  String localizedMessage(context) =>
      AppLocalizations.of(context)!.errorInvalidCredentials;
}
