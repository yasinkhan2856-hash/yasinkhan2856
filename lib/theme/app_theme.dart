import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const background = Color(0xFFECEEF1);
  static const surface = Color(0xFFFFFFFF);
  static const sidebar = Color(0xFF111827);
  static const sidebarMuted = Color(0xFF9CA3AF);
  static const border = Color(0xFFD1D5DB);
  static const borderLight = Color(0xFFE5E7EB);
  static const text = Color(0xFF111827);
  static const textSecondary = Color(0xFF374151);
  static const muted = Color(0xFF6B7280);
  static const accent = Color(0xFF2563EB);
  static const accentDark = Color(0xFF1D4ED8);
  static const statsBg = Color(0xFF1F2937);
  static const heroTag = Color(0xFF2563EB);
}

abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.light,
        surface: AppColors.surface,
      ),
    );

    final poppins = GoogleFonts.poppinsTextTheme(base.textTheme);
    final inter = GoogleFonts.interTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: poppins.copyWith(
        displayLarge: poppins.displayLarge?.copyWith(
          fontSize: 58,
          height: 1.05,
          fontWeight: FontWeight.w800,
          color: AppColors.text,
          letterSpacing: -0.5,
        ),
        displayMedium: poppins.displayMedium?.copyWith(
          fontSize: 38,
          height: 1.1,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
        ),
        headlineMedium: poppins.headlineMedium?.copyWith(
          fontSize: 22,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
        ),
        titleLarge: poppins.titleLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
        bodyLarge: inter.bodyLarge?.copyWith(
          fontSize: 16,
          height: 1.75,
          color: AppColors.muted,
        ),
        bodyMedium: inter.bodyMedium?.copyWith(
          fontSize: 14,
          height: 1.7,
          color: AppColors.muted,
        ),
        labelLarge: poppins.labelLarge?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        labelStyle: const TextStyle(color: AppColors.muted),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
