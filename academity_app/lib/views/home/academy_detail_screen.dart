import 'dart:async';

import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/services/errors.dart';
import 'package:academity_app/views/home/widgets/class/classes_widget.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_network_image.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:academity_app/views/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class AcademyDetailScreen extends ConsumerWidget {
  final Academy academy;

  const AcademyDetailScreen({super.key, required this.academy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classAsync = ClassServices().fetchClassesByAcademyId(
      academy.academyId,
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: academy.name,
        subtitle: academy.location,
      ),
      body: AdaptivePadding(
        child: ListView(
          children: [
            _AcademyHero(academy: academy),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: AppLocalizations.of(context)!.descriptionTitle,
                    subtitle: academy.description,
                    trailing: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.teal.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        color: AppColors.teal,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: AppSpacing.md),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: AppLocalizations.of(context)!.locationLabel(
                      academy.location,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _InfoRow(
                    icon: Icons.phone_outlined,
                    label: academy.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(
              title: AppLocalizations.of(context)!.classesTitle,
              subtitle:
                  'Review age ranges, timings, and prices before registering.',
            ),
            FutureBuilder<List<Classes>>(
              future: classAsync,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 220,
                    child: AppLoadingState(label: 'Loading classes'),
                  );
                }
                if (snapshot.hasError) {
                  return switch (snapshot.error) {
                    NotFound() => AppEmptyState(
                        icon: Icons.event_busy_rounded,
                        title: AppLocalizations.of(context)!.noClassesAvailable,
                        body: 'This academy has not published classes yet.',
                      ),
                    TimeoutException() => const AppEmptyState(
                        icon: Icons.wifi_off_rounded,
                        title: 'Connection timeout',
                        body: 'Please check your connection and try again.',
                      ),
                    _ => AppErrorState(error: snapshot.error!),
                  };
                }
                final classes = snapshot.data ?? [];
                if (classes.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.event_busy_rounded,
                    title: AppLocalizations.of(context)!.noClassesAvailable,
                    body: 'This academy has not published classes yet.',
                  );
                }
                return ClassesWidget(academy: academy, classes: classes);
              },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _AcademyHero extends StatelessWidget {
  final Academy academy;

  const _AcademyHero({required this.academy});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppNetworkImage(
          url: academy.imageUrl,
          width: double.infinity,
          height: 270,
          radius: AppRadii.lg,
          fallbackIcon: Icons.emoji_events_rounded,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.lg),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: .72),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 18,
          right: 18,
          bottom: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .16),
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .24),
                  ),
                ),
                child: const Text(
                  'Featured academy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                academy.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.brand),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}
