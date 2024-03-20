import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/providers/class_provider.dart'; // Adjust path as necessary
import 'package:academity_app/views/home/widgets/class/classes_widget.dart';
import 'package:academity_app/views/home/widgets/class/description_widget.dart';
import 'package:academity_app/views/home/widgets/class/location_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademyDetailScreen extends ConsumerWidget {
  final Academy academy;

  const AcademyDetailScreen({Key? key, required this.academy})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classesAsyncValue =
        ref.watch(classProviderwithAcademy(academy.academyId));

    return Scaffold(
      appBar: CustomAppBar(title: academy.name),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20.0), top: Radius.circular(20.0)),
                //child: Image.network(academy.imageUrl,
                  //  width: double.infinity, height: 250, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                  DescriptionWidget(academy: academy),
                  const SizedBox(height: 8),
                  LocationWidget(academy: academy),
                  const SizedBox(height: 8),
                  const Text('Classes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  classesAsyncValue.when(
                    data: (classes) => ClassesWidget(
                        academy: academy,
                        classes: classes), // Now correctly passing List<Class>
                    loading: () => const CircularProgressIndicator(),
                    error: (error, _) => Text('Error: $error'),
                  ),
                  // const RegisterButtonWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
