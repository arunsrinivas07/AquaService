// lib/shared/widgets/app_card.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: color ?? const Color.fromRGBO(220, 240, 244, 1),
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.xl),
        border: Border.all(
          color: const Color.fromARGB(255, 138, 215, 231),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
