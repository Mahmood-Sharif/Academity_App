/*import 'package:academity_app/providers/academy_provider.dart';
import 'package:academity_app/views/home/academy_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcademiesListWidget extends ConsumerWidget {
  final int sportId;

  const AcademiesListWidget({Key? key, required this.sportId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final academiesAsyncValue = ref.watch(academiesProvider(sportId));

    return academiesAsyncValue.when(
      data: (academies) => ListView.builder(
        itemCount: academies.length,
        itemBuilder: (context, index) {
          final academy = academies[index];
          return ListTile(
            title: Text(academy.name),
            subtitle: Text(academy.location),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AcademyDetailScreen(academy: academy),
                ),
              );
            },
          );
        },
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  }
}*/
