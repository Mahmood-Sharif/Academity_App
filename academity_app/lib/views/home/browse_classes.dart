import 'package:academity_app/models/class.dart';
import 'package:academity_app/services/class_service.dart';
//import 'package:academity_app/views/home/widgets/sport/sports_griview.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  late Future<List<Class>> futureSports;

  @override
  void initState() {
    super.initState();
    futureSports = ClassServices().fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
        
      ),
      body: FutureBuilder<List<Class>>(
        future: futureSports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const SportsListWidget();
          }
        },
      ),
    );
  }
}
