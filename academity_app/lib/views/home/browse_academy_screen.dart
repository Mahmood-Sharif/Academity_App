import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/views/home/widgets/academy/academy_list_widget.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class BrowseAcademyScreen extends StatelessWidget {
  final Sport sport; // Holds the Sport object for the selected sport

  const BrowseAcademyScreen({
    super.key,
    required this.sport,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.sportTitle(sport.sportName
            .toLowerCase()), // Correctly display the sport's name in the app bar
        subtitle: 'Academies, classes, and prices',
      ),
      body: AdaptivePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: '${sport.sportName} academies',
              subtitle:
                  'Choose a place that matches your schedule, age group, and training goals.',
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.canvas,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: AcademiesListWidget(sportId: sport.sportsId),
              ),
            ),
          ],
        ),
      ), // Pass the sportId to the list widget
    );
  }
}
