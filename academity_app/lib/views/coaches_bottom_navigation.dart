import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/providers/class_provider.dart';
import 'package:academity_app/views/Profile/profile_screen.dart';
import 'package:academity_app/views/Schedule/schedule_screen.dart';
import 'package:academity_app/views/home/QRCodePage.dart';
import 'package:academity_app/views/home/browse_academies.dart';
import 'package:academity_app/views/home/attendance.dart';
import 'package:academity_app/views/widgets/coach_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoachesBottomNavigation extends ConsumerStatefulWidget {
  const CoachesBottomNavigation({Key? key}) : super(key: key);

  @override
  ConsumerState<CoachesBottomNavigation> createState() =>
      _CoachesBottomNavigationState();
}

class _CoachesBottomNavigationState
    extends ConsumerState<CoachesBottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider);
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          SchedulePage(scheduleProvider: scheduleForCoachProvider),
          const GenerateQrCodePage(),
          const CoachAcademiesPage(),
          const ProfilePage()
        ],
      ),
      bottomNavigationBar: CoachBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
