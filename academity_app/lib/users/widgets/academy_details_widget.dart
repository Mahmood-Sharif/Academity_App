import 'package:flutter/material.dart';

class AcademyDetailsWidget extends StatelessWidget {
  final dynamic academy; // Replace with your specific academy model if available

  const AcademyDetailsWidget({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 400, // Your desired width
          height: 150, // Your desired height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('http://192.168.28.119/${academy['image_url']}'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('Name: ${academy['name']}', style: const TextStyle(fontSize: 20)),
        Text('Location: ${academy['location']}'),
        // Add more academy details here
      ],
    );
  }
}
