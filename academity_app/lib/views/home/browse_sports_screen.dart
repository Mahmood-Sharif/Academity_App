import 'package:academity_app/services/sports_services.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/home/widgets/sport/sports_griview.dart';
import 'package:academity_app/models/sport.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({Key? key}) : super(key: key);

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  final SportsService _sportsService = SportsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: AppLocalizations.of(context)!.exploreTitle,
        showBackButton: false, // Ensures the back button is not shown
      ),
      body: FutureBuilder<List<Sport>>(
        future: _sportsService.fetchSports(),
        builder: (BuildContext context, AsyncSnapshot<List<Sport>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                SportsListWidget(sports: snapshot.data!),
                const SizedBox(height: 20),
                // const TwoCardsSideBySide(),
              ],
            );
          } else {
            // This case handles empty data
            return  Center(child: Text(AppLocalizations.of(context)!.noSportsAvailable));
          }
        },
      ),
    );
  }
}
