import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:academity_app/views/widgets/app_network_image.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:academity_app/views/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class MySubscriptionDetails extends StatelessWidget {
  final Academy academy;

  const MySubscriptionDetails({super.key, required this.academy});

  @override
  Widget build(BuildContext context) {
    final classes = academy.classes ?? [];

    return ListView(
      children: [
        Stack(
          children: [
            AppNetworkImage(
              url: academy.imageUrl,
              width: double.infinity,
              height: 220,
              radius: AppRadii.lg,
              fallbackIcon: Icons.school_rounded,
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Text(
                academy.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: .45),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(
          title: 'Active classes',
          subtitle:
              'Your enrollment dates, renewal timeline, and current price.',
          trailing: Text(
            '${classes.length}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.brand,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
        if (classes.isEmpty)
          const AppEmptyState(
            icon: Icons.event_busy_rounded,
            title: 'No active classes',
            body: 'Your active subscriptions will appear here.',
          )
        else
          ...classes.map((classDetail) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.brand.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),
                          child: const Icon(
                            Icons.fitness_center_rounded,
                            color: AppColors.brand,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            classDetail.className,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _DetailLine(
                      label:
                          AppLocalizations.of(context)!.registrationDateLabel,
                      value: classDetail.getFormattedStartDate(),
                    ),
                    _DetailLine(
                      label: AppLocalizations.of(context)!.renewalDateLabel,
                      value: classDetail.getFormattedEndDate(),
                    ),
                    _DetailLine(
                      label: 'Price',
                      value: AppLocalizations.of(context)!
                          .priceTitle(classDetail.price),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}

class _DetailLine extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}
