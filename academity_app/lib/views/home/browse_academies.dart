import 'dart:async';

import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:academity_app/views/home/widgets/academy/coach_academies_gridview.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class CoachAcademiesPage extends StatefulWidget {
  const CoachAcademiesPage({super.key});

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
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.myAcademyTitle),
      body: AdaptivePadding(
        child: FutureBuilder<List<Academy>>(
          future: futureSports,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoadingState(label: 'Loading coach academies');
            } else if (snapshot.hasError) {
              final error = snapshot.error!;
              if (error.runtimeType == TimeoutException) {
                return const AppEmptyState(
                  icon: Icons.wifi_off_rounded,
                  title: 'Connection timeout',
                  body: 'Please check your internet connection and try again.',
                );
              } else {
                return AppErrorState(error: error);
              }
            } else {
              return const CoachAcademiesListWidget();
            }
          },
        ),
      ),
    );
  }
}
