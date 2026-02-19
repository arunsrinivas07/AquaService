// lib/features/machines/widgets/machine_card.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_badge.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../models/machine_model.dart';

class MachineCard extends StatelessWidget {
  final MachineModel machine;

  const MachineCard({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppNetworkImage(url: machine.imageUrl, fit: BoxFit.cover),
            // Gradient overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC000000)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
            // Bottom content
            Positioned(
              left: AppSpacing.base,
              right: AppSpacing.base,
              bottom: AppSpacing.base,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Machine Details',
                          style: const TextStyle(
                            color: AppColors.textOnImage,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          machine.name,
                          style: const TextStyle(
                            color: AppColors.textOnImage,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${machine.date} - ${machine.serialNumber}',
                          style: const TextStyle(
                            color: AppColors.textOnImage,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppBadge(
                    label: machine.statusLabel,
                    color: const Color.fromARGB(255, 100, 245, 105),
                    variant: BadgeVariant.filled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
