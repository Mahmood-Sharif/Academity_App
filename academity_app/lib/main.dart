import 'package:academity_app/views/MyAcademy/my_academy_screen.dart';
import 'package:academity_app/views/Profile/profile_screen.dart';
import 'package:academity_app/views/Profile/users_profile_screen.dart';
import 'package:academity_app/views/Schedule/schedule_screen.dart';
import 'package:academity_app/views/auth/signup_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:academity_app/views/landing_page.dart';
import 'package:academity_app/views/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:academity_app/views/auth/login_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginScreen(),
        '/browseSports': (context) => const MainScreen(),
        '/signup': (context) => const SignupScreen(),
        '/userProfile': (context) => const UserProfileScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    const SportsPage(), // Your actual HomePage widget
    const MyAcademyPage(), // Your actual AcademyPage widget
    // QRScannerPage(), // Your actual QRScannerPage widget or handle differently
    const SchedulePage(), // Your actual SchedulePage widget
    const ProfilePage(), // Your actual ProfilePage widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
