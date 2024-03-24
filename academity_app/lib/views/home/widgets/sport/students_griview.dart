import 'package:academity_app/providers/classes_provider.dart';
import 'package:academity_app/providers/students_provider%20copy.dart';
import 'package:academity_app/views/home/student_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsListWidget extends ConsumerWidget {
  final int classId; 
  const StudentsListWidget({Key? key, required this.classId}) : super(key: key);

  String formatTime(String? time) {
    if (time == null) return '';
    final parsedTime = DateTime.parse('2022-01-01 $time');
    return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsByClassIdProvider(classId));

    return students.when(
      data: (students) => ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          //final startTime = formatTime(classes[index]);
          //final endTime = formatTime(classes[index].endTime);
          //final timeRange = '$startTime - $endTime';

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailsScreen(),
                    settings: RouteSettings(arguments: students[index]),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // Add image decoration if available
                        // image: DecorationImage(
                        //   image: NetworkImage(classes[index].imageUrl),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    const SizedBox(width: 16), // Add some spacing between image and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            students[index].name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                            Text(
                            students[index].name.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Add spacing between class name and subtext
                         /* Text(
                            timeRange,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
