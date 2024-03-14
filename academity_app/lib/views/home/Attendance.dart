import 'package:academity_app/views/home/widgets/sport/Attendance_griview.dart';
import 'package:academity_app/views/home/widgets/sport/students_griview.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/student_service.dart';
import 'package:academity_app/views/home/widgets/class/classes_griview.dart';

class AtendancePage extends StatelessWidget {
  const AtendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final classId = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B0000),
        iconTheme: IconThemeData(color: Colors.white), // Set the color of the back button to white
      ),
      body: FutureBuilder<List<Student>>(
        future: StudentServices().fetchStudentsByClassId(3), // Replace 2 with the actual class ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Student> students = snapshot.data ?? [];
            return AttendanceListWidget(classId: classId as int); // Pass the students data to the StudentListWidget
          }
        },
      ),
    );
  }
}
