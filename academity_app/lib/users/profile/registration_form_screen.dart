import 'package:academity_app/api_connection/api_service.dart';
import 'package:academity_app/models/student.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({Key? key}) : super(key: key);

  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  // TextEditingControllers for all form fields
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _medicalConditionController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
      final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      final DateTime parsedDate = inputFormat.parse(_dobController.text);
      final String formattedDate = outputFormat.format(parsedDate);

      // Create a Student instance
      final Student student = Student(
        userId: 1, // Assume you get this from the logged-in user context
        age: int.parse(_ageController.text),
        dob: formattedDate,
        emergencyContact: int.parse(_emergencyContactController.text),
        firstName: _firstNameController.text,
        gender: _genderController.text,
        lastName: _lastNameController.text,
        medicalCondition: _medicalConditionController.text,
        phone: int.parse(_phoneController.text),
      );

      // Use the _apiService to send the Student data to the backend
// Use the _apiService to send the Student data to the backend
      try {
        // Attempt to register the student and capture the response
        final response = await _apiService.registerStudent(student);

        // Check the response status and act accordingly
        if (response['status'] == 'success') {
          // Registration successful
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(response['message'] ?? 'Registration successful')),
          );

          // Optionally, navigate to a different screen
          Navigator.pop(
              context); // Go back to the previous screen, or navigate to a success screen
        } else {
          // Registration failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(response['message'] ?? 'Registration failed')),
          );
        }
      } catch (e) {
        // Handle any errors that occurred during registration
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form. Error: $e')),
        );
      }
    } else {
      // Form is not valid
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter first name' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter last name' : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter age' : null,
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(
                    labelText: 'Date of Birth (dd/mm/yyyy)'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter date of birth' : null,
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter gender' : null,
              ),
              TextFormField(
                controller: _emergencyContactController,
                decoration:
                    const InputDecoration(labelText: 'Emergency Contact'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty
                    ? 'Please enter emergency contact number'
                    : null,
              ),
              TextFormField(
                controller: _medicalConditionController,
                decoration:
                    const InputDecoration(labelText: 'Medical Condition'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter medical condition' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
