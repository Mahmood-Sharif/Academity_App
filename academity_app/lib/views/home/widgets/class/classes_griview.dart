import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/providers/classes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClassListWidget extends ConsumerWidget {
  const ClassListWidget({Key? key}) : super(key: key);

  String formatTime(String? time) {
    if (time == null) return '';
    final parsedTime = DateTime.parse('2022-01-01 $time');
    return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classes = ref.watch(classProvider);

    return classes.when(
      data: (classes) => ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final startTime = formatTime(classes[index].startTime);
          final endTime = formatTime(classes[index].endTime);
          final timeRange = '$startTime - $endTime';

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/attendance',
                  arguments: classes[index].classId,
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // Add image decoration if available
                        // image: DecorationImage(
                        //   image: NetworkImage(classes[index].imageUrl),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    const SizedBox(width: 16), // Add some spacing between image and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classes[index].name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                            Text(
                            classes[index].className.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Add spacing between class name and subtext
                          Text(
                            timeRange,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
