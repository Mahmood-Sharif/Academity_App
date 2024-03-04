import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart'; // Adjust path as necessary
import 'package:academity_app/views/home/widgets/class/classes_widget.dart';
import 'package:academity_app/views/home/widgets/class/description_widget.dart';
import 'package:academity_app/views/home/widgets/class/location_widget.dart';
import 'package:academity_app/views/home/widgets/class/register_button_widget.dart';

class AcademyDetailScreen extends StatelessWidget {
  final Academy academy;

  const AcademyDetailScreen({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? academyIdAsInt;
    try {
      academyIdAsInt = int.tryParse(academy.academyId);
    } catch (e) {
      // Log error or handle it as needed
      debugPrint('Error converting academyId to int: $e');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(academy.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DescriptionWidget(academy: academy),
            LocationWidget(academy: academy),
            // Check if academyIdAsInt is not null before using it
            if (academyIdAsInt != null)
              ClassesWidget(academyId: academyIdAsInt, academy: academy),
            const RegisterButtonWidget(),
            // Add other widgets as needed
          ],
        ),
      ),
    );
  }
}
