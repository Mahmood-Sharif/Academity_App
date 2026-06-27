import 'dart:async';

import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/views/home/widgets/class/register_button_widget.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:academity_app/l10n/app_localizations.dart';

void showClassDetails(BuildContext context, int classId) {
  final classFuture = ClassServices().fetchClassDetails(classId);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: .72,
      minChildSize: .45,
      maxChildSize: .92,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: FutureBuilder<Classes>(
          future: classFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoadingState(label: 'Loading class details');
            }
            if (snapshot.hasError) {
              final error = snapshot.error!;
              if (error.runtimeType == TimeoutException) {
                return const AppEmptyState(
                  icon: Icons.wifi_off_rounded,
                  title: 'Connection timeout',
                  body: 'Please check your connection and try again.',
                );
              }
              return AppErrorState(error: error);
            }
            if (!snapshot.hasData) {
              return AppEmptyState(
                icon: Icons.event_busy_rounded,
                title: AppLocalizations.of(context)!.noClassesAvailable,
                body: 'Class details are not available right now.',
              );
            }

            final classItem = snapshot.requireData;
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.line,
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.brand.withValues(alpha: .11),
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: const Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.brand,
                        size: 30,
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
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ages ${classItem.minAge}-${classItem.maxAge}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.muted,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.navy, AppColors.teal],
                    ),
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.payments_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!
                              .priceTitle(classItem.price),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  AppLocalizations.of(context)!.trainingDaysTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (classItem.timings.isEmpty)
                  AppEmptyState(
                    icon: Icons.schedule_outlined,
                    title: AppLocalizations.of(context)!.noTimingsAvailable,
                    body:
                        'The academy has not published a timetable for this class.',
                  )
                else
                  ...classItem.timings.map((timing) {
                    final startTime =
                        DateFormat('HH:mm:ss').parse(timing.startTime);
                    final endTime =
                        DateFormat('HH:mm:ss').parse(timing.endTime);
                    return Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadii.md),
                        border: Border.all(color: AppColors.line),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: .15),
                              borderRadius: BorderRadius.circular(AppRadii.sm),
                            ),
                            child: const Icon(
                              Icons.calendar_month_rounded,
                              color: AppColors.warning,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  timing.dayOfWeek,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)}',
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
                        ],
                      ),
                    );
                  }),
                const SizedBox(height: AppSpacing.md),
                const RegisterButtonWidget(),
              ],
            );
          },
        ),
      ),
    ),
  );
}
