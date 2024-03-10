import 'package:academity_app/views/home/widgets/class/class_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/providers/class_provider.dart'; // Verify this import path
import 'package:academity_app/models/class.dart'; // Adjust path as necessary

class ClassesWidget extends ConsumerWidget {
  final Academy academy;
  final List<Classes> classes; // Changed to List<Class>

  const ClassesWidget({
    Key? key,
    required this.academy,
    required this.classes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classAsyncValue =
        ref.watch(classProviderwithAcademy(academy.academyId));

    return classAsyncValue.when(
      data: (classes) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classItem = classes[index];
          return ListTile(
            title: Text(classItem.className),
            subtitle: Text('Age: ${classItem.minAge}-${classItem.maxAge}'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => showClassDetails(context, classItem.classId, ref),
          );
        },
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  }
}
