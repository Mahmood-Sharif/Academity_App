import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/views/home/browse_academy_screen.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class SportsListWidget extends StatelessWidget {
  final List<Sport> sports;

  const SportsListWidget({super.key, required this.sports});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 230,
        childAspectRatio: .92,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: sports.length,
      itemBuilder: (context, index) {
        final sport = sports[index];
        return _SportCard(sport: sport, index: index);
      },
    );
  }
}

class _SportCard extends StatelessWidget {
  final Sport sport;
  final int index;

  const _SportCard({required this.sport, required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = _palette[index % _palette.length];
    final title = AppLocalizations.of(
      context,
    )!
        .sportTitle(sport.sportName.toLowerCase());

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.md),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BrowseAcademyScreen(sport: sport),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.md),
            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withValues(alpha: .08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.md),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (sport.imageUrl.isNotEmpty)
                  Image.network(
                    sport.imageUrl,
                    fit: BoxFit.cover,
                    webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                    errorBuilder: (_, __, ___) => _SportFallback(
                      colors: colors,
                      sportName: sport.sportName,
                    ),
                  )
                else
                  _SportFallback(colors: colors, sportName: sport.sportName),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.navy.withValues(alpha: .04),
                        AppColors.navy.withValues(alpha: .76),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  right: 12,
                  bottom: 14,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 19,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SportFallback extends StatelessWidget {
  final List<Color> colors;
  final String sportName;

  const _SportFallback({required this.colors, required this.sportName});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Center(
        child: Icon(
          _iconFor(sportName),
          color: Colors.white.withValues(alpha: .86),
          size: 56,
        ),
      ),
    );
  }
}

IconData _iconFor(String sportName) {
  switch (sportName.toLowerCase()) {
    case 'basketball':
      return Icons.sports_basketball_rounded;
    case 'football':
      return Icons.sports_soccer_rounded;
    case 'boxing':
      return Icons.sports_mma_rounded;
    case 'taekwondo':
      return Icons.sports_martial_arts_rounded;
    case 'fencing':
      return Icons.sports_kabaddi_rounded;
    case 'padel':
      return Icons.sports_tennis_rounded;
    default:
      return Icons.fitness_center_rounded;
  }
}

const _palette = [
  [AppColors.navy, AppColors.brand],
  [AppColors.brandDark, AppColors.teal],
  [AppColors.slate, AppColors.coral],
  [Color(0xFF23395D), AppColors.gold],
  [Color(0xFF174A4F), Color(0xFF78D5D7)],
  [Color(0xFF263238), Color(0xFF90A4AE)],
];
