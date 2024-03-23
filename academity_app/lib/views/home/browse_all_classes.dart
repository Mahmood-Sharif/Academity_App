
import 'package:academity_app/models/class_with_timing.dart';
import 'package:academity_app/services/class_service.dart';
import 'package:academity_app/views/home/widgets/class/allClasses_griview.dart';
import 'package:flutter/material.dart';

 class AllClassesPage extends StatelessWidget {
   final int academyId;
   final String name;
  const AllClassesPage({Key? key, required this.academyId, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(name, style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B0000),
        iconTheme: IconThemeData(color: Colors.white), // Set the color of the back button to white
      ),
      body: FutureBuilder<List<ClassWithTiming>>(
        future: ClassServices().fetchClassesByAcademyId(academyId), // Replace 2 with the actual class ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<ClassWithTiming> students = snapshot.data ?? [];
            return AllClassListWidget(academyId: academyId ); // Pass the students data to the StudentListWidget
          }
        },
      ),
    );
  }
}
