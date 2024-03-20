import 'package:academity_app/models/attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/providers/attendance_provider.dart';
/*
class StudentListWidget extends ConsumerWidget {
  final int classId;
  const StudentListWidget({Key? key, required this.classId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the `studentsByClassIdProvider` to access the data
    final AsyncValue<List<Attendance>> studentsAsyncValue =
        ref.watch(attendanceProvider());

    return studentsAsyncValue.when(
      loading: () => Center(child: CircularProgressIndicator()), // Show a centered loading indicator
      error: (error, stack) => Center(child: Text('Error: $error')), // Show the error message in the center
      data: (students) {
        // Data is available, build your UI using the retrieved students
        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            // Build your list item using students[index]
            final student = students[index];
            return ListTile(
              leading: Icon(Icons.person), // Place the icon to the left of the title
              title: Text(
                '${student.studentName} ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'status: ${student.status}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              onTap: () {
              Navigator.pushNamed(
               context,
              '/studentDetails',
               arguments: student, // Pass the student object to the details screen
               );
},
            );
          },
        );
      },
    );
  }
}*/