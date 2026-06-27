import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:academity_app/views/home/academy_detail_screen.dart';
import 'package:academity_app/views/widgets/app_network_image.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class AcademiesListWidget extends ConsumerWidget {
  final int sportId;

  const AcademiesListWidget({super.key, required this.sportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final academiesAsync = AcademyServices().fetchAcademiesBySportId(sportId);

    return FutureBuilder(
      future: academiesAsync,
      builder: (context, asy) {
        if (asy.hasData) {
          final academies = asy.requireData;
          if (academies.isEmpty) {
            return AppEmptyState(
              icon: Icons.school_outlined,
              title: AppLocalizations.of(context)!.noAcademiesAvailable,
              body: 'No academies are available for this sport yet.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 28),
            itemCount: academies.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.lg),
            itemBuilder: (context, index) {
              final academy = academies[index];
              return InkWell(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AcademyDetailScreen(academy: academy),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AcademyImage(
                      imageUrl: academy.imageUrl,
                      name: academy.name,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 14, 4, 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              academy.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.brand,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.muted,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              academy.location,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.muted,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (asy.hasError) {
          return AppErrorState(error: asy.error!);
        } else {
          return const AppLoadingState(label: 'Loading academies');
        }
      },
    );
  }
}

class _AcademyImage extends StatelessWidget {
  final String imageUrl;
  final String name;

  const _AcademyImage({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppNetworkImage(
          url: imageUrl,
          width: double.infinity,
          height: 220,
          radius: AppRadii.lg,
          fallbackIcon: Icons.school_rounded,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.lg),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: .68),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      ],
    );
  }
}
