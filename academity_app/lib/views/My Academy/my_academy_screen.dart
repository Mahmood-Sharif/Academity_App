import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AcademyPage extends StatelessWidget {
  const AcademyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'My Academy'),);
  }
}