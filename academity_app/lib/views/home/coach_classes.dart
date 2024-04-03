import 'package:academity_app/models/class.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/views/home/widgets/class/coach_class_list.dart';
import 'package:flutter/material.dart';

class CoachClassesPage extends StatelessWidget {
  final int academyId;
  final String academyName;
  const CoachClassesPage(
      {Key? key, required this.academyId, required this.academyName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(academyName, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B0000),
        iconTheme: const IconThemeData(
            color: Colors.white), // Set the color of the back button to white
      ),
      body: FutureBuilder<List<Classes>>(
        future: ClassServices().fetchClassesByAcademyId(
            academyId), // Replace 2 with the actual class ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return CoachClassListWidget(
              academyId: academyId,
              academyName: academyName,
            ); // Pass the students data to the StudentListWidget
          }
        },
      ),
    );
  }
}
