// lib/features/service/screens/service_schedule_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_chip.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/app_network_image.dart';
import '../../payments/providers/payment_provider.dart';
import '../models/service_model.dart';
import '../providers/service_provider.dart';
import '../widgets/estimate_card.dart';
import '../widgets/maintenance_info_card.dart';
import '../widgets/schedule_selector.dart';
import '../widgets/service_info_card.dart';

class ServiceScheduleScreen extends ConsumerWidget {
  const ServiceScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = ref.watch(paymentProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            final hPad = constraints.maxWidth > 600
                ? AppSpacing.xxl
                : AppSpacing.base;
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: hPad,
                vertical: AppSpacing.lg,
              ),
              children: [
                _ProfileHeader(
                  name: payment.userName,
                  userId: payment.userId,
                  avatarUrl: payment.avatarUrl,
                ),
                const SizedBox(height: AppSpacing.base),
                const ServiceInfoCard(),
                const SizedBox(height: AppSpacing.lg),
                const _WhatDoYouNeedSection(),
                const SizedBox(height: AppSpacing.lg),
                const _ScheduleSection(),
                const SizedBox(height: AppSpacing.base),
                const EstimateRow(),
                const SizedBox(height: AppSpacing.base),
                const _ConfirmButton(),
                const SizedBox(height: AppSpacing.base),
                const MaintenanceInfoCard(),
                const SizedBox(height: AppSpacing.xxl),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Profile header ────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final String name;
  final String userId;
  final String avatarUrl;

  const _ProfileHeader({
    required this.name,
    required this.userId,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 42,
            height: 42,
            child: AppNetworkImage(url: avatarUrl, width: 42, height: 42),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              'ID : $userId',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}

// ── "What do you need?" section ───────────────────────────────────────────────
class _WhatDoYouNeedSection extends ConsumerWidget {
  const _WhatDoYouNeedSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      serviceProvider.select((s) => s.selectedServiceType),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'What do you need?'),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            AppChip(
              label: 'Maintenance',
              selected: selected == ServiceType.maintenance,
              icon: const Icon(
                Icons.build_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
              onTap: () => ref
                  .read(serviceProvider.notifier)
                  .selectServiceType(ServiceType.maintenance),
            ),
            const SizedBox(width: AppSpacing.md),
            AppChip(
              label: 'Installation',
              selected: selected == ServiceType.installation,
              icon: const Icon(
                Icons.receipt_long_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
              onTap: () => ref
                  .read(serviceProvider.notifier)
                  .selectServiceType(ServiceType.installation),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Schedule section ──────────────────────────────────────────────────────────
class _ScheduleSection extends StatelessWidget {
  const _ScheduleSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(text: 'Schedule Service'),
        const SizedBox(height: AppSpacing.md),
        const ScheduleSelector(),
      ],
    );
  }
}

// ── Confirm button ────────────────────────────────────────────────────────────
class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: 'Confirm Schedule',
      onPressed: () {
        // Handle schedule confirmation
      },
    );
  }
}
