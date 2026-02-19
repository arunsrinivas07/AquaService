// lib/shared/widgets/app_network_image.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: AppColors.iconBg,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: AppColors.iconBg,
        child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
      ),
    );
  }
}
