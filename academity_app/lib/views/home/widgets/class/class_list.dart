import 'package:academity_app/providers/classes_provider.dart';
import 'package:academity_app/views/home/Attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ClassesList extends ConsumerWidget {
  final String dayOfWeek;
  final DateTime date;
  const ClassesList({Key? key, required this.dayOfWeek, required this.date}) : super(key: key);
  
  String formatTime(String? time) {
    if (time == null) return '';
    final parsedTime = DateTime.parse('2022-01-01 $time');
    return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classes = ref.watch(classesByAcademyIdProvider(2));

    return classes.when(
      data: (classes) {
        // Filter classes by day of the week
        final classesForDay = classes.where((cls) => cls.dayOfWeek == dayOfWeek).toList();

        return ListView.builder(
          itemCount: classesForDay.length,
          itemBuilder: (context, index) {
            final startTime = formatTime(classesForDay[index].startTime);
            final timeRange = '${DateFormat("yyyy-MM-dd").format(date)}T$startTime';

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendancePage(
                    classId: classesForDay[index].classId,
                    timeRange: timeRange,
                  ),
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
                          //   image: NetworkImage(classesForDay[index].imageUrl),
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
                              classesForDay[index].dayOfWeek.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              timeRange,
                              style: const TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}