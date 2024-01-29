import 'package:flutter/material.dart';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/users/widgets/class_list.dart';

class ClassesListWidget extends StatelessWidget {
  final List<dynamic> classes; // Replace with your specific classes model if available

  const ClassesListWidget({Key? key, required this.classes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: classes.length,
      itemBuilder: (context, index) {
        var classInfo = Classes.fromJson(classes[index]); // Convert Map to Classes instance
        return ClassItem(classInfo: classInfo);
      },
    );
  }
}
