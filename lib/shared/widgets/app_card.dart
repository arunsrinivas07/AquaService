// lib/shared/widgets/app_card.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final bool isGlassy;

  const AppCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.color,
    this.isGlassy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: isGlassy 
            ? Colors.white.withOpacity(0.72) 
            : (color ?? const Color.fromRGBO(220, 240, 244, 1)),
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.xl),
        border: Border.all(
          color: isGlassy 
              ? const Color(0xFFB3E5FC).withOpacity(0.35)
              : const Color.fromARGB(255, 138, 215, 231),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isGlassy 
                ? Colors.black.withOpacity(0.06)
                : AppColors.shadow,
            blurRadius: isGlassy ? 10 : 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
