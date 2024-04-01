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
              child: CardWithShadow(
                header: "Upcoming Class",
                body: "SoccerStars Academy",
              ),
            ),
            SizedBox(width: 16), // Space between the cards
            Expanded(
              child: CardWithShadow(
                header: "Subscription Ends",
                body: "27 Days",
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
    Key? key,
    required this.header,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF008B8B),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 1.5), // Changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0), // Space between header and body
            Text(
              body,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
