import 'dart:async';

import 'package:academity_app/services/sports_services.dart';
import 'package:academity_app/views/home/widgets/sport/cards_widget.dart';
import 'package:academity_app/views/home/widgets/sport/offers_widget.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/home/widgets/sport/sports_griview.dart';
import 'package:academity_app/models/sport.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  final SportsService _sportsService = SportsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.exploreTitle,
        showBackButton: false, // Ensures the back button is not shown
      ),
      body: AdaptivePadding(
        child: FutureBuilder<List<Sport>>(
          future: _sportsService.fetchSports(),
          builder: (BuildContext context, AsyncSnapshot<List<Sport>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final error = snapshot.error!;
              if (error.runtimeType == TimeoutException) {
                return const Center(
                  child: Text(
                    'Connection Timeout.\nPlease check your internet connection.',
                    maxLines: 5,
                  ),
                );
              } else {
                return Center(child: Text('Error: $error'));
              }
            } else if (snapshot.hasData) {
              return ListView(
      padding: const EdgeInsets.all(16.0), // Add padding around the entire list
      children: [
        const Text(
          'Select Your Next Journey',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SportsListWidget(sports: snapshot.data!),
        const Text(
          'Your Upcoming Classes',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const TwoCardsSideBySide(),
        const SizedBox(height: 8,),
        const Text(
          'Offers and Discounts',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const OffersWidget(),
      ],
    );
            } else {
              // This case handles empty data
              return Center(
                  child: Text(AppLocalizations.of(context)!.noSportsAvailable));
            }
          },
        ),
      ),
    );
  }
}
