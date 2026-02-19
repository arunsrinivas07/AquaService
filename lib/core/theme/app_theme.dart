// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds
  static const background = Color(0xFFECF4F8); // merged softer blue
  static const surface = Colors.white;
  static const cardBackground = Colors.white;
  static const balanceCardBg = Colors.white;

  // Primary / Teal palette
  static const primary = Color(0xFF00BCD4);
  static const teal = Color(0xFF4DD0E1);
  static const tealLight = Color(0xFFB2EBF2);
  static const tealBg = Color(0xFFE0F7FA);
  static const tealBorder = Color(0xFFB2EBF2);
  static const tealDark = Color(0xFF00ACC1);
  static const primaryLight = Color(0xFFE0F7FA);

  // Status / Badges
  static const dueBadgeBorder = Color(0xFFE53935);
  static const dueBadgeText = Color(0xFFE53935);
  static const activeBadge = Color(0xFF4CAF50);

  // Text
  static const textPrimary = Color(0xFF0D1B2A);
  static const textSecondary = Color(0xFF6B7F8A);
  static const textHint = Color(0xFF9EB3BB);
  static const textOnImage = Colors.white;

  // UI Elements
  static const chipSelected = Color(0xFFCCF1F6);
  static const chipBorder = Color(0xFF4DD0E1);
  static const iconBg = Color(0xFFF0F4F8);
  static const cardBorder = Color(0xFFD6EEF4);

  // Effects
  static const shadow = Color(0x1A000000);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      background: AppColors.background,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),

    textTheme: const TextTheme(
      // Headlines
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: AppColors.textPrimary,
      ),

      // Titles
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      // Body
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.textHint),
    ),
  );
}
