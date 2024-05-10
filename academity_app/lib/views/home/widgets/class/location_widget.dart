import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart'; // Adjust path
import 'package:google_fonts/google_fonts.dart'; // Make sure this path is correct
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationWidget extends StatelessWidget {
  final Academy academy;

  const LocationWidget({super.key, required this.academy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.locationLabel(academy.location),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold, // Make "Location:" bold
            fontSize: 16,
          ),
        ),
        Expanded(
          // Use Expanded to prevent overflow
          child: Text(
            ': ${academy.location}',
            style: GoogleFonts.montserrat(
              fontWeight:
                  FontWeight.w400, // Regular weight for the actual location
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis, // Prevent overflow
          ),
        ),
      ],
    );
  }
}
