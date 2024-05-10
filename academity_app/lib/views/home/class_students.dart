import 'dart:async';

import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/student_service.dart';
import 'package:academity_app/views/home/widgets/sport/students_griview.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';

class ClassStudentsPage extends StatelessWidget {
  final int classId;
  final String className;
  const ClassStudentsPage(
      {super.key, required this.classId, required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(className.toString(),
            style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B0000),
        iconTheme: const IconThemeData(
            color: Colors.white), // Set the color of the back button to white
      ),
      body: AdaptivePadding(
        child: FutureBuilder<List<Student>>(
          future: StudentServices().fetchStudentsByClassId(classId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final error = snapshot.error!;
              if (error.runtimeType == TimeoutException) {
                return const Center(
                  child: Text(
                    'Connection Timeout.\nPlease check your internet connection.',
                    maxLines: 5,
                  ),
                );
              } else {
                return Center(child: Text('Error: $error'));
              }
            } else {
              // final List<ClassWithTiming> students = snapshot.data ?? [];
              return StudentsListWidget(
                  classId:
                      classId); // Pass the students data to the StudentListWidget
            }
          },
        ),
      ),
    );
  }
}
