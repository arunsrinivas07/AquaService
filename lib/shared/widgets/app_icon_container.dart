// lib/shared/widgets/app_icon_container.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_theme.dart';

class AppIconContainer extends StatelessWidget {
  final Widget icon;
  final double size;
  final Color? color;
  final Color? borderColor;
  final double? radius;

  const AppIconContainer({
    super.key,
    required this.icon,
    this.size = 48,
    this.color,
    this.borderColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? AppRadius.lg),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: (color ?? AppColors.iconBg).withOpacity(0.85),
            borderRadius: BorderRadius.circular(radius ?? AppRadius.lg),
            border: Border.all(
              color: borderColor ?? Colors.white.withOpacity(0.8),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.teal.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: icon,
        ),
      ),
    );
  }
}
