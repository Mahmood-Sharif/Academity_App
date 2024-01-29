import 'package:academity_app/models/class.dart';
import 'package:flutter/material.dart';

class ClassItem extends StatelessWidget {
  final Classes classInfo;

  const ClassItem({Key? key, required this.classInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(classInfo.className),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            children: [
              tableRow("Day of Week: ", classInfo.dayOfWeek),
              tableRow("Instructor: ", classInfo.instructor),
              tableRow("Price: ", "\$${classInfo.price.toString()}"),
              tableRow("Time: ", "${classInfo.startTime} - ${classInfo.endTime}"),
              tableRow("Age Range: ", "${classInfo.minAge} - ${classInfo.maxAge}"),
            ],
          ),
        ),
      ],
    );
  }

  TableRow tableRow(String label, String value) {
    return TableRow(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
