import 'package:academity_app/views/home/browse_academy_screen.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/sport.dart';

class SportsListWidget extends StatelessWidget {
  final List<Sport> sports;

  const SportsListWidget({Key? key, required this.sports}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
      itemCount: sports.length,
      itemBuilder: (context, index) {
        final sport = sports[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () {
              // Handle the tap event here. For example, navigate to a detail screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BrowseAcademyScreen(sportId: sport.sportsId,),
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
                sport.sportName,
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
