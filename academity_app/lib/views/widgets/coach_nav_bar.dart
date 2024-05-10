import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoachBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CoachBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule_outlined),
          label: 'Schedule &\nAttendance',
          activeIcon: Icon(Icons.schedule),
        ),
        /* BottomNavigationBarItem( */
        /*   icon: Icon(Icons.checklist_outlined), */
        /*   label: 'Attendance', */
        /*   activeIcon: Icon(Icons.checklist), */
        /* ), */
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline_rounded),
          label: 'Students',
          activeIcon: Icon(Icons.people_rounded),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
          activeIcon: Icon(Icons.person),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFF8B0000),
      onTap: onItemSelected,
      selectedLabelStyle: GoogleFonts.montserrat(
        // Montserrat for selected labels
        fontWeight: FontWeight.w300,
      ),
      unselectedLabelStyle: GoogleFonts.montserrat(
        // Montserrat for unselected labels
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
