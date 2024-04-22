import 'package:academity_app/models/sport.dart';
import 'package:academity_app/views/home/widgets/academy/academy_list_widget.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BrowseAcademyScreen extends StatelessWidget {
  final Sport sport; // Holds the Sport object for the selected sport

  const BrowseAcademyScreen({
    Key? key,
    required this.sport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.sportTitle(sport.sportName
            .toLowerCase()), // Correctly display the sport's name in the app bar
      ),
      body: AcademiesListWidget(
          sportId: sport.sportsId), // Pass the sportId to the list widget
    );
  }
}
