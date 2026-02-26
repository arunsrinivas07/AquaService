// lib/features/service/widgets/service_info_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_icon_container.dart';
import '../providers/service_provider.dart';

class ServiceInfoCard extends ConsumerWidget {
  const ServiceInfoCard({super.key});

  static const _months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  static const _weekdays = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String _fmt(DateTime d) =>
      '${_weekdays[d.weekday]}, ${_months[d.month]} ${d.day}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(serviceInfoProvider);
    return AppCard(
      isGlassy: true,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Info',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _fmt(info.date),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'In ${info.daysFromNow} days',
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppIconContainer(
            size: 42,
            radius: 12,
            icon: const Icon(
              Icons.handyman_outlined,
              color: Colors.black54,
              size: 20,
            ),
            color: Colors.grey.shade100.withOpacity(1),
            borderColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
