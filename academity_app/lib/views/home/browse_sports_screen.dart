import 'package:academity_app/models/sport.dart';
import 'package:academity_app/services/sports_services.dart';
import 'package:academity_app/views/home/widgets/sport/sports_griview.dart';
import 'package:flutter/material.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  late Future<List<Sport>> futureSports;

  @override
  void initState() {
    super.initState();
    futureSports = SportsService().fetchSports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports'),
      ),
      body: FutureBuilder<List<Sport>>(
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
