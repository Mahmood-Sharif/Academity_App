import 'package:academity_app/design/app_theme.dart';
import 'package:flutter/material.dart';

class CoachBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CoachBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: NavigationBar(
        height: 68,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedIndex: selectedIndex,
        indicatorColor: AppColors.teal.withValues(alpha: .13),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: onItemSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today_rounded),
            label: 'Schedule',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Classes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
