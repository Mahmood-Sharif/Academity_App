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
    final navLabelStyle = Theme.of(context).textTheme.labelSmall;

    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: .06),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarTheme.of(context).copyWith(
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              size: states.contains(WidgetState.selected) ? 22 : 21,
            ),
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) =>
                navLabelStyle?.copyWith(
                  fontSize: 9.4,
                  height: 1.05,
                  fontWeight: states.contains(WidgetState.selected)
                      ? FontWeight.w800
                      : FontWeight.w700,
                  color: states.contains(WidgetState.selected)
                      ? AppColors.brand
                      : AppColors.muted,
                ) ??
                TextStyle(
                  fontSize: 9.4,
                  height: 1.05,
                  fontWeight: states.contains(WidgetState.selected)
                      ? FontWeight.w800
                      : FontWeight.w700,
                  color: states.contains(WidgetState.selected)
                      ? AppColors.brand
                      : AppColors.muted,
                ),
          ),
        ),
        child: NavigationBar(
          height: 66,
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
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.brandDark : AppColors.brand,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.brand.withValues(alpha: .20),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(
        Icons.qr_code_scanner_rounded,
        color: Colors.white,
        size: 21,
      ),
    );
  }
}
