import 'dart:async';

import 'package:academity_app/services/sports_services.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/home/widgets/sport/sports_griview.dart';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class SportsPage extends StatefulWidget {
  final bool showBackButton;

  const SportsPage({super.key, this.showBackButton = false});

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
        showBackButton: widget.showBackButton,
      ),
      body: FutureBuilder<List<Sport>>(
        future: _sportsService.fetchSports(),
        builder: (BuildContext context, AsyncSnapshot<List<Sport>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error!;
            if (error.runtimeType == TimeoutException) {
              return const _BrowseMessage(
                icon: Icons.wifi_off_rounded,
                title: 'Connection timeout',
                body: 'Please check your internet connection and try again.',
              );
            }
            return _BrowseMessage(
              icon: Icons.error_outline_rounded,
              title: 'Something went wrong',
              body: error.toString(),
            );
          }

          final sports = snapshot.data ?? [];
          if (sports.isEmpty) {
            return _BrowseMessage(
              icon: Icons.sports_soccer_rounded,
              title: AppLocalizations.of(context)!.noSportsAvailable,
              body: 'New academies will appear here once they are published.',
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            children: [
              Text(
                'Select your next journey',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF2B1D1A),
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Browse sports, compare academies, and keep training on schedule.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 18),
              SportsListWidget(sports: sports),
            ],
          );
        },
      ),
    );
  }
}

class _BrowseMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _BrowseMessage({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFFF3200), size: 44),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                    height: 1.35,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
