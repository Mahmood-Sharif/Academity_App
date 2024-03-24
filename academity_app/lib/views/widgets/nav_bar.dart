import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
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
          label: 'Home',
          activeIcon: Icon(Icons.home),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.shield_outlined),
          label: 'My Academy',
          activeIcon: Icon(Icons.shield_rounded),
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 48, // Increase the width for a larger circle
            height: 48, // Increase the height for a larger circle
            decoration: const BoxDecoration(
              color: Color(0xffff3200),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.qr_code_scanner, color: Colors.white),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Schedule',
          activeIcon: Icon(Icons.calendar_today),
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
