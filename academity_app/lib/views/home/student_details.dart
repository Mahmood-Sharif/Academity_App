import 'package:flutter/material.dart';
import 'package:academity_app/models/student.dart';

class StudentDetailsScreen extends StatelessWidget {
  const   StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = ModalRoute.of(context)?.settings.arguments as Student?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B0000), // Setting header color to FF8B0000
        title: const Text(
          'Student Details',
          style: TextStyle(color: Colors.white), // Setting header text color to white
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Setting back arrow color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                  ),
                  SizedBox(height: 8.0),
                  Divider( // Adding a horizontal line below the avatar
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      const Text(
                        'Name:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student!.name,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'Phone:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student!.phone.toString(),
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      
                      const Text(
                        'Date of Registration:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student!.startDate.toString().split(' ')[0],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'Renewal Date:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student!.endDate.toString().split(' ')[0],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            
            Card(
              color: Colors.red[200],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    const Text(
                      'Medical Condition:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      student.medicalCondition.toString(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
