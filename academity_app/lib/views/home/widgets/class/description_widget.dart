// description_widget.dart
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart';
import 'package:google_fonts/google_fonts.dart'; // Adjust path

class DescriptionWidget extends StatelessWidget {
  final Academy academy;

  const DescriptionWidget({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      academy.description,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w400, // Make text bold
        fontSize: 14, // Optional: adjus font size as needed
      ),
    );
  }
}
