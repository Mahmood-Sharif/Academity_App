import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:academity_app/views/home/widgets/academy/coach_academies_gridview.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      // appBar:  CustomAppBar(title: AppLocalizations.of(context)!.myAcademiesTitle),
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
