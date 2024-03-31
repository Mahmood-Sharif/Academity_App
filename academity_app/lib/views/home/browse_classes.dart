import 'package:academity_app/views/home/widgets/class/class_day.dart';
import 'package:academity_app/views/home/widgets/class/class_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  DateTime _selectedDate = DateTime.now();

  // Helper function to get the date for the start of the week (Sunday)
  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday));
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startOfWeek = _getStartOfWeek(today);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B0000),
        elevation: 0,
        title: const Text(
          'My Schedule',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 80, // Increased height for extra space
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(7, (index) {
                  final day = startOfWeek.add(Duration(days: index));
                  final isSelected = day.day == _selectedDate.day;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DayButton(
                      date: day,
                      isSelected: isSelected,
                      onPressed: () {
                        setState(() {
                          _selectedDate = day;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: ClassesList(
              dayOfWeek: DateFormat.E().format(_selectedDate).toUpperCase(),
              date: _selectedDate,
            ),
          ),
        ],
      ),
    );
  }
}