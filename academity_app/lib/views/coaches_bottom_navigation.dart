import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/providers/class_provider.dart';
import 'package:academity_app/views/Profile/profile_screen.dart';
import 'package:academity_app/views/Schedule/schedule_screen.dart';
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
          SchedulePage(
            daysBefore: 7,
            daysAfter: 7,
            scheduleProvider: scheduleForCoachProvider,
            onTap: (schedule) {
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              final classtime =
                  DateTime.parse('${schedule.date}T${schedule.startTime}');
              if (DateTime.parse(schedule.date).compareTo(today) <= 0) {
                // schedule is today or before
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AttendancePage(
                        classId: schedule.classId, datetime: classtime)));
              } else {
                // schedule is in the future
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('The class has not begun yet')));
              }
            },
          ),
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
