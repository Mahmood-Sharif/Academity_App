import 'package:academity_app/views/my_academy/widgets/subscription_details.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/academy.dart';

class SubscriptionScreen extends StatelessWidget {
  final Academy academy;

  const SubscriptionScreen({super.key, required this.academy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: academy.name,
        subtitle: 'Subscription details',
      ),
      body: AdaptivePadding(
        child: MySubscriptionDetails(academy: academy),
      ),
    );
  }
}
