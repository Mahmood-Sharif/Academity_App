import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/home/browse_classes.dart';
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
    '/': (context) =>  const BrowseClasses(),
    '/browseClasses': (context) => const BrowseClasses(), // Make sure BrowseSportsScreen is imported
    // other routes...
  },
);

  }
}
