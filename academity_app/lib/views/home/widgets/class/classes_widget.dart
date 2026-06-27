import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/views/home/widgets/class/class_details.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:flutter/material.dart';

class ClassesWidget extends StatelessWidget {
  final Academy academy;
  final List<Classes> classes;

  const ClassesWidget({
    super.key,
    required this.academy,
    required this.classes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: classes.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final classItem = classes[index];
        return AppCard(
          onTap: () => showClassDetails(context, classItem.classId),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.brand.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.brand,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classItem.className,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ages ${classItem.minAge}-${classItem.maxAge}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.muted,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
            ],
          ),
        );
      },
    );
  }
}
