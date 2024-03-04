// description_widget.dart
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart'; // Adjust path

class DescriptionWidget extends StatelessWidget {
  final Academy academy;

  const DescriptionWidget({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Description: ${academy.description}',
        style: const TextStyle(fontSize: 16,),
      ),
    );
  }
}
