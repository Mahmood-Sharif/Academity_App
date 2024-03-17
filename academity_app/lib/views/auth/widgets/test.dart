
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

enum Gender { male, female }

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  Gender? _gender = Gender
      .male; // Default to male, can be set to null if you prefer no default selection
  String phone = '';
  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  String password = '';
  String passwordConfirm = '';
  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years =
      List.generate(101, (index) => DateTime.now().year - index);

  String? emailError;
  String? nameError;
  String? genderError;
  String? phoneError;
  String? selectedDateError;
  String? passwordError;
  String? passwordConfirmError;

  Future<void> attemptSignUp() async {
    if (_formKey.currentState!.validate()) {
      // Assuming AuthServices is accessible here, either through dependency injection or provider
      final RegisterResponse signUpSuccess = await AuthServices().registerUser({
        'email': email,
        'name': name,
        'gender': _gender == Gender.male ? 'Male' : 'Female',
        'phone': phone,
        'dob': DateTime(selectedYear, selectedMonth, selectedDay)
            .toIso8601String(),
        'password': password,
        'password_confirm': passwordConfirm,
      });

      print(signUpSuccess);

      if (signUpSuccess.success) {
        Navigator.of(context).pushReplacementNamed(
            '/browseSports'); // Navigate to login upon successful sign up
      } else {
        setState(() {
          emailError = signUpSuccess.errors?['email'];
          nameError = signUpSuccess.errors?['name'];
          phoneError = signUpSuccess.errors?['phone'];
          passwordError = signUpSuccess.errors?['password'];
          passwordConfirmError = signUpSuccess.errors?['password_confirm'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Email', errorText: emailError, errorMaxLines: 2),
                onChanged: (value) => setState(() => email = value),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Full Name',
                    errorText: nameError,
                    errorMaxLines: 2),
                onChanged: (value) => setState(() => name = value),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your full name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    errorText: phoneError,
                    errorMaxLines: 2),
                onChanged: (value) => setState(() => phone = value),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gender',
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
                            const Text('Male'),
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
                            const Text('Female'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: selectedDay,
                      decoration: const InputDecoration(labelText: 'Day'),
                      items: days.map<DropdownMenuItem<int>>((int value) {
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
                  const SizedBox(width: 8), // Add some spacing
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: selectedMonth,
                      decoration: const InputDecoration(labelText: 'Month'),
                      items: months.map<DropdownMenuItem<int>>((int value) {
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
                  const SizedBox(width: 8), // Add some spacing
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: selectedYear,
                      decoration: const InputDecoration(labelText: 'Year'),
                      items: years.map<DropdownMenuItem<int>>((int value) {
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
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: passwordError,
                    errorMaxLines: 2),
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a password' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    errorText: passwordConfirmError,
                    errorMaxLines: 2),
                obscureText: true,
                onChanged: (value) => setState(() => passwordConfirm = value),
                validator: (value) =>
                    value != password ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  attemptSignUp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFFF3200), // Button background color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52,
                      vertical: 10), // Makes the button a bit bigger
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(4), // Slightly rounded edges
                  ),
                ),
                child: const Text('Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold)), // Adjust font size as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}