import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/errors.dart';
import 'package:academity_app/views/my_academy/subscription_screen.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_network_image.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/providers/academy_provider.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class EnrolledAcademiesListWidget extends ConsumerWidget {
  const EnrolledAcademiesListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledAcademiesAsyncValue = ref.watch(enrolledAcademiesProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(enrolledAcademiesProvider.future),
      child: enrolledAcademiesAsyncValue.when(
        data: (List<Academy> academies) {
          if (academies.isEmpty) {
            return ListView(
              children: [
                AppEmptyState(
                  icon: Icons.shield_outlined,
                  title: AppLocalizations.of(context)!.notEnrolledMessage,
                  body:
                      'Enroll in a class to see your academy membership, renewal dates, and schedule.',
                ),
              ],
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 28),
            itemCount: academies.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final academy = academies[index];
              final activeClasses = academy.classes?.length ?? 0;

              return AppCard(
                padding: EdgeInsets.zero,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SubscriptionScreen(academy: academy),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppNetworkImage(
                      url: academy.imageUrl,
                      width: double.infinity,
                      height: 170,
                      radius: AppRadii.md,
                      fallbackIcon: Icons.school_rounded,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  academy.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  AppLocalizations.of(context)!
                                      .locationLabel(academy.location),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.muted,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.teal.withValues(alpha: .1),
                              borderRadius:
                                  BorderRadius.circular(AppRadii.pill),
                            ),
                            child: Text(
                              '$activeClasses active',
                              style: const TextStyle(
                                color: AppColors.teal,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const AppLoadingState(label: 'Loading memberships'),
        error: (error, stack) {
          if (error is NotFound) {
            return ListView(
              children: [
                AppEmptyState(
                  icon: Icons.shield_outlined,
                  title: AppLocalizations.of(context)!.notEnrolledMessage,
                  body:
                      'Enroll in a class to see your academy membership, renewal dates, and schedule.',
                ),
              ],
            );
          }

          return AppErrorState(error: error);
        },
      ),
    );
  }
}
