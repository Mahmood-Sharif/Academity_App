import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayButton extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onPressed;
  final double buttonWidth;

  const DayButton({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onPressed,
    this.buttonWidth = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat.E().format(date);
    final dayNumber = DateFormat.d().format(date);

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0), // Adjust spacing as needed
        child: Material(
          elevation: isSelected ? 4 : 4,
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? const Color(0xFF008B8B) : Colors.white,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.blue,
            child: Container(
              width: buttonWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dayNumber,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : null,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                  const SizedBox(
                      height:
                          8), // Adjust the spacing between dayName and dayNumber
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? Colors.white : null,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                  const SizedBox(
                      height:
                          8), // Adjust the spacing between dayName and dayNumber
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(
                          color: isSelected
                              ? const Color(0xFF00FFFF)
                              : Colors.blueGrey), // Slightly darker blue dot
                      const SizedBox(width: 4), // Adjust spacing between dots
                      _buildDot(
                          color: isSelected
                              ? const Color(0xFF00FFFF)
                              : Colors.blueGrey),
                      const SizedBox(width: 4),
                      _buildDot(
                          color: isSelected
                              ? const Color(0xFF00FFFF)
                              : Colors.blueGrey),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot({Color color = Colors.blueGrey}) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
