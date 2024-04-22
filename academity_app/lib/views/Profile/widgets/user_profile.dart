import 'package:academity_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/users.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  final User user;

  const UserProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  late User _editableUser;

  @override
  void initState() {
    super.initState();
    _editableUser = widget.user; // No need to copy since User is immutable
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color(0xFF008B8B);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildUserInputField(
                  AppLocalizations.of(context)!.fullNameLabel,
                  _editableUser.name,
                  Icons.person,
                  customColor,
                  (val) => _updateUserField('name', val)),
              _buildUserInputField(
                  AppLocalizations.of(context)!.emailLabel,
                  _editableUser.email ?? '',
                  Icons.email,
                  customColor,
                  (val) => _updateUserField('email', val)),
              _buildUserInputField(
                  AppLocalizations.of(context)!.phoneNumberLabel,
                  _editableUser.phone,
                  Icons.phone,
                  customColor,
                  (val) => _updateUserField('phone', val)),
              // For Date of Birth, consider using a DatePicker instead of a TextFormField
              _buildUserInputField(
                  AppLocalizations.of(context)!.dobLabel,
                  _formatDate(_editableUser.dob),
                  Icons.cake,
                  customColor,
                  (val) => _updateUserField('dob', val)),
              _buildUserInputField(
                  AppLocalizations.of(context)!.genderLabel,
                  _editableUser.gender,
                  Icons.male,
                  customColor,
                  (val) => _updateUserField('gender', val)),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInputField(String label, String initialValue, IconData icon,
      Color customColor, Function(String) onSaved) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: customColor),
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon, color: customColor),
          ),
          onSaved: (val) => onSaved(val ?? ''),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid $label';
            }
            return null;
          },
        ));
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _saveUserProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF3200), // Button background color
          padding: const EdgeInsets.symmetric(
              horizontal: 42, vertical: 10), // Makes the button a bit bigger
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Slightly rounded edges
          ),
        ),
        child: Text(AppLocalizations.of(context)!.saveButton,
            style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  void _saveUserProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      try {
        final success =
            await ref.read(authProvider.notifier).updateProfile(_editableUser);
        if (!context.mounted) return;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.profileUpdatedSuccess)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.profileUpdateFailed)));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _updateUserField(String field, String value) {
    setState(() {
      // Assuming User has a copyWith method to handle immutability
      _editableUser = _editableUser.copyWith(
        name: field == 'name' ? value : _editableUser.name,
        email: field == 'email' ? value : _editableUser.email,
        phone: field == 'phone' ? value : _editableUser.phone,
        gender: field == 'gender' ? value : _editableUser.gender,
        // Add other fields as necessary
      );
    });
  }

  String _formatDate(DateTime date) {
    // Formatting date as yyyy-MM-dd
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
