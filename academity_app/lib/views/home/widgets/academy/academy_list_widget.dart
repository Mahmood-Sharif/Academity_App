import 'package:academity_app/services/academy_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/views/home/academy_detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AcademiesListWidget extends ConsumerWidget {
  final int sportId;

  const AcademiesListWidget({super.key, required this.sportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final academiesAsync = AcademyServices().fetchAcademiesBySportId(sportId);

    return FutureBuilder(
        future: academiesAsync,
        builder: (context, asy) {
          if (asy.hasData) {
            final academies = asy.requireData;
            return ListView.separated(
              itemCount: academies.length,
              separatorBuilder: (context, index) =>
                  const Divider(), // Add a divider between each item
              itemBuilder: (context, index) {
                final academy = academies[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AcademyDetailScreen(academy: academy),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            academy.imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            academy.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        // Row widget to display "Location:" and location in the same line
                        Row(
                          children: [
                            Text(
                              academy.location,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (asy.hasError) {
            return Center(
                child:
                    Text(AppLocalizations.of(context)!.noAcademiesAvailable));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
