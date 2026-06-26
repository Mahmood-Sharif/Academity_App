import 'package:academity_app/env.dart';
import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/Profile/widgets/section_card.dart';
import 'package:academity_app/views/Profile/widgets/language_modal_sheet.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';
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
    Navigator.of(context).pushNamed('/userProfile');
  }

  void navigateToCustomerSupport(BuildContext context) async {
    const String waWebUrl = "https://wa.link/qbcghz";

    await launchUrl(Uri.parse(waWebUrl)).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to open the link."),
      ));
      return false;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

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
                if (authNotifier.canSwitchType && authState.hasValue)
                  {
                    'title':
                        '${AppLocalizations.of(context)!.swapToLabel} ${authState.requireValue!.type == 'coach' ? AppLocalizations.of(context)!.playerLabel : AppLocalizations.of(context)!.coachLabel}',
                    'icon': Icons.swap_horiz_rounded,
                    'onTap': () => authNotifier.changeUserType(),
                  },
                {
                  'title': AppLocalizations.of(context)!.profileActionTitle,
                  'icon': Icons.person,
                  'onTap': () => _navigateToUserProfile(context),
                },
                {
                  'title': AppLocalizations.of(context)!
                      .privacyAndSecurityActionTitle,
                  'icon': Icons.lock,
                },
                {
                  'title': AppLocalizations.of(context)!.switchLanguageLabel,
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
                  'icon': Icons.report_problem,
                },
                {
                  'title': AppLocalizations.of(context)!.customerSupportLabel,
                  'icon': Icons.support_agent,
                  'onTap': () => navigateToCustomerSupport(context),
                },
                {
                  'title': AppLocalizations.of(context)!.logoutActionTitle,
                  'icon': Icons.logout,
                  'onTap': () => _logout(context, ref),
                },
              ],
            ),
            const SizedBox(height: 16),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(
                baseUrl: '${Env.academityUrl}app/',
              ),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  final version = asyncSnapshot.requireData.version;
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.appVersion(version),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
