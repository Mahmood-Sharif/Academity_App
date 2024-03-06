import 'package:academity_app/views/home/browse_academy_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academity',
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const SportsPage(), // Your home page or another initial page
        // Define other static routes here if necessary
      },
onGenerateRoute: (settings) {
  if (settings.name == '/browse-academy') {
    final sportId = settings.arguments as int; // Assuming you pass an int directly
    return MaterialPageRoute(
      builder: (context) => BrowseAcademyScreen(sportId: sportId),
    );
  }
  // Handle other dynamic routes or return null for unknown routes
  return null;
},

    );
  }
}
