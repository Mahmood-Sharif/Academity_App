// academy_detail_screen.dart
import 'package:academity_app/views/home/widgets/class/classes_widget.dart';
import 'package:academity_app/views/home/widgets/class/description_widget.dart';
import 'package:academity_app/views/home/widgets/class/location_widget.dart';
import 'package:academity_app/views/home/widgets/class/register_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart'; // Adjust path

class AcademyDetailScreen extends StatelessWidget {
  final Academy academy;

  const AcademyDetailScreen({Key? key, required this.academy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure the Academy model has all the required fields
    // including imageUrl for the academy image, and a classes list for the ClassesWidget.
    return Scaffold(
      appBar: AppBar(
        title: Text(academy.name), // Academy name in AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // (academy.imageUrl != null && academy.imageUrl.isNotEmpty) 
            //   ? Image.network(academy.imageUrl, fit: BoxFit.cover) // Display the academy image
            //   : SizedBox(height: 200, child: Placeholder()), // Fallback placeholder
            DescriptionWidget(academy: academy), // Description section
            const SizedBox(height: 2,),
            LocationWidget(academy: academy), // Location section
            const SizedBox(height: 10,),
            ClassesWidget(academy: academy), // Classes section
            // TODO: Uncomment GalleryWidget when it's implemented
            // GalleryWidget(academy: academy), // Gallery section
            const RegisterButtonWidget(), // Registration button
          ],
        ),
      ),
    );
  }
}
