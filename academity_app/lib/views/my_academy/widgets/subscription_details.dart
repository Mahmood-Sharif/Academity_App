import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MySubscriptionDetails extends StatelessWidget {
  final Academy academy;

  const MySubscriptionDetails({Key? key, required this.academy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.network(
          academy.imageUrl,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: academy.classes?.map((classDetail) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classDetail.className,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.registrationDateLabel,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        classDetail.getFormattedStartDate(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.renewalDateLabel,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        classDetail.getFormattedEndDate(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!
                            .priceTitle(classDetail.price),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   "\$${classDetail.price}",
                      //   style: const TextStyle(fontSize: 16),
                      // ),
                      const Divider(height: 32, thickness: 2),
                    ],
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
