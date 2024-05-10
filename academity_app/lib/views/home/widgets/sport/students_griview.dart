import 'dart:async';

import 'package:academity_app/services/student_service.dart';
import 'package:academity_app/views/home/student_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsListWidget extends ConsumerWidget {
  final int classId;
  const StudentsListWidget({super.key, required this.classId});

  String formatTime(String? time) {
    if (time == null) return '';
    final parsedTime = DateTime.parse('2022-01-01 $time');
    return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: StudentServices().fetchStudentsByClassId(classId),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final students = asyncSnapshot.requireData;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                //final startTime = formatTime(classes[index]);
                //final endTime = formatTime(classes[index].endTime);
                //final timeRange = '$startTime - $endTime';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentDetailsScreen(),
                          settings: RouteSettings(arguments: students[index]),
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
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // Add image decoration if available
                              // image: DecorationImage(
                              //   image: NetworkImage(classes[index].imageUrl),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  16), // Add some spacing between image and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  students[index].name.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  students[index].name.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        8), // Add spacing between class name and subtext
                                /* Text(
                            timeRange,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),*/
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
              return const Center(
                child: Text(
                  'Connection Timeout.\nPlease check your internet connection.',
                  maxLines: 5,
                ),
              );
            } else {
              return Center(child: Text('Error: $error'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
