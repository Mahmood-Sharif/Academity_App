import 'dart:async';

import 'package:academity_app/models/class.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/views/home/widgets/class/coach_class_list.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';

class CoachClassesPage extends StatelessWidget {
  final int academyId;
  final String academyName;
  const CoachClassesPage(
      {super.key, required this.academyId, required this.academyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: academyName,
        subtitle: 'Classes and enrolled students',
      ),
      body: AdaptivePadding(
        child: FutureBuilder<List<Classes>>(
          future: ClassServices().fetchClassesByAcademyId(
              academyId), // Replace 2 with the actual class ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoadingState(label: 'Loading classes');
            } else if (snapshot.hasError) {
              final error = snapshot.error!;
              if (error.runtimeType == TimeoutException) {
                return const AppEmptyState(
                  icon: Icons.wifi_off_rounded,
                  title: 'Connection timeout',
                  body: 'Please check your internet connection and try again.',
                );
              } else {
                return AppErrorState(error: error);
              }
            } else {
              return CoachClassListWidget(
                academyId: academyId,
                academyName: academyName,
              ); // Pass the students data to the StudentListWidget
            }
          },
        ),
      ),
    );
  }
}
