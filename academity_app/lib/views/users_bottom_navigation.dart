import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/providers/class_provider.dart';
import 'package:academity_app/views/Profile/profile_screen.dart';
import 'package:academity_app/views/Schedule/schedule_screen.dart';
import 'package:academity_app/views/my_academy/my_academy_screen.dart';
import 'package:academity_app/views/attendance/qr_scanner_page.dart';
import 'package:academity_app/views/home/browse_sports_screen.dart';
import 'package:academity_app/views/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersBottomNavigation extends ConsumerStatefulWidget {
  const UsersBottomNavigation({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<UsersBottomNavigation> {
  int _selectedIndex = 0;
  bool _qrScannerActive = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // only activate the camera when its page is visible
      if (_selectedIndex == 2) {
        _qrScannerActive = true;
      } else {
        _qrScannerActive = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider);
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const SportsPage(),
          const MyAcademyPage(),
          QRScannerPage(active: _qrScannerActive),
          SchedulePage(scheduleProvider: scheduleForStudentProvider),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
