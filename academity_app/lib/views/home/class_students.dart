import 'dart:async';

import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/student_service.dart';
import 'package:academity_app/views/home/widgets/sport/students_griview.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';

class ClassStudentsPage extends StatelessWidget {
  final int classId;
  final String className;
  const ClassStudentsPage(
      {super.key, required this.classId, required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: className,
        subtitle: 'Roster and student details',
      ),
      body: AdaptivePadding(
        child: FutureBuilder<List<Student>>(
          future: StudentServices().fetchStudentsByClassId(classId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoadingState(label: 'Loading students');
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
              // final List<ClassWithTiming> students = snapshot.data ?? [];
              return StudentsListWidget(
                  classId:
                      classId); // Pass the students data to the StudentListWidget
            }
          },
        ),
      ),
    );
  }
}
