// // gallery_widget.dart
// import 'package:flutter/material.dart';
// import 'package:academity_app/models/academy.dart'; // Adjust path

// class GalleryWidget extends StatelessWidget {
//   final Academy academy;

//   const GalleryWidget({Key? key, required this.academy}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100, // Adjust as needed
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: academy.gallery.length,
//         itemBuilder: (context, index) {
//           return Image.network(academy.gallery[index]);
//         },
//       ),
//     );
//   }
// }
