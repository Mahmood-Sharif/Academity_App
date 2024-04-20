import 'package:academity_app/services/academy_services.dart';
import 'package:academity_app/views/my_academy/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/providers/academy_provider.dart'; // Make sure this is the correct path
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnrolledAcademiesListWidget extends ConsumerWidget {
  const EnrolledAcademiesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledAcademiesAsyncValue = ref.watch(enrolledAcademiesProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(enrolledAcademiesProvider.future),
      child: enrolledAcademiesAsyncValue.when(
        data: (List<Academy> academies) => ListView.separated(
          itemCount: academies.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final academy = academies[index];
            return InkWell(
              onTap: () {
                // Navigate to SubscriptionScreen with the selected academy
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionScreen(
                        academy:
                            academy), // Adjust SubscriptionScreen to accept an Academy object
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
                    Text(
                      AppLocalizations.of(context)!
                          .locationLabel(academy.location),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          if (error is NotFound) {
            return Center(
                child: Text(AppLocalizations.of(context)!.notEnrolledMessage));
          } else {
            return Center(child: Text('Error: $error'));
          }
        },
      ),
    );
  }
}
