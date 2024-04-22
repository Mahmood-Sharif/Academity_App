import 'package:academity_app/l10n/l10n.dart';
import 'package:academity_app/providers/language_provider.dart';
import 'package:academity_app/views/Profile/users_profile_screen.dart';
import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/auth/signup_screen.dart';
import 'package:academity_app/views/login_gate.dart';
import 'package:academity_app/views/users_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    return MaterialApp(
      title: 'Academity',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginGate(),
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
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}
