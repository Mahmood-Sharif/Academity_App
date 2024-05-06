import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:academity_app/services/errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import the AuthServices

class DeletePopUp extends ConsumerStatefulWidget {
  const DeletePopUp({super.key});

  @override
  ConsumerState<DeletePopUp> createState() => _DeletePopUpState();
}

class _DeletePopUpState extends ConsumerState<DeletePopUp> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isDeleteEnabled = false;
  String? _errorText;

  void _updateDeleteButtonState() {
    setState(() {
      _isDeleteEnabled = _passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateDeleteButtonState);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updateDeleteButtonState);
    _passwordController.dispose();
    super.dispose();
  }

  void _deleteAccount() async {
    try {
      await AuthServices.deleteAccount(_passwordController.text).then((_) {
        Navigator.of(context)
          ..pop()
          ..pop();
        ref.read(authProvider.notifier).logout();
      }).whenComplete(() => FocusScope.of(context).unfocus());
    } on LocalizedErrorMessage catch (e) {
      setState(() {
        _errorText = e.localizedMessage(context);
      });
    } catch (_) {
      setState(() {
        _errorText = CouldNotDeleteAccount().localizedMessage(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(25),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: const Text('Are you sure you want to delete your account?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text(
                'By deleting this account, all data associated with the account will be permanently removed. This action cannot be undone.'),
            const SizedBox(height: 16),
            const Text('Your data will be deleted within 14 days.'),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter your password to confirm',
                labelStyle: const TextStyle(fontSize: 14),
                border: const OutlineInputBorder(),
                errorText: _errorText,
                errorMaxLines: 5,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.black87)),
        ),
        TextButton(
          onPressed: _isDeleteEnabled ? _deleteAccount : null,
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
