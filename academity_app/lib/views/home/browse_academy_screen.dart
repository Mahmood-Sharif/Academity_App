import 'package:academity_app/views/home/widgets/academy/academy_list_widget.dart';
import 'package:flutter/material.dart';

class BrowseAcademyScreen extends StatelessWidget {
  final int sportId; // Make sportId a dynamic parameter of the class

  // Require sportId as a parameter in the constructor
  const BrowseAcademyScreen({Key? key, required this.sportId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Academies'),
      ),
      // Directly use AcademiesListWidget with the dynamic sportId
      body: AcademiesListWidget(sportId: sportId),
    );
  }
}
