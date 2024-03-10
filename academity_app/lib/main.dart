import 'package:academity_app/services/auth_services.dart';
import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/home/browse_academy_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const secureStorage = FlutterSecureStorage();
    final Future<bool> isLoggedIn =
        secureStorage.read(key: 'api_token').then((apiToken) {
      if (apiToken == null) return false;
      final auth = AuthServices();
      return auth.loginTest();
    });

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
            fontSize: 22, // Set your desired size
            fontWeight: FontWeight.w500, // And weight, if needed
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
            future: isLoggedIn,
            builder: (context, asyncSnapshot) {
              // if we don't have the api key, show login screen
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (!asyncSnapshot.hasData ||
                  (asyncSnapshot.hasData && asyncSnapshot.data == false)) {
                return const LoginScreen();
              } else {
                // else show the main app
                return const SportsPage();
              }
            }),

        // Define other static routes here if necessary
        '/browseSports': (context) => const SportsPage(),
      },
    );
  }
}
