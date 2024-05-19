import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/Profile/widgets/section_card.dart';
import 'package:academity_app/views/Profile/widgets/language_modal_sheet.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context, WidgetRef ref) {
    ref.read(authProvider.notifier).logout().catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $error'),
        ),
      );
    });
  }

  void _navigateToUserProfile(BuildContext context) {
    // Define navigation logic here. For example:
    Navigator.of(context)
        .pushNamed('/userProfile'); // Adjust route as necessary
  }

  void navigateToCustomerSupport(BuildContext context) async {
    const String waWebUrl = "https://wa.link/qbcghz"; // Your WhatsApp link

    // Launch the URL

    await launchUrl(Uri.parse(waWebUrl)).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to open the link."),
      ));
      return false;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.profileActionTitle,
        showBackButton: false,
      ),
      body: AdaptivePadding(
        child: ListView(
          children: <Widget>[
            SectionCard(
              title: AppLocalizations.of(context)!.accountSectionTitle,
              items: [
                if (ref.read(authProvider.notifier).canSwitchType)
                  {
                    'title':
                        '${AppLocalizations.of(context)!.swapToLabel} ${ref.read(authProvider).requireValue!.type == 'coach' ? AppLocalizations.of(context)!.playerLabel : AppLocalizations.of(context)!.coachLabel}',
                    'icon': Icons.swap_horiz_rounded,
                    'onTap': () =>
                        ref.read(authProvider.notifier).changeUserType()
                  },
                {
                  'title': AppLocalizations.of(context)!.profileActionTitle,
                  'icon': Icons.person,
                  'onTap': () => _navigateToUserProfile(context)
                },
                {
                  'title': AppLocalizations.of(context)!
                      .privacyAndSecurityActionTitle,
                  'icon': Icons.lock,
                },
                {
                  'title': AppLocalizations.of(context)!
                      .switchLanguageLabel, // Add a title for your language switcher, make sure to define it in your localization files
                  'icon': Icons.language,
                  'onTap': () => showLanguageSelectionBottomSheet(context, ref),
                },
              ],
            ),
            SectionCard(
              title: AppLocalizations.of(context)!.actionsSectionTitle,
              items: [
                {
                  'title':
                      AppLocalizations.of(context)!.reportAProblemActionTitle,
                  'icon': Icons.report_problem
                },
                {
                  'title': AppLocalizations.of(context)!.customerSupportLabel,
                  'icon': Icons.support_agent,
                  'onTap': () => navigateToCustomerSupport(context)
                },
                {
                  'title': AppLocalizations.of(context)!.logoutActionTitle,
                  'icon': Icons.logout,
                  'onTap': () => _logout(context, ref), // Updated logout call
                },
              ],
            ),
            const SizedBox(height: 16),
            FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    final version = asyncSnapshot.requireData.version;
                    return Center(
                        child: Text(
                            AppLocalizations.of(context)!.appVersion(version)));
                  } else {
                    return const SizedBox();
                  }
                }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
