import 'package:academity_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showLanguageSelectionBottomSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      // Ensure you have a ProviderScope ancestor in your widget tree.
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.language),
                title: const Text('English'),
                onTap: () {
                  // Using context.read() for actions that don't require rebuilding the UI when the state changes.
                  ref.read(languageProvider.notifier).switchLanguage('en');
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.language),
                title: const Text('العربية'),
                onTap: () {
                  ref.read(languageProvider.notifier).switchLanguage('ar');
                  Navigator.pop(context);
                }),
          ],
        ),
      );
    },
  );
}
