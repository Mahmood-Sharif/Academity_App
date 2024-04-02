import 'package:flutter/material.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF8B0000), // Background color of the calendar pages
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), // Adjust border radius as needed
          bottomRight: Radius.circular(20), // Adjust border radius as needed
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 20), // Adjust padding as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white), // Add icon for previous month/page
              onPressed: () {
                // Handle navigation to the previous month/page
              },
            ),
            const Text(
              'March 2024', // Display current month/year or selected date range
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios,
                  color: Colors.white), // Add icon for next month/page
              onPressed: () {
                // Handle navigation to the next month/page
              },
            ),
          ],
        ),
      ),
    );
  }
}
