import 'dart:async';

import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/views/home/class_students.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoachClassListWidget extends ConsumerWidget {
  final int academyId;
  final String? academyName;

  const CoachClassListWidget({
    super.key,
    required this.academyId,
    this.academyName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ClassServices().fetchClassesByAcademyId(academyId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          final classes = asyncSnapshot.requireData;
          if (classes.isEmpty) {
            return const AppEmptyState(
              icon: Icons.event_busy_rounded,
              title: 'No classes',
              body: 'Classes assigned to this academy will appear here.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 28),
            itemCount: classes.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final classItem = classes[index];
              return AppCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassStudentsPage(
                        classId: classItem.classId,
                        className: classItem.className,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.teal.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        color: AppColors.teal,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classItem.className,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            academyName ?? '',
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
          final error = asyncSnapshot.error!;
          if (error.runtimeType == TimeoutException) {
            return const AppEmptyState(
              icon: Icons.wifi_off_rounded,
              title: 'Connection timeout',
              body: 'Please check your internet connection and try again.',
            );
          }
          return AppErrorState(error: error);
        } else {
          return const AppLoadingState(label: 'Loading classes');
        }
      },
    );
  }
}
