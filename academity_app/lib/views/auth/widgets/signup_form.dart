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
  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  String password = '';
  String passwordConfirm = '';
  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years =
      List.generate(101, (index) => DateTime.now().year - index);

  Future<void> attemptSignUp() async {
    if (_formKey.currentState!.validate()) {
      // Assuming AuthServices is accessible here, either through dependency injection or provider
      final bool signUpSuccess = await AuthServices().registerUser({
        'email': email,
        'name': name,
        'gender': _gender == Gender.male ? 'male' : 'female',
        'dob': '$selectedYear-$selectedMonth-$selectedDay',
        'password': password,
        'password_confirm': passwordConfirm,
      });

      if (signUpSuccess) {
        Navigator.of(context).pushReplacementNamed(
            '/login'); // Navigate to login upon successful sign up
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration failed. Please try again."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => setState(() => email = value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              onChanged: (value) => setState(() => name = value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your full name' : null,
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
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) => setState(() => password = value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a password' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              onChanged: (value) => setState(() => passwordConfirm = value),
              validator: (value) =>
                  value != password ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 20),
            Positioned(
              bottom:
                  20, // Adjust based on the desired position of the button relative to the bottom of the screen
              right:
                  20, // Adjust based on the desired position of the button relative to the right of the screen
              child: ElevatedButton(
                onPressed: () {
                  attemptSignUp;
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
            ),
          ],
        ),
      ),
    );
  }
}
