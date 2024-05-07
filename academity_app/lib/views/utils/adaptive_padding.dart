import 'package:flutter/material.dart';

class AdaptivePadding extends StatelessWidget {
  final Widget child;
  final double vertical;
  const AdaptivePadding({super.key, required this.child, this.vertical = 8});

  @override
  Widget build(BuildContext context) {
    final vw = MediaQuery.sizeOf(context).width;
    final double padding = (vw > 532) ? vw * 0.2 : 16;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: vertical,
      ),
      child: child,
    );
  }
}
