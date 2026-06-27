// ignore_for_file: unused_element

import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/models/users.dart';
import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/Profile/widgets/delete_popup.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  final User user;

  const UserProfileWidget({super.key, required this.user});

  @override
  ConsumerState<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  late User _editableUser;

  @override
  void initState() {
    super.initState();
    _editableUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          AppCard(
            color: AppColors.navy,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white.withValues(alpha: .16),
                  child: Text(
                    _editableUser.name.isEmpty
                        ? 'A'
                        : _editableUser.name.substring(0, 1).toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                        _editableUser.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _editableUser.email ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                _buildUserInputField(
                  AppLocalizations.of(context)!.fullNameLabel,
                  _editableUser.name,
                  Icons.person_outline_rounded,
                  (val) => _updateUserField('name', val),
                ),
                _buildUserInputField(
                  AppLocalizations.of(context)!.emailLabel,
                  _editableUser.email ?? '',
                  Icons.email_outlined,
                  (val) => _updateUserField('email', val),
                ),
                _buildUserInputField(
                  AppLocalizations.of(context)!.phoneNumberLabel,
                  _editableUser.phone,
                  Icons.phone_outlined,
                  (val) => _updateUserField('phone', val),
                ),
                _buildUserInputField(
                  AppLocalizations.of(context)!.dobLabel,
                  _formatDate(_editableUser.dob),
                  Icons.cake_outlined,
                  (val) => _updateUserField('dob', val),
                ),
                _buildUserInputField(
                  AppLocalizations.of(context)!.genderLabel,
                  _editableUser.gender,
                  Icons.badge_outlined,
                  (val) => _updateUserField('gender', val),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveUserProfile,
                    icon: const Icon(Icons.save_rounded),
                    label: Text(AppLocalizations.of(context)!.saveButton),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => const DeletePopUp(),
              );
            },
            icon: const Icon(Icons.delete_outline_rounded),
            label: Text(
              AppLocalizations.of(context)!.delectAccountActionTitle,
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildUserInputField(
    String label,
    String initialValue,
    IconData icon,
    Function(String) onSaved,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.teal),
        ),
        onSaved: (val) => onSaved(val ?? ''),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid $label';
          }
          return null;
        },
      ),
    );
  }

  void _saveUserProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      await ref
          .read(authProvider.notifier)
          .updateProfile(_editableUser)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.profileUpdatedSuccess,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.profileUpdateFailed,
              ),
            ),
          );
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      });
    }
  }

  void _updateUserField(String field, String value) {
    setState(() {
      _editableUser = _editableUser.copyWith(
        name: field == 'name' ? value : _editableUser.name,
        email: field == 'email' ? value : _editableUser.email,
        phone: field == 'phone' ? value : _editableUser.phone,
        gender: field == 'gender' ? value : _editableUser.gender,
      );
    });
  }

  void _getImage(ImageSource source) async {
    final picker = ImagePicker();
    await picker.pickImage(source: source);
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
