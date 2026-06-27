import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const SectionCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1),
            ...items.map(
              (item) {
                final onTap = item.containsKey('onTap')
                    ? item['onTap'] as void Function()?
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item['title']} clicked')),
                        );
                      };
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.brand.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(AppRadii.sm),
                    ),
                    child: Icon(item['icon'], color: AppColors.brand),
                  ),
                  title: Text(
                    item['title'],
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.muted,
                  ),
                  onTap: onTap,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
