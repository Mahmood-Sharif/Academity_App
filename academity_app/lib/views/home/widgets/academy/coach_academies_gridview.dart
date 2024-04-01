import 'package:academity_app/services/academy_services.dart';
import 'package:academity_app/views/home/coach_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoachAcademiesListWidget extends ConsumerWidget {
  const CoachAcademiesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: AcademyServices().fetchAcademiesByCoachId(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final academies = asyncSnapshot.requireData;
            return ListView.builder(
              itemCount: academies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoachClassesPage(
                            academyId: academies[index].academyId,
                            academyName: academies[index].name,
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
                              image: DecorationImage(
                                image: NetworkImage(academies[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  16), // Add some spacing between image and text
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
                                const SizedBox(
                                    height:
                                        8), // Add spacing between class name and subtext
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (asyncSnapshot.hasError) {
            final error = asyncSnapshot.error;
            return Text('Error: $error');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
