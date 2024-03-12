import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/providers/class_provider.dart';
import 'package:intl/intl.dart'; // Ensure this is correctly imported

void showClassDetails(BuildContext context, int classId, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Consumer(
      builder: (context, ref, _) {
        final classDetailsAsyncValue = ref.watch(classProvider(classId));

        return classDetailsAsyncValue.when(
          data: (classItem) {
            final hasTimings =
                classItem.timings.isNotEmpty;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text('Class Name: ${classItem.className}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  const SizedBox(height: 10), // Add some spacing
                  // Display Price with "BD" at the end
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black), // Default text style
                      children: [
                        const TextSpan(
                            text: 'Price: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextSpan(
                            text: 'BD ${classItem.price} ',
                            style: const TextStyle(
                                fontSize: 16)), // Append "BD" to the price
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Add some spacing
                  const Text('Training Days',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Expanded(
                    child: hasTimings
                        ? ListView.builder(
                            itemCount: classItem.timings.length,
                            itemBuilder: (context, index) {
                              final timing = classItem.timings[index];
                              final startTime = DateFormat('HH:mm:ss')
                                  .parse(timing.startTime);
                              final endTime =
                                  DateFormat('HH:mm:ss').parse(timing.endTime);
                              return ListTile(
                                title: Text(timing.dayOfWeek,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)}'),
                              );
                            },
                          )
                        : const Center(child: Text('No timings available')),
                  ),
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
      },
    ),
  );
}
