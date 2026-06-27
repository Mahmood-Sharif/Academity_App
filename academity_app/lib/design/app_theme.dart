import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const ink = Color(0xFF172026);
  static const muted = Color(0xFF667085);
  static const line = Color(0xFFE6E8EC);
  static const canvas = Color(0xFFF6F8FB);
  static const surface = Color(0xFFFFFFFF);
  static const brand = Color(0xFFE93423);
  static const brandDark = Color(0xFF831D1A);
  static const teal = Color(0xFF087E8B);
  static const navy = Color(0xFF1B2A41);
  static const gold = Color(0xFFF4A261);
  static const success = Color(0xFF159A74);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFC2412D);
}

class AppSpacing {
  static const xs = 6.0;
  static const sm = 10.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

class AppRadii {
  static const sm = 10.0;
  static const md = 16.0;
  static const lg = 22.0;
  static const pill = 999.0;
}

class AppShadows {
  static List<BoxShadow> soft = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .07),
      blurRadius: 28,
      offset: const Offset(0, 14),
    ),
  ];
}

class AcademityTheme {
  static ThemeData light(BuildContext context) {
    final baseTextTheme = GoogleFonts.montserratTextTheme(
      Theme.of(context).textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brand,
        primary: AppColors.brand,
        secondary: AppColors.teal,
        tertiary: AppColors.gold,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      scaffoldBackgroundColor: AppColors.canvas,
      textTheme: baseTextTheme.apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 74,
        backgroundColor: Colors.white,
        elevation: 0,
        indicatorColor: AppColors.brand.withValues(alpha: .11),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w800
                : FontWeight.w600,
            color: states.contains(WidgetState.selected)
                ? AppColors.brandDark
                : AppColors.muted,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.brand,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          textStyle: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.brandDark,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          textStyle: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.brand, width: 1.6),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.navy,
        contentTextStyle: GoogleFonts.montserrat(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.brand,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.montserrat(
          color: AppColors.ink,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
