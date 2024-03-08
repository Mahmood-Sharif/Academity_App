import 'package:academity_app/services/auth_services.dart';
import 'package:academity_app/views/auth/login_screen.dart';
import 'package:academity_app/views/home/browse_academy_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
