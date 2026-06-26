import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/models/class.dart'; // Verify this import path
import 'package:academity_app/views/home/widgets/class/class_details.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class ClassesWidget extends StatelessWidget {
  final Academy academy;
  final List<Classes> classes;

  const ClassesWidget(
      {super.key, required this.academy, required this.classes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classItem = classes[index];
        return ListTile(
          title: Text(classItem.className),
          subtitle: Text(
            '${AppLocalizations.of(context)!.descriptionTitle} ${classItem.minAge}-${classItem.maxAge}',
          ),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () => showClassDetails(
            context,
            classItem.classId,
          ),
        );
      },
    );
  }
}
