import 'dart:async';

import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/services/student_service.dart';
import 'package:academity_app/views/home/student_details.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsListWidget extends ConsumerWidget {
  final int classId;

  const StudentsListWidget({super.key, required this.classId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: StudentServices().fetchStudentsByClassId(classId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          final students = asyncSnapshot.requireData;
          if (students.isEmpty) {
            return const AppEmptyState(
              icon: Icons.person_search_rounded,
              title: 'No students enrolled',
              body: 'Students will appear here after enrollment.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 28),
            itemCount: students.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final student = students[index];
              return AppCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentDetailsScreen(),
                      settings: RouteSettings(arguments: student),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.brand.withValues(alpha: .1),
                      child: Text(
                        student.name.isEmpty
                            ? '?'
                            : student.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.brand,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            student.phone,
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
          return const AppLoadingState(label: 'Loading students');
        }
      },
    );
  }
}
