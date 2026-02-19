// lib/shared/widgets/app_badge.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';

enum BadgeVariant { outline, filled }

class AppBadge extends StatelessWidget {
  final String label;
  final Color color;
  final BadgeVariant variant;
  final double fontSize;

  const AppBadge({
    super.key,
    required this.label,
    required this.color,
    this.variant = BadgeVariant.outline,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = variant == BadgeVariant.filled;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isFilled ? color.withOpacity(0.15) : Colors.transparent,
        border: isFilled ? null : Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
