import 'package:academity_app/services/academy_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/views/home/academy_detail_screen.dart';
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
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: academies.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final academy = academies[index];
              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AcademyDetailScreen(academy: academy),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AcademyImage(
                        imageUrl: academy.imageUrl,
                        name: academy.name,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 12, 4, 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                academy.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Color(0xFFFF3200),
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
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                academy.location,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (asy.hasError) {
          return Center(
            child: Text(AppLocalizations.of(context)!.noAcademiesAvailable),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
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
    final fallback = Container(
      height: 210,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF008B8B), Color(0xFFFF6B35)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -18,
            child: Icon(
              Icons.school_rounded,
              size: 150,
              color: Colors.white.withValues(alpha: .18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ),
        ],
      ),
    );

    if (imageUrl.isEmpty) return fallback;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: 210,
        fit: BoxFit.cover,
        webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }
}
