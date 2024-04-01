import 'package:academity_app/views/MyAcademy/widgets/subscription_details.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart';

class SubscriptionScreen extends StatelessWidget {
  final Academy academy;

  const SubscriptionScreen({Key? key, required this.academy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: academy.name,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MySubscriptionDetails(academy: academy),
      ),
    );
  }
}
