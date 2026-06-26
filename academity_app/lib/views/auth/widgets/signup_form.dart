import 'package:academity_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Ensure this path is correct
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
  String? genderError;
  String? phoneError;
  String? selectedDateError;
  String? passwordError;
  String? passwordConfirmError;

  Future<void> attemptSignUp() async {
    final isForm1Valid = _formKey1.currentState?.validate() ?? false;
    final isForm2Valid = _formKey2.currentState?.validate() ?? false;

    // Early validation checks to ensure we don't proceed with the API call unnecessarily
    if (!isForm1Valid || !isForm2Valid) {
      setState(() {
        // Ensure user is navigated back to the correct form based on where the validation failed
        _currentStep = !isForm1Valid ? 0 : 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(!isForm1Valid
                ? AppLocalizations.of(context)!.formErrorPersonalInfo
                : AppLocalizations.of(context)!.formErrorAccountInfo)),
      );
      return; // Stop the sign-up process here if any form validation fails
    }

    // If both forms are valid, attempt the sign-up process
    final RegisterResponse signUpSuccess = await AuthServices.registerUser({
      'email': email,
      'name': name,
      'gender': _gender == Gender.male ? 'Male' : 'Female',
      'phone': phone,
      'dob':
          DateTime(selectedYear, selectedMonth, selectedDay).toIso8601String(),
      'password': password,
      'password_confirm': passwordConfirm,
    });

    if (signUpSuccess.success) {
      ref.read(authProvider.notifier).loginTest().then((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.signupSuccessMessage)),
        );
      });
    } else {
      // Navigate back to Form 1 if the sign-up process fails
      setState(() {
        _currentStep = 0; // Move back to the first form for correction
        // Update the UI to show server-side validation errors if provided by the API
        emailError = signUpSuccess.errors?['email'];
        nameError = signUpSuccess.errors?['name'];
        phoneError = signUpSuccess.errors?['phone'];
        passwordError = signUpSuccess.errors?['password'];
        passwordConfirmError = signUpSuccess.errors?['password_confirm'];
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed to sign up. Please check your information and try again.')),
      // );
    }
  }

  void _next() {
    // Validate Form 1 regardless of the current step, to ensure navigation back if there are errors
    final isForm1Valid = _formKey1.currentState?.validate() ?? false;

    if (_currentStep == 0) {
      if (isForm1Valid) {
        setState(() => _currentStep++);
      }
    } else if (_currentStep == 1) {
      final isForm2Valid = _formKey2.currentState?.validate() ?? false;
      if (isForm1Valid && isForm2Valid) {
        attemptSignUp();
      } else if (!isForm1Valid) {
        // This handles the case where the user has moved to Form 2 but Form 1 becomes invalid
        setState(() => _currentStep = 0);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.formErrorPersonalInfo)),
        );
      }
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 139, 139),
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        dialogBackgroundColor: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Stepper(
          physics: const ClampingScrollPhysics(),
          currentStep: _currentStep,
          onStepContinue: _next,
          onStepCancel: _back,
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = _currentStep == 1;
            return Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 139, 139),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    isLastStep
                        ? AppLocalizations.of(context)!.signUpButton
                        : AppLocalizations.of(context)!.continueButtonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text(AppLocalizations.of(context)!.backButtonText),
                  ),
              ],
            );
          },
          steps: [
            Step(
              title: Text(AppLocalizations.of(context)!.personalInfoTitle),
              content: Form(
                key: _formKey1,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.fullNameLabel,
                        errorText: nameError,
                        errorMaxLines: 2,
                      ),
                      onChanged: (value) => name = value,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.signupFailureMessage
                          : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.phoneNumberLabel,
                        errorText: phoneError,
                        errorMaxLines: 2,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => phone = value,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.phoneNumberError
                          : null,
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.genderLabel,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.left),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<Gender>(
                                    value: Gender.male,
                                    groupValue: _gender,
                                    onChanged: (Gender? value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!.maleGender),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<Gender>(
                                    value: Gender.female,
                                    groupValue: _gender,
                                    onChanged: (Gender? value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                    },
                                  ),
                                  Text(AppLocalizations.of(context)!
                                      .femaleGender),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.dobLabel,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.left),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedDay,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.dayLabel,
                                ),
                                items: days
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() => selectedDay = newValue!);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedMonth,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.monthLabel,
                                ),
                                items: months
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() => selectedMonth = newValue!);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                initialValue: selectedYear,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.yearLabel,
                                ),
                                items: years
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() => selectedYear = newValue!);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: Text(AppLocalizations.of(context)!.accountInfoTitle),
              content: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.emailLabel,
                        errorText: emailError,
                        errorMaxLines: 2,
                      ),
                      onChanged: (value) => email = value,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.emailError
                          : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.passwordLabel,
                        errorText: passwordError,
                        errorMaxLines: 2,
                      ),
                      obscureText: true,
                      onChanged: (value) => password = value,
                      validator: (value) => value!.isEmpty
                          ? AppLocalizations.of(context)!.passwordError
                          : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.confirmPasswordLabel,
                        errorText: passwordConfirmError,
                        errorMaxLines: 2,
                      ),
                      obscureText: true,
                      onChanged: (value) => passwordConfirm = value,
                      validator: (value) => value != password
                          ? AppLocalizations.of(context)!.confirmPasswordError
                          : null,
                    ),
                  ],
                ),
              ),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
          ],
        ),
      ),
    );
  }
}
