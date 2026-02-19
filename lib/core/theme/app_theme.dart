// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

abstract class AppColors {
  static const background = Color(0xFFF0F5FA);
  static const cardBackground = Colors.white;
  static const balanceCardBg = Colors.white;
  static const primary = Color(0xFF00BCD4);
  static const primaryLight = Color(0xFFE0F7FA);
  static const dueBadgeBorder = Color(0xFFE53935);
  static const dueBadgeText = Color(0xFFE53935);
  static const activeBadge = Color(0xFF4CAF50);
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF6B7280);
  static const textOnImage = Colors.white;
  static const shadow = Color(0x1A000000);
  static const iconBg = Color(0xFFF0F4F8);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
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
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      );
}
