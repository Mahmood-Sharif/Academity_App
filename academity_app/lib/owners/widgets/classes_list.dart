import 'package:flutter/material.dart';
import 'package:academity_app/models/class.dart';

class ClassListItem extends StatelessWidget {
  final Classes classDetail;

  const ClassListItem({Key? key, required this.classDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(classDetail.className),
        subtitle: Text(
            'Day: ${classDetail.dayOfWeek}, Time: ${classDetail.startTime} - ${classDetail.endTime}, Age: ${classDetail.minAge}-${classDetail.maxAge}'),
      ),
    );
  }
}
