// classes_widget.dart
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart'; // Adjust path

class ClassesWidget extends StatelessWidget {
  final Academy academy;

  const ClassesWidget({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: academy.classes.map((classItem) {
        return ListTile(
          title: Text(classItem.className),
          // Add other class details here
        );
      }).toList(),
    );
  }
}
