import 'package:academity_app/api_connection/api_service.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart';
// Ensure this is your class model path
import 'package:academity_app/owners/academy_details.dart';
// Import ApiService

class AcademyListItem extends StatelessWidget {
  final Academy academy;
  final ApiService apiService = ApiService();

  AcademyListItem({super.key, required this.academy});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            try {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AcademyDetails(academy: academy),
                ),
              );
            } catch (e) {
              // Handle the error appropriately
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox(
              width: 380.0,
              height: 150.0,
              child: Image.asset(
                'lib/images/about-slider.jpg', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(academy.name),
          subtitle: Text(academy.location),
        ),
        const Divider(
          height: 20,
        ),
      ],
    );
  }
}
