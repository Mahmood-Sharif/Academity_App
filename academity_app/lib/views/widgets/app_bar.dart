import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor; // Custom background color
  final double height;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = const Color(0xFF8B0000), // Default to dark red if not specified
    this.height = kToolbarHeight + 20, // You might adjust this for more space
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Transform.translate(
        offset: const Offset(0, 10), // Adjust the offset value to lower the text as needed
        child: Text(
          title,
          style: GoogleFonts.montserrat( // Use Montserrat font from google_fonts package
            color: Colors.white,
            fontWeight: FontWeight.bold // Set title text color to white
          ),
        ),
      ),
      centerTitle: true, // Centers the AppBar title
      shape: CustomShapeBorder(),
      backgroundColor: backgroundColor, // Use the provided custom color
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double radius = 30; // Adjust the curve radius as needed

    Path path = Path();
    path.lineTo(0, rect.height - radius);
    path.quadraticBezierTo(0, rect.height, radius, rect.height);
    path.lineTo(rect.width - radius, rect.height);
    path.quadraticBezierTo(rect.width, rect.height, rect.width, rect.height - radius);
    path.lineTo(rect.width, 0);
    path.close();

    return path;
  }
}
