import 'package:academity_app/views/home/widgets/class/class_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);

  // Helper function to get the date for the start of the week (Sunday)
  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday ));
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startOfWeek = _getStartOfWeek(today);

    return DefaultTabController(
      length: 7, // Number of days in a week
      child: Scaffold(
        appBar: AppBar(
  backgroundColor: const Color(0xFF8B0000),
  elevation: 0, // Remove app bar elevation
  title: const Text(
    'My Schedule',
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottom: TabBar(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey,
    indicatorColor: Colors.transparent,
    tabs: [
      for (int i = 0; i < 7; i++)
        Tab(
          child: Column(
            children: [
              Text(
                DateFormat.E().format(startOfWeek.add(Duration(days: i))),
                style: const TextStyle(fontSize: 10), // Decrease the font size for day name
              ),
              Text(
                DateFormat.d().format(startOfWeek.add(Duration(days: i))),
                style: const TextStyle(fontSize: 12), // Decrease the font size for date
              ),
            ],
          ),
        ),
    ],
  ),
),
        body: TabBarView(
          children: [
    ClassesList(dayOfWeek: 'SUN', date: startOfWeek), // Pass startOfWeek as the date for Sunday
    ClassesList(dayOfWeek: 'MON', date: startOfWeek.add(Duration(days: 1))),
    ClassesList(dayOfWeek: 'TUE', date: startOfWeek.add(Duration(days: 2))),
    ClassesList(dayOfWeek: 'WED', date: startOfWeek.add(Duration(days: 3))),
    ClassesList(dayOfWeek: 'THU', date: startOfWeek.add(Duration(days: 4))),
    ClassesList(dayOfWeek: 'FRI', date: startOfWeek.add(Duration(days: 5))),
    ClassesList(dayOfWeek: 'SAT', date: startOfWeek.add(Duration(days: 6))),
  ],
        ),
      ),
    );
  }
}
