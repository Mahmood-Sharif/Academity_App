import 'dart:async';

import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/views/home/class_students.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoachClassListWidget extends ConsumerWidget {
  final int academyId;
  final String? academyName;
  const CoachClassListWidget(
      {super.key, required this.academyId, this.academyName});

  String formatTime(String? time) {
    if (time == null) return '';
    final parsedTime = DateTime.parse('2022-01-01 $time');
    return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ClassServices().fetchClassesByAcademyId(academyId),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final classes = asyncSnapshot.requireData;
            return ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassStudentsPage(
                            classId: classes[index].classId,
                            className: classes[index].className,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  classes[index].className.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  academyName ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (asyncSnapshot.hasError) {
            final error = asyncSnapshot.error!;
            if (error.runtimeType == TimeoutException) {
              return const Text(
                'Connection Timeout.\nPlease check your internet connection.',
                maxLines: 5,
              );
            } else {
              return Text('Error: $error');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
