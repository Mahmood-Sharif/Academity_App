// location_widget.dart
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart'; // Adjust path

class LocationWidget extends StatelessWidget {
  final Academy academy;

  const LocationWidget({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Location: ${academy.location}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
