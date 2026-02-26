// lib/features/service/widgets/schedule_selector.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../providers/service_provider.dart';

// ── Reusable selector card ────────────────────────────────────────────────────
class ScheduleSelectorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ScheduleSelectorCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        isGlassy: true,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.tealDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

// ── Full schedule selector section ───────────────────────────────────────────
class ScheduleSelector extends ConsumerWidget {
  const ScheduleSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ScheduleSelectorCard(
                title: 'Date',
                subtitle: 'Book at your convenience',
                onTap: () async {
                  final currentState = ref.read(serviceProvider);
                  final now = DateTime.now();
                  final firstDate = DateTime(now.year, now.month, now.day);
                  final initialDate =
                      currentState.selectedDate != null &&
                          (currentState.selectedDate!.isAfter(firstDate) ||
                              currentState.selectedDate!.isAtSameMomentAs(
                                firstDate,
                              ))
                      ? currentState.selectedDate!
                      : firstDate;

                  final picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: firstDate,
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    ref.read(serviceProvider.notifier).selectDate(picked);
                  }
                },
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ScheduleSelectorCard(
                title: 'Time',
                subtitle: 'Select your Availability',
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 11, minute: 30),
                  );
                  if (picked != null) {
                    final h = picked.hourOfPeriod == 0
                        ? 12
                        : picked.hourOfPeriod;
                    final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
                    final min = picked.minute.toString().padLeft(2, '0');
                    ref
                        .read(serviceProvider.notifier)
                        .selectTime('$h:$min $period');
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Confirm date row
        const _ConfirmDateCard(),
      ],
    );
  }
}

// ── Confirm date display card ─────────────────────────────────────────────────
class _ConfirmDateCard extends ConsumerWidget {
  const _ConfirmDateCard();

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(serviceProvider.select((s) => s.selectedDate));
    final time = ref.watch(serviceProvider.select((s) => s.selectedTime));

    final dateStr = date != null
        ? '${_weekdays[date.weekday]}, ${_months[date.month]} ${date.day}'
        : '—';
    final timeStr = time ?? '—';

    return AppCard(
      isGlassy: true,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.base,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateStr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                timeStr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Confirm your service date',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
