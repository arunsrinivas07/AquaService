// lib/features/payments/widgets/profile_header.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_network_image.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String userId;
  final String avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.userId,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: [
        ClipOval(child: AppNetworkImage(url: avatarUrl, width: 64, height: 64)),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: theme.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'ID : $userId',
              style: theme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}
