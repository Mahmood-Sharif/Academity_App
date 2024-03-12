import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/class_with_timing.dart';
import 'package:academity_app/services/class_service.dart';
import 'package:academity_app/views/home/widgets/class/classes_griview.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
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
            'My Schedule',
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