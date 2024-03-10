import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/class_with_timing.dart';
import 'package:academity_app/services/class_service.dart';
import 'package:academity_app/views/home/widgets/sport/classes_griview.dart';
import 'package:flutter/material.dart';

class AcademiesPage extends StatefulWidget {
  const AcademiesPage({Key? key}) : super(key: key);

  @override
  _AcademiesPageState createState() => _AcademiesPageState();
}

class _AcademiesPageState extends State<AcademiesPage> {
  late Future<List<ClassWithTiming>> futureSports;

  @override
  void initState() {
    super.initState();
    futureSports = ClassServices().fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B0000), // Set the background color to dark red
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16), // Adjust the padding as needed
          alignment: Alignment.center,
          child: const Text(
            'My Academies',
            style: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<ClassWithTiming>>(
        future: futureSports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const ClassListWidget();
          }
        },
      ),
    );
  }
}