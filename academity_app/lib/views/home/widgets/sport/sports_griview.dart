import 'package:academity_app/views/home/browse_academy_screen.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/sport.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SportsListWidget extends StatelessWidget {
  final List<Sport> sports;

  const SportsListWidget({super.key, required this.sports});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: sports.length,
        itemBuilder: (context, index) {
          final sport = sports[index];
          return InkWell(
            onTap: () {
              // Handle the tap event here. For example, navigate to a detail screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BrowseAcademyScreen(
                    sport: sport,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(sport.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                AppLocalizations.of(context)!
                    .sportTitle(sport.sportName.toLowerCase()),
                style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.8),
                    fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
