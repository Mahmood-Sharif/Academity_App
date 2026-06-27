import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/env.dart';
import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/Profile/widgets/section_card.dart';
import 'package:academity_app/views/Profile/widgets/language_modal_sheet.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_card.dart';
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
        subtitle: 'Account, language, and support',
      ),
      body: AdaptivePadding(
        child: ListView(
          children: <Widget>[
            AppCard(
              color: AppColors.navy,
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authState.valueOrNull?.name ?? 'Academity member',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          authState.valueOrNull?.type ?? 'user',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
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
