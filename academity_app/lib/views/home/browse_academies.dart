import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:academity_app/views/home/widgets/academy/coach_academies_gridview.dart';
import 'package:flutter/material.dart';

class CoachAcademiesPage extends StatefulWidget {
  const CoachAcademiesPage({Key? key}) : super(key: key);

  @override
  State<CoachAcademiesPage> createState() => _CoachAcademiesPageState();
}

class _CoachAcademiesPageState extends State<CoachAcademiesPage> {
  late Future<List<Academy>> futureSports;

  @override
  void initState() {
    super.initState();
    futureSports = AcademyServices().fetchAcademiesByCoachId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF8B0000), // Set the background color to dark red
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16), // Adjust the padding as needed
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
      body: FutureBuilder<List<Academy>>(
        future: futureSports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const CoachAcademiesListWidget();
          }
        },
      ),
    );
  }
}
