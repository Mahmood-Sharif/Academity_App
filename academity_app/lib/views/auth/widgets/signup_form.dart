import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';

enum Gender { male, female }

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _isSubmitting = false;

  String email = '';
  String password = '';
  String passwordConfirm = '';
  String name = '';
  String phone = '';
  Gender? _gender = Gender.male;
  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year - 3;
  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years =
      List.generate(80, (index) => DateTime.now().year - 3 - index);

  String? emailError;
  String? nameError;
  String? phoneError;
  String? passwordError;
  String? passwordConfirmError;

  Future<void> attemptSignUp() async {
    final isForm1Valid = _formKey1.currentState?.validate() ?? false;
    final isForm2Valid = _formKey2.currentState?.validate() ?? false;

    if (!isForm1Valid || !isForm2Valid) {
      setState(() {
        _currentStep = !isForm1Valid ? 0 : 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            !isForm1Valid
                ? AppLocalizations.of(context)!.formErrorPersonalInfo
                : AppLocalizations.of(context)!.formErrorAccountInfo,
          ),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final RegisterResponse signUpSuccess = await AuthServices.registerUser({
        'email': email,
        'name': name,
        'gender': _gender == Gender.male ? 'Male' : 'Female',
        'phone': phone,
        'dob': DateTime(selectedYear, selectedMonth, selectedDay)
            .toIso8601String(),
        'password': password,
        'password_confirm': passwordConfirm,
      });

      if (signUpSuccess.success) {
        await ref.read(authProvider.notifier).loginTest();
        if (!mounted) return;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.signupSuccessMessage),
          ),
        );
      } else {
        setState(() {
          _currentStep = 0;
          emailError = signUpSuccess.errors?['email'];
          nameError = signUpSuccess.errors?['name'];
          phoneError = signUpSuccess.errors?['phone'];
          passwordError = signUpSuccess.errors?['password'];
          passwordConfirmError = signUpSuccess.errors?['password_confirm'];
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _next() {
    if (_currentStep == 0) {
      final isForm1Valid = _formKey1.currentState?.validate() ?? false;
      if (isForm1Valid) {
        setState(() => _currentStep = 1);
      }
      return;
    }

    attemptSignUp();
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAccountStep = _currentStep == 1;

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepHeader(currentStep: _currentStep),
          const SizedBox(height: AppSpacing.lg),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child:
                isAccountStep ? _accountForm(context) : _personalForm(context),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              if (isAccountStep) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSubmitting ? null : _back,
                    child: Text(AppLocalizations.of(context)!.backButtonText),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                flex: isAccountStep ? 1 : 2,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _next,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          isAccountStep
                              ? AppLocalizations.of(context)!.signUpButton
                              : AppLocalizations.of(context)!
                                  .continueButtonText,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _personalForm(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Column(
        key: const ValueKey('personal'),
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.fullNameLabel,
              errorText: nameError,
              errorMaxLines: 2,
              prefixIcon: const Icon(Icons.person_outline_rounded),
            ),
            onChanged: (value) => name = value,
            validator: (value) => value!.isEmpty
                ? AppLocalizations.of(context)!.signupFailureMessage
                : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.phoneNumberLabel,
              errorText: phoneError,
              errorMaxLines: 2,
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
            onChanged: (value) => phone = value,
            validator: (value) => value!.isEmpty
                ? AppLocalizations.of(context)!.phoneNumberError
                : null,
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppLocalizations.of(context)!.genderLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.slate,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _GenderOption(
                  label: AppLocalizations.of(context)!.maleGender,
                  selected: _gender == Gender.male,
                  onTap: () => setState(() => _gender = Gender.male),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _GenderOption(
                  label: AppLocalizations.of(context)!.femaleGender,
                  selected: _gender == Gender.female,
                  onTap: () => setState(() => _gender = Gender.female),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppLocalizations.of(context)!.dobLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.slate,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _dateDropdown(
                  label: AppLocalizations.of(context)!.dayLabel,
                  value: selectedDay,
                  items: days,
                  onChanged: (value) => setState(() => selectedDay = value),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: _dateDropdown(
                  label: AppLocalizations.of(context)!.monthLabel,
                  value: selectedMonth,
                  items: months,
                  onChanged: (value) => setState(() => selectedMonth = value),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                flex: 2,
                child: _dateDropdown(
                  label: AppLocalizations.of(context)!.yearLabel,
                  value: selectedYear,
                  items: years,
                  onChanged: (value) => setState(() => selectedYear = value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _accountForm(BuildContext context) {
    return Form(
      key: _formKey2,
      child: Column(
        key: const ValueKey('account'),
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.emailLabel,
              errorText: emailError,
              errorMaxLines: 2,
              prefixIcon: const Icon(Icons.alternate_email_rounded),
            ),
            onChanged: (value) => email = value,
            validator: (value) => value!.isEmpty
                ? AppLocalizations.of(context)!.emailError
                : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.passwordLabel,
              errorText: passwordError,
              errorMaxLines: 2,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
            ),
            obscureText: true,
            onChanged: (value) => password = value,
            validator: (value) => value!.isEmpty
                ? AppLocalizations.of(context)!.passwordError
                : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
              errorText: passwordConfirmError,
              errorMaxLines: 2,
              prefixIcon: const Icon(Icons.verified_user_outlined),
            ),
            obscureText: true,
            onChanged: (value) => passwordConfirm = value,
            validator: (value) => value != password
                ? AppLocalizations.of(context)!.confirmPasswordError
                : null,
          ),
        ],
      ),
    );
  }

  DropdownButtonFormField<int> _dateDropdown({
    required String label,
    required int value,
    required List<int> items,
    required ValueChanged<int> onChanged,
  }) {
    return DropdownButtonFormField<int>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 13,
        ),
      ),
      selectedItemBuilder: (context) => items
          .map(
            (int value) => Text(
              value.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
          .toList(),
      items: items
          .map(
            (int value) => DropdownMenuItem<int>(
              value: value,
              child: Text(
                value.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: (int? newValue) {
        if (newValue != null) onChanged(newValue);
      },
    );
  }
}

class _StepHeader extends StatelessWidget {
  final int currentStep;

  const _StepHeader({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepDot(label: '1', title: 'Profile', active: currentStep == 0),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.line,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          ),
        ),
        _StepDot(label: '2', title: 'Account', active: currentStep == 1),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  final String label;
  final String title;
  final bool active;

  const _StepDot({
    required this.label,
    required this.title,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.brand : AppColors.mist,
            shape: BoxShape.circle,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : AppColors.brandDark,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: active ? AppColors.navy : AppColors.muted,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.sm),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: selected ? AppColors.mist : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(AppRadii.sm),
          border: Border.all(
            color: selected ? AppColors.brand : AppColors.line,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.brand : AppColors.muted,
              size: 19,
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? AppColors.brandDark : AppColors.slate,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
