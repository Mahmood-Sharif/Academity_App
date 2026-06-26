import 'package:academity_app/l10n/l10n.dart';
import 'package:academity_app/views/auth/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('landing page offers portfolio preview and auth actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routes: {
          '/': (context) => const LandingPage(),
          '/demo': (context) => const Placeholder(),
          '/login': (context) => const Placeholder(),
          '/signup': (context) => const Placeholder(),
        },
      ),
    );

    expect(find.text('Preview app'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
