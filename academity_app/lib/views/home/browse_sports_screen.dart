import 'package:academity_app/design/app_theme.dart';
import 'dart:async';

import 'package:academity_app/services/sports_services.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:academity_app/views/widgets/section_header.dart';
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
            return const AppLoadingState(label: 'Loading sports');
          }

          if (snapshot.hasError) {
            final error = snapshot.error!;
            if (error.runtimeType == TimeoutException) {
              return const AppEmptyState(
                icon: Icons.wifi_off_rounded,
                title: 'Connection timeout',
                body: 'Please check your internet connection and try again.',
              );
            }
            return AppErrorState(error: error);
          }

          final sports = snapshot.data ?? [];
          if (sports.isEmpty) {
            return AppEmptyState(
              icon: Icons.sports_soccer_rounded,
              title: AppLocalizations.of(context)!.noSportsAvailable,
              body: 'New academies will appear here once they are published.',
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  boxShadow: AppShadows.soft,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your sports marketplace',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  height: 1.08,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Compare academies, classes, prices, and schedules in one place.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: .78),
                                  height: 1.45,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: const Icon(
                        Icons.sports_score_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(
                title: 'Choose a sport',
                subtitle:
                    'Start with what you love. Academies are grouped by sport for quick browsing.',
              ),
              SportsListWidget(sports: sports),
            ],
          );
        },
      ),
    );
  }
}
