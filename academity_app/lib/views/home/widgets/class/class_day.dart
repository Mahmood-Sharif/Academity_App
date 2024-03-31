import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DayButton extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onPressed;
  final double buttonWidth;

  const DayButton({
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: isSelected ? const Color(0xFF008B8B) : Colors.white,
          boxShadow: true
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    blurRadius: 4,
                    offset: const Offset(0, 0),
                  ),
                ]
              : [],
        ),
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
                    fontSize: 16,
                    color: isSelected ? Colors.white : null,
                    fontWeight: isSelected ? FontWeight.bold : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dayName,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? Colors.white : null,
                    fontWeight: isSelected ? FontWeight.bold : null,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(),
                    const SizedBox(width: 2),
                    _buildDot(),
                    const SizedBox(width: 2),
                    _buildDot(),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF008B8B),
      ),
    );
  }
}