import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/providers/academy_provider.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _showReferralCodeDialog(context, ref),
            icon: const Icon(Icons.how_to_reg_rounded),
            label: Text(AppLocalizations.of(context)!.registerButtonText),
          ),
        );
      },
    );
  }

  void _showReferralCodeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          title: Text(
            AppLocalizations.of(context)!.enterReferralCodeDialogTitle,
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.referralCodeHint,
              prefixIcon: const Icon(Icons.confirmation_number_outlined),
            ),
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.characters,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancelButtonText),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FilledButton(
              child: Text(AppLocalizations.of(context)!.submitButtonText),
              onPressed: () async {
                AcademyServices()
                    .enrollStudentWithCode(controller.text.trim())
                    .whenComplete(() {
                  if (!context.mounted) return;
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                }).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!
                            .successfullyEnrolledMessage(controller.text),
                      ),
                    ),
                  );
                  ref.invalidate(enrolledAcademiesProvider);
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.toString())),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
