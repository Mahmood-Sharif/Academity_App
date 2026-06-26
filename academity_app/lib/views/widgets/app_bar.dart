import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double height;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = const Color(0xFF8B0000),
    this.height = kToolbarHeight + 18,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      centerTitle: true,
      shape: CustomShapeBorder(),
      backgroundColor: backgroundColor,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor,
              const Color(0xFFFF3200),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const double radius = 24;

    Path path = Path();
    path.lineTo(0, rect.height - radius);
    path.quadraticBezierTo(0, rect.height, radius, rect.height);
    path.lineTo(rect.width - radius, rect.height);
    path.quadraticBezierTo(
        rect.width, rect.height, rect.width, rect.height - radius);
    path.lineTo(rect.width, 0);
    path.close();

    return path;
  }
}
