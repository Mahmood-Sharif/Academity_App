import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoachBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CoachBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Schedule',
          activeIcon: Icon(Icons.home),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.people_outline_rounded),
          label: 'Students',
          activeIcon: Icon(Icons.people_rounded),
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xffff3200),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.qr_code_scanner, color: Colors.white),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
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
