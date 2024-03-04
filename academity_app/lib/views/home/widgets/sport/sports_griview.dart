import 'package:academity_app/models/sport.dart';
import 'package:academity_app/providers/sports_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SportsListWidget extends ConsumerWidget {
  const SportsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Sport>> sports = ref.watch(sportsProvider);

    return sports.when(
      data: (sports) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Set the number of columns in the grid to 4
          childAspectRatio:
              0.75, // Adjust the aspect ratio for grid items (width / height)
          crossAxisSpacing: 10, // Space between items horizontally
          mainAxisSpacing: 10, // Space between items vertically
        ),
        itemCount: sports.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Handle the tap event, e.g., navigate to a detail page
                    Navigator.pushNamed(
                      context,
                      '/sport-detail',
                      arguments: sports[index]
                          .sportsId, // Assuming your Sport model has an id field
                    );
                  },
                  child: Container(
                    width: double
                        .infinity, // Ensure the container takes up all the width available
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   image: NetworkImage(sports[index].imageUrl),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  sports[index].sportName,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
