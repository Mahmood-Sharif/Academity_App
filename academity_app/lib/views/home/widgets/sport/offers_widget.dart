import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OffersWidget extends ConsumerWidget {
  const OffersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(AppLocalizations.of(context)!.noAcademiesAvailable)
      ],
    );
  }
}
