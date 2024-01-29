import 'package:academity_app/users/widgets/academy_details_widget.dart';
import 'package:academity_app/users/widgets/classes_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/api_connection/api_service.dart';

class AcademyDetailsScreen extends StatelessWidget {
  final String academyId;

  AcademyDetailsScreen({Key? key, required this.academyId}) : super(key: key);
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academy Details'),
      ),
      body: FutureBuilder<dynamic>(
        future: api.fetchAcademyDetails(academyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var academy = snapshot.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AcademyDetailsWidget(academy: academy),
                  FutureBuilder<List<dynamic>>(
                    future: api.fetchClasses(academyId),
                    builder: (context, classesSnapshot) {
                      if (classesSnapshot.hasData) {
                        return ClassesListWidget(
                            classes: classesSnapshot.data!);
                      } else {
                        return const Center(child: Text("No classes found"));
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      child: const Text(
                        'Register Now',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
                child: Text("No details found for this academy"));
          }
        },
      ),
    );
  }
}
