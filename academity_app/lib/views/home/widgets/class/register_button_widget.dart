import 'package:academity_app/providers/academy_provider.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Center(
            child: ElevatedButton(
              onPressed: () => _showReferralCodeDialog(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFFF3200), // Button background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 10), // Makes the button a bit bigger
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // Slightly rounded edges
                ),
              ),
              child: const Text('Register',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        );
      },
    );
  }

  void _showReferralCodeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Enter Referral Code'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Referral Code',
            ),
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.characters,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                AcademyServices()
                    .enrollStudentWithCode(controller.text)
                    .whenComplete(() {
                  if (!context.mounted) return;
                  Navigator.of(context)
                    ..pop()
                    ..pop(); // Close the dialog
                }).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Successfully enrolled with code ${controller.text}')),
                  );
                  ref.invalidate(
                      enrolledAcademiesProvider); // refresh my academies provider
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.message)),
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
