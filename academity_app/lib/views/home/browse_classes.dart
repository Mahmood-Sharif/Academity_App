import 'package:academity_app/providers/classes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowseClasses extends ConsumerWidget {
  const BrowseClasses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final classesAsync = ref.watch(classes_provider);
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Classes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            const SizedBox(height: 20),
            // Display a list of available classes
            const Text('Available Classes'),
            const SizedBox(height: 10),
            // Replace with actual data fetching and rendering of classes
           switch (classesAsync) {
             AsyncData(value : final classes) => ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('Class id: ${classes[index].className}'),
                //onTap: () => Navigator.pushNamed(context, '/classDetails', arguments: index + 1), // Pass class index to details screen
              ),
            ), 
             AsyncError(error: final error) => Text('Could not load classes'),
             _ => CircularProgressIndicator()
           },
          ],
        ),
      ),
    );
  }
}
