import 'package:academity_app/services/class_services.dart';
import 'package:academity_app/views/home/widgets/class/register_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/class.dart'; // Adjust path as necessary
import 'package:intl/intl.dart'; // Ensure this is correctly imported
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showClassDetails(BuildContext context, int classId) {
  final academityApi = ClassServices()
      .fetchClassDetails(classId); // Instantiate your API service here

  showModalBottomSheet(
    context: context,
    builder: (context) => FutureBuilder<Classes>(
      future: academityApi,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final classItem = snapshot.data!;
          final hasTimings = classItem.timings.isNotEmpty;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                      AppLocalizations.of(context)!
                          .classNameTitle(classItem.className),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.priceTitle(classItem.price)} ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      // TextSpan(
                      //     text: classItem.price,
                      //     style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text('${AppLocalizations.of(context)!.trainingDaysTitle}: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Expanded(
                  child: hasTimings
                      ? ListView.builder(
                          itemCount: classItem.timings.length,
                          itemBuilder: (context, index) {
                            final timing = classItem.timings[index];
                            final startTime =
                                DateFormat('HH:mm:ss').parse(timing.startTime);
                            final endTime =
                                DateFormat('HH:mm:ss').parse(timing.endTime);
                            return ListTile(
                              title: Text(timing.dayOfWeek,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)}'),
                            );
                          },
                        )
                      : Center(
                          child: Text(AppLocalizations.of(context)!
                              .noTimingsAvailable)),
                ),
                const RegisterButtonWidget(),
              ],
            ),
          );
        } else {
          return Text(AppLocalizations.of(context)!.noClassesAvailable);
        }
      },
    ),
  );
}
