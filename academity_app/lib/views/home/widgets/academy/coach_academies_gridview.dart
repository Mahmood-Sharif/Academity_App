import 'dart:async';

import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:academity_app/services/errors.dart';
import 'package:academity_app/views/home/coach_classes.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_network_image.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoachAcademiesListWidget extends ConsumerWidget {
  const CoachAcademiesListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: AcademyServices().fetchAcademiesByCoachId(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          final academies = asyncSnapshot.requireData;
          if (academies.isEmpty) {
            return const AppEmptyState(
              icon: Icons.school_outlined,
              title: 'No academies assigned',
              body: 'Your coach academies will appear here.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 28),
            itemCount: academies.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final academy = academies[index];
              return AppCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoachClassesPage(
                        academyId: academy.academyId,
                        academyName: academy.name,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppNetworkImage(
                      url: academy.imageUrl,
                      width: 76,
                      height: 76,
                      radius: AppRadii.md,
                      fallbackIcon: Icons.school_rounded,
                    ),
                    const SizedBox(width: AppSpacing.md),
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
                            academy.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.muted,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.muted),
                  ],
                ),
              );
            },
          );
        } else if (asyncSnapshot.hasError) {
          if (asyncSnapshot.error!.runtimeType == TimeoutException ||
              asyncSnapshot.error!.runtimeType == NotFound) {
            return const AppEmptyState(
              icon: Icons.school_outlined,
              title: 'No academies',
              body: 'Your academy assignments will appear here.',
            );
          }
          return AppErrorState(error: asyncSnapshot.error!);
        } else {
          return const AppLoadingState(label: 'Loading academies');
        }
      },
    );
  }
}
