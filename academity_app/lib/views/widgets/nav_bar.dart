import 'package:academity_app/design/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
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
        indicatorColor: AppColors.brand.withValues(alpha: .12),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: onItemSelected,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.explore_outlined),
            selectedIcon: const Icon(Icons.explore_rounded),
            label: AppLocalizations.of(context)!.exploreTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.shield_outlined),
            selectedIcon: const Icon(Icons.shield_rounded),
            label: AppLocalizations.of(context)!.myAcademyTitle,
          ),
          NavigationDestination(
            icon: _ScanIcon(isSelected: selectedIndex == 2),
            label: 'QR',
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon: const Icon(Icons.calendar_today_rounded),
            label: AppLocalizations.of(context)!.scheduleTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: AppLocalizations.of(context)!.profileActionTitle,
          ),
        ],
      ),
    );
  }
}

class _ScanIcon extends StatelessWidget {
  final bool isSelected;

  const _ScanIcon({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF8B0000) : const Color(0xFFFF3200),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF3200).withValues(alpha: .24),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
    );
  }
}
