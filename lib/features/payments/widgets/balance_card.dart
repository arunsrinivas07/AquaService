// lib/features/payments/widgets/balance_card.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_badge.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';

class BalanceCard extends StatelessWidget {
  final double amount;
  final int dueDays;
  final VoidCallback? onPayNow;

  const BalanceCard({
    super.key,
    required this.amount,
    required this.dueDays,
    this.onPayNow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUTSTANDING BALANCE',
            style: theme.bodySmall?.copyWith(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${amount.toStringAsFixed(3)}',
                style: theme.headlineLarge,
              ),
              _WalletIconButton(),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppBadge(
            label: 'Due in $dueDays days',
            color: AppColors.dueBadgeBorder,
            variant: BadgeVariant.outline,
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: 'Pay Now', onPressed: onPayNow),
        ],
      ),
    );
  }
}

class _WalletIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(137, 207, 240, 0.3),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: const Icon(
        Icons.account_balance_wallet_outlined,
        color: AppColors.textPrimary,
        size: 22,
      ),
    );
  }
}
