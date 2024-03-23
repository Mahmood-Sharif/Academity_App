import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/providers/academies_provider.dart';
import 'package:academity_app/providers/classes_provider.dart';
import 'package:academity_app/views/home/browse_all_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcademiesListWidget extends ConsumerWidget {
  const AcademiesListWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final academies = ref.watch(academyProvider);

    return academies.when(
      data: (academies) => ListView.builder(
        itemCount: academies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllClassesPage(
                    academyId: academies[index].academyId,
                    name: academies[index].name,
                  ),
                ),
              );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // Add image decoration if available
                        // image: DecorationImage(
                        //   image: NetworkImage(classes[index].imageUrl),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    const SizedBox(width: 16), // Add some spacing between image and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            academies[index].name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                            Text(
                            academies[index].location.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Add spacing between class name and subtext
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
