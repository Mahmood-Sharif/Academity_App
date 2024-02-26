import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
  title: 'Flutter Demo',
  initialRoute: '/',
  routes: {
    '/': (context) =>  const LoginScreen(),
    '/browseSports': (context) => const BrowseSportsScreen(), // Make sure BrowseSportsScreen is imported
    // other routes...
  },
);

  }
}
