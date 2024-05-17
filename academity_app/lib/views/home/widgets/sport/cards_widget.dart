import 'package:flutter/material.dart';

class TwoCardsSideBySide extends StatelessWidget {
  const TwoCardsSideBySide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IntrinsicHeight(
                child: CardWithShadow(
                  header: "Upcoming Class",
                  body: "SoccerStars Academy",
                ),
              ),
            ),
            SizedBox(width: 16), // Space between the cards
            Expanded(
              child: IntrinsicHeight(
                child: CardWithShadow(
                  header: "Subscription Ends",
                  body: "27 Days",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWithShadow extends StatelessWidget {
  final String header;
  final String body;

  const CardWithShadow({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 80, // Set minimum height for the card
        maxHeight: 100, // Set maximum height for the card
        maxWidth: 150,  // Set maximum width for the card
      ),
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4), // Changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                fontSize: 12.0, // Reduced font size
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 4.0), // Reduced space between header and body
            Text(
              body,
              style: const TextStyle(
                fontSize: 12.0, // Reduced font size
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8.0), // Reduced space before action button
          ],
        ),
      ),
    );
  }
}
