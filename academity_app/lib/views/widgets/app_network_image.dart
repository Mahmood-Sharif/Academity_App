import 'package:academity_app/design/app_theme.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double radius;
  final IconData fallbackIcon;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius = AppRadii.md,
    this.fallbackIcon = Icons.image_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: url.trim().isEmpty
          ? _Fallback(
              width: width,
              height: height,
              icon: fallbackIcon,
            )
          : Image.network(
              url,
              width: width,
              height: height,
              fit: fit,
              webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
              errorBuilder: (_, __, ___) => _Fallback(
                width: width,
                height: height,
                icon: fallbackIcon,
              ),
            ),
    );
  }
}

class _Fallback extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData icon;

  const _Fallback({
    required this.width,
    required this.height,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEAF6F7), Color(0xFFF7FAFC)],
        ),
      ),
      child: Icon(icon, color: AppColors.brandDark.withValues(alpha: .52)),
    );
  }
}
