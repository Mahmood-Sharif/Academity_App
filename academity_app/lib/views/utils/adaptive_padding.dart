import 'package:flutter/material.dart';

class AdaptivePadding extends StatelessWidget {
  final Widget child;
  final double vertical;
  final double maxWidth;
  const AdaptivePadding({
    super.key,
    required this.child,
    this.vertical = 18,
    this.maxWidth = 980,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width > 720 ? 24 : 16,
            vertical: vertical,
          ),
          child: child,
        ),
      ),
    );
  }
}
