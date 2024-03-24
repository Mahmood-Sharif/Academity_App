import 'dart:async';

import 'package:academity_app/views/MyAcademy/my_academy_screen.dart';
import 'package:academity_app/views/Profile/profile_screen.dart';
import 'package:academity_app/views/Profile/users_profile_screen.dart';
import 'package:academity_app/views/Schedule/schedule_screen.dart';
import 'package:academity_app/views/attendance/qr_scanner_page.dart';
import 'package:academity_app/views/auth/signup_screen.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:academity_app/views/landing_page.dart';
import 'package:academity_app/views/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:academity_app/views/auth/login_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
  MobileScannerController qrController = MobileScannerController(
    autoStart: false,
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void initState() {
    super.initState();
    unawaited(qrController.stop()); // stop the camera on startup
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // only activate the camera when its page is visible
      if (_selectedIndex == 2) {
        unawaited(qrController.start());
      } else {
        unawaited(qrController.stop());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const SportsPage(),
          const MyAcademyPage(),
          QRScannerPage(controller: qrController),
          const SchedulePage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    qrController.dispose();
  }
}
