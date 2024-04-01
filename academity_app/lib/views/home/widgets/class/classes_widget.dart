import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/models/class.dart'; // Verify this import path
import 'package:academity_app/services/class_services.dart'; // Adjust path as necessary
import 'package:academity_app/views/home/widgets/class/class_details.dart';

class ClassesWidget extends StatelessWidget {
  final Academy academy;

  ClassesWidget({Key? key, required this.academy, required List<Classes> classes}) : super(key: key);

  final ClassServices _classServices =
      ClassServices(); // Instantiate your service here

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Classes>>(
      future: _classServices.fetchClasses(academy.academyId),
      builder: (BuildContext context, AsyncSnapshot<List<Classes>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final classItem = snapshot.data![index];
              return ListTile(
                title: Text(classItem.className),
                subtitle: Text('Age: ${classItem.minAge}-${classItem.maxAge}'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => showClassDetails(
                  context,
                  classItem.classId,
                ),
              );
            },
          );
        } else {
          return const Text('No classes available');
        }
      },
    );
  }
}
