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
      title: 'Your App Title',
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const SportsPage(), // Your home page or another initial page
        // Define other static routes here if necessary
      },
      onGenerateRoute: (settings) {
        // Check if the route name is "/sport-detail"
        if (settings.name == '/sport-detail') {
          // The argument should be the sport ID, ensure it's an int
          final sportId = settings.arguments as int;

          // Generate the route to the sport detail page
          return MaterialPageRoute(
            builder: (context) {
              // Replace 'SportDetailPage' with the actual page you want to navigate to
              // Pass 'sportId' to the page as an argument or through its constructor
              return BrowseAcademyScreen(
                  sportId:
                      sportId); // Update this line according to your implementation
            },
          );
        }
        // Handle other dynamic routes or return null for unknown routes
        return null;
      },
    );
  }
}
