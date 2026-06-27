import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showLanguageSelectionBottomSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Choose language',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: AppSpacing.md),
              _LanguageTile(
                label: 'English',
                icon: Icons.language_rounded,
                onTap: () {
                  ref.read(languageProvider.notifier).switchLanguage('en');
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              _LanguageTile(
                label: 'العربية',
                icon: Icons.translate_rounded,
                onTap: () {
                  ref.read(languageProvider.notifier).switchLanguage('ar');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _LanguageTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: const BorderSide(color: AppColors.line),
      ),
      leading: Icon(icon, color: AppColors.teal),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}
