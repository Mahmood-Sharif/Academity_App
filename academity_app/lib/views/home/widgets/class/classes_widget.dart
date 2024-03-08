/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/providers/classes_provider.dart'; // Adjust path as necessary

class ClassesWidget extends ConsumerWidget {
  final int academyId;
  final Academy academy;

  const ClassesWidget({Key? key, required this.academyId, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classesAsyncValue = ref.watch(classProvider(academyId));

    return classesAsyncValue.when(
      data: (classes) => ListView.builder(
        shrinkWrap: true, // Make ListView take up as much space as its children
        physics: NeverScrollableScrollPhysics(), // Disable scrolling within the ListView
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classItem = classes[index];
          return ListTile(
            title: Text(classItem.className),
            // Add other class details here, like minAge and maxAge
          );
        },
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  }
}*/

