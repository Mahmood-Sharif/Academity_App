import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        BottomNavigationBarItem(
          icon: const Icon(Icons.explore_outlined),
          label: AppLocalizations.of(context)!.exploreTitle,
          activeIcon: const Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shield_outlined),
          label: AppLocalizations.of(context)!.myAcademyTitle,
          activeIcon: const Icon(Icons.shield_rounded),
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
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today_outlined),
          label: AppLocalizations.of(context)!.scheduleTitle,
          activeIcon: const Icon(Icons.calendar_today),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: AppLocalizations.of(context)!.profileActionTitle,
          activeIcon: const Icon(Icons.person),
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
