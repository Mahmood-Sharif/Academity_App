import 'package:academity_app/views/my_academy/widgets/enrolled_academy_list.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAcademyPage extends StatelessWidget {
  const MyAcademyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.myAcademyTitle,
        showBackButton: false,
      ),
      body: const EnrolledAcademiesListWidget(),
    );
  }
}
