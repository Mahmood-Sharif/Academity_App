import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/providers/students_provider.dart';

class AttendanceListWidget extends ConsumerWidget {
  final int classId; 
  const AttendanceListWidget({Key? key, required this.classId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the `studentsByClassIdProvider` to access the data based on classId
    final AsyncValue<List<Student>> studentsAsyncValue =
        ref.watch(studentsByClassIdProvider(classId));

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
                '${student.firstName} ${student.lastName}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Phone: ${student.phone}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: ToggleButtons(
                children: [
                  Text('Attended'),
                  Text('Absent'),
                ],
                isSelected: [false, false],
                onPressed: (index) {
                  // Handle the toggle button press
                  if (index == 0) {
                    // Attended button pressed
                  } else if (index == 1) {
                    // Absent button pressed
                  }
                },
                selectedColor: Colors.white,
                fillColor: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              onTap: () {
                // Handle the tap event if needed
              },
            );
          },
        );
      },
    );
  }
}
