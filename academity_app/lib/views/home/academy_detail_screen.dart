import 'dart:async';

import 'package:academity_app/models/class.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/services/errors.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/home/widgets/class/classes_widget.dart';
import 'package:academity_app/views/home/widgets/class/description_widget.dart';
import 'package:academity_app/views/home/widgets/class/location_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AcademyDetailScreen extends ConsumerWidget {
  final Academy academy;

  const AcademyDetailScreen({Key? key, required this.academy})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classAsync =
        ClassServices().fetchClassesByAcademyId(academy.academyId);

    return Scaffold(
      appBar: CustomAppBar(title: academy.name),
      body: AdaptivePadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20.0),
                      top: Radius.circular(20.0)),
                  child: Image.network(academy.imageUrl,
                      width: double.infinity, height: 250, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppLocalizations.of(context)!.descriptionTitle}:',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))),
                    DescriptionWidget(academy: academy),
                    const SizedBox(height: 8),
                    LocationWidget(academy: academy),
                    const SizedBox(height: 8),
                    Text('${AppLocalizations.of(context)!.classesTitle}:',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    FutureBuilder<List<Classes>>(
                      future: classAsync,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return switch (snapshot.error) {
                            NotFound() => Text(AppLocalizations.of(context)!
                                .noClassesAvailable),
                            TimeoutException() =>
                              const Text('Connection Timeout'),
                            _ => Text('Error: ${snapshot.error}'),
                          };
                        } else if (snapshot.hasData) {
                          return ClassesWidget(
                              academy: academy, classes: snapshot.requireData);
                        } else {
                          return Text(
                              AppLocalizations.of(context)!.noClassesAvailable);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
