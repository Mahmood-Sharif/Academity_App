import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/student.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = ModalRoute.of(context)?.settings.arguments as Student?;
    return Scaffold(
       appBar:  CustomAppBar(title: 'Medical',),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                  ),
                  SizedBox(height: 8.0),
                  Divider(
                    // Adding a horizontal line below the avatar
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                       Text('Medical',
                        // AppLocalizations.of(context)!.studentName,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student!.name,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 12.0),
                       Text('Medical',
                        // AppLocalizations.of(context)!.studentPhone,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student.phone,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                       Text('Medical',
                        // AppLocalizations.of(context)!.studentDateOfRegistration,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student.startDate.toString().split(' ')[0],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 12.0),
                       Text('Medical',
                        // AppLocalizations.of(context)!.studentRenewalDate,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student.endDate.toString().split(' ')[0],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Card(
              color: Colors.red[200],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                     Text(
                      // AppLocalizations.of(context)!.studentMedicalCondition,
                      'Medical',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Medical',
                      // student.medicalCondition ??
                      //     AppLocalizations.of(context)!.studentMedicalConditionNone,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
