import 'package:academity_app/providers/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/views/widgets/app_bar.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final scheduleAsyncValue = ref.watch(scheduleForStudentProvider({
      'studentId':
          1, // Example student ID, replace with actual logic to get the current student's ID
      'fromDate': _selectedDay,
      'toDate': _selectedDay,
    }));

    return Scaffold(
      appBar: const CustomAppBar(title: 'Schedule'),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index));
                final isSelected = _selectedDay.year == date.year &&
                    _selectedDay.month == date.month &&
                    _selectedDay.day == date.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = date;
                    });
                    // Consider adding logic to refresh the schedule based on the new _selectedDay
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFF008B8B) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    width: 70,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${date.day}/${date.month}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black),
                        ),
                        Text(
                          _getDayOfWeek(date.weekday),
                          style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: scheduleAsyncValue.when(
              data: (schedule) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: schedule.length,
                  itemBuilder: (context, index) {
                    final classDetails = schedule[index];
                    return Card(
                      child: ListTile(
                        title: Text(classDetails.className),
                        subtitle: Text(
                            'Time: ${classDetails.timings[0].startTime}\nLocation: Sports Hall'), // Adjust as needed
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
