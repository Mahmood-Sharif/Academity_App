import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Schedule'),
      body: Column(
        children: [
          // Height containing the ListView.builder for dates
          SizedBox(
            height: 80, // Adjust for thinner appearance
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14, // Display next 5 days
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
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF008B8B)
                          : Colors.white, // Highlight selected date
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // Changes position of shadow
                        ),
                      ],
                    ),
                    width: 70, // Adjust width for a "thinner" card
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${date.day}/${date.month}', // Date
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black),
                        ),
                        Text(
                          _getDayOfWeek(date.weekday), // Day of the week
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
          // Expanded widget to handle the list without causing overflow
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 5, // Example item count, adjust as necessary
              itemBuilder: (context, index) {
                // Replace this with your actual data and widget
                return Card(
                  child: ListTile(
                    title: Text('Class Title $index'),
                    subtitle:
                        const Text('Time: 10:00 AM\nLocation: Sports Hall'),
                  ),
                );
              },
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
