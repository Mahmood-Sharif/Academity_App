import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart'; // Adjust path
import 'package:google_fonts/google_fonts.dart'; // Make sure this path is correct

class LocationWidget extends StatelessWidget {
  final Academy academy;

  const LocationWidget({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Location: ",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold, // Make "Location:" bold
            fontSize: 16,
          ),
        ),
        Expanded( // Use Expanded to prevent overflow
          child: Text(
            academy.location,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400, // Regular weight for the actual location
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis, // Prevent overflow
          ),
        ),
      ],
    );
  }
}
