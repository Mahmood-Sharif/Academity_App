import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/l10n/l10n.dart';
import 'package:academity_app/providers/language_provider.dart';
import 'package:academity_app/views/Profile/users_profile_screen.dart';
import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/auth/signup_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:academity_app/views/login_gate.dart';
import 'package:academity_app/views/users_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:academity_app/l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academity',
      theme: AcademityTheme.light(context),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginGate(),
        '/demo': (context) => const SportsPage(showBackButton: true),
        '/login': (context) => const LoginScreen(),
        '/browseSports': (context) => const UsersBottomNavigation(),
        '/signup': (context) => const SignupScreen(),
        '/userProfile': (context) => const UserProfileScreen(),
      },
      supportedLocales: L10n.all,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
