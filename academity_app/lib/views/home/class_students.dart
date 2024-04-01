import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/student_service.dart';
import 'package:academity_app/views/home/widgets/sport/students_griview.dart';
import 'package:flutter/material.dart';

class ClassStudentsPage extends StatelessWidget {
  final int classId;
  final String className;
  const ClassStudentsPage(
      {Key? key, required this.classId, required this.className})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(className.toString(), style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B0000),
        iconTheme: IconThemeData(
            color: Colors.white), // Set the color of the back button to white
      ),
      body: FutureBuilder<List<Student>>(
        future: StudentServices().fetchStudentsByClassId(classId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // final List<ClassWithTiming> students = snapshot.data ?? [];
            return StudentsListWidget(
                classId:
                    classId); // Pass the students data to the StudentListWidget
          }
        },
      ),
    );
  }
}
