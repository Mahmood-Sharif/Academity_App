import 'package:academity_app/views/MyAcademy/widgets/enrolled_academy_list.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class MyAcademyPage extends StatelessWidget {
  const MyAcademyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'My Academy',
        showBackButton: false,
      ),
      body: EnrolledAcademiesListWidget(),
    );
  }
}
