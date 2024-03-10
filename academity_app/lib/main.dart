// ignore_for_file: unused_import

import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
                '/': (context) => const SportsPage(),
        // '/': (context) => const LoginScreen(),
        // '/browseSports': (context) => const SportsPage(),
      },
    );
  }
}
