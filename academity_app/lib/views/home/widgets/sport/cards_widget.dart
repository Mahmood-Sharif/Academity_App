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
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Card 1 Content'),
                ),
              ),
            ),
            SizedBox(width: 16), // Space between the cards
            Expanded(
              child: CardWithShadow(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Card 2 Content'),
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
  final Widget child;

  const CardWithShadow({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // Changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(4), // Rounded corners
      ),
      child: child,
    );
  }
}
