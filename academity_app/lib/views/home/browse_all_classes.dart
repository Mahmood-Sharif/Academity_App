import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/class_with_timing.dart';
import 'package:academity_app/services/class_service.dart';
import 'package:academity_app/views/home/widgets/class/allClasses_griview.dart';
import 'package:academity_app/views/home/widgets/class/classes_griview.dart';
import 'package:flutter/material.dart';

 class AllClassesPage extends StatelessWidget {
  const AllClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final academyId = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All classes', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B0000),
        iconTheme: IconThemeData(color: Colors.white), // Set the color of the back button to white
      ),
      body: FutureBuilder<List<ClassWithTiming>>(
        future: ClassServices().fetchClassesByAcademyId(2), // Replace 2 with the actual class ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<ClassWithTiming> students = snapshot.data ?? [];
            return AllClassListWidget(academyId: academyId as int); // Pass the students data to the StudentListWidget
          }
        },
      ),
    );
  }
}
