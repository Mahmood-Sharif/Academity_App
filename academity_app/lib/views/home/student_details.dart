import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = ModalRoute.of(context)?.settings.arguments as Student?;
    if (student == null) {
      return Scaffold(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.studentDetailsTitle,
        ),
        body: const Center(child: Text('Student not found')),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.studentDetailsTitle,
        subtitle: student.name,
      ),
      body: AdaptivePadding(
        child: ListView(
          children: [
            AppCard(
              color: AppColors.navy,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white.withValues(alpha: .15),
                    child: Text(
                      student.name.isEmpty
                          ? '?'
                          : student.name.substring(0, 1).toUpperCase(),
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
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
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          student.phone,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              child: Column(
                children: [
                  _DetailRow(
                    label: AppLocalizations.of(context)!.studentName,
                    value: student.name,
                    icon: Icons.person_outline_rounded,
                  ),
                  _DetailRow(
                    label: AppLocalizations.of(context)!.studentPhone,
                    value: student.phone,
                    icon: Icons.phone_outlined,
                  ),
                  _DetailRow(
                    label: AppLocalizations.of(context)!.registrationDateLabel,
                    value: student.startDate,
                    icon: Icons.event_available_outlined,
                  ),
                  _DetailRow(
                    label: AppLocalizations.of(context)!.renewalDateLabel,
                    value: student.endDate,
                    icon: Icons.update_rounded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              color: AppColors.danger.withValues(alpha: .08),
              child: _DetailRow(
                label: AppLocalizations.of(context)!.medicalCondition,
                value: student.medicalCondition ??
                    AppLocalizations.of(context)!.medicalConditionNone,
                icon: Icons.medical_information_outlined,
                showDivider: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool showDivider;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.teal.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(AppRadii.sm),
              ),
              child: Icon(icon, color: AppColors.teal),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Divider(height: 1),
          ),
      ],
    );
  }
}
