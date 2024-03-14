



import 'package:academity_app/models/class_with_timing.dart';
import 'package:flutter/material.dart';

class ClassTabs extends StatelessWidget {
  final List<ClassWithTiming> classes;

  ClassTabs(this.classes);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7, // Number of days in a week
      initialIndex: DateTime.now().weekday - 1, // Set initial index to today's day of week
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8B0000),
          title: const Text('My Schedule'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Sun'),
              Tab(text: 'Mon'),
              Tab(text: 'Tue'),
              Tab(text: 'Wed'),
              Tab(text: 'Thu'),
              Tab(text: 'Fri'),
              Tab(text: 'Sat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DaySchedule(classes, 'Sun'),
            DaySchedule(classes, 'Mon'),
            DaySchedule(classes, 'Tue'),
            DaySchedule(classes, 'Wed'),
            DaySchedule(classes, 'Thu'),
            DaySchedule(classes, 'Fri'),
            DaySchedule(classes, 'Sat'),
          ],
        ),
      ),
    );
  }
}


class DaySchedule extends StatelessWidget {
  final List<ClassWithTiming> classes;
  final String dayOfWeek;

  DaySchedule(this.classes, this.dayOfWeek);

  @override
  Widget build(BuildContext context) {
    final classesForDay = classes.where((cls) => cls.dayOfWeek == dayOfWeek).toList();

    return ListView.builder(
      itemCount: classesForDay.length,
      itemBuilder: (context, index) {
        final startTime = formatTime(classesForDay[index].startTime);
        final endTime = formatTime(classesForDay[index].endTime);
        final timeRange = '$startTime - $endTime';

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/class_students',
                arguments: classesForDay[index].classId,
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
                          classesForDay[index].name.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          classesForDay[index].className.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8), // Add spacing between class name and subtext
                        Text(
                          timeRange,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
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
  }

  String formatTime(String? time) {
    if (time == null) return '';
    final parsedTime = DateTime.parse('2022-01-01 $time');
    return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
  }
}