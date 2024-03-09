import 'package:academity_app/models/sport.dart';
import 'package:academity_app/services/sports_services.dart';
import 'package:academity_app/views/home/widgets/sport/cards_widget.dart';
import 'package:academity_app/views/home/widgets/sport/sports_griview.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  late Future<List<Sport>> futureSports;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    futureSports = SportsService().fetchSports();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const CustomAppBar(title: 'Home'),
    body: FutureBuilder<List<Sport>>(
      future: futureSports,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Use ListView to allow everything to scroll together
          return ListView(
            children: [
              const SizedBox(height: 20),
              // SportsListWidget adapted to be non-scrollable
              SportsListWidget(sports: snapshot.data ?? []), // Assuming you adapt SportsListWidget
              // TwoCardsSideBySide widget displayed after SportsListWidget
              const TwoCardsSideBySide(),
            ],
          );
        }
      },
    ),
    bottomNavigationBar: CustomBottomNavBar(
      selectedIndex: _selectedIndex,
      onItemSelected: _onItemTapped,
    ),
  );
}


}
