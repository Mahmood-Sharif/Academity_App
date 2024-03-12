import 'package:academity_app/providers/sports_provider.dart';
import 'package:academity_app/views/home/widgets/sport/cards_widget.dart';
import 'package:academity_app/views/home/widgets/sport/sports_griview.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Make sure your SportsPage is now a ConsumerWidget or ConsumerStatefulWidget
class SportsPage extends ConsumerStatefulWidget {
  const SportsPage({super.key});

  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends ConsumerState<SportsPage> {

  @override
  Widget build(BuildContext context) {
    // Use Riverpod's ConsumerWidget features
    final sportsFuture = ref.watch(sportsProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      body: sportsFuture.when(
        data: (sports) => ListView(
          children: [
            const SizedBox(height: 20),
            SportsListWidget(sports: sports),
            const SizedBox(height: 20),
            const TwoCardsSideBySide(),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
