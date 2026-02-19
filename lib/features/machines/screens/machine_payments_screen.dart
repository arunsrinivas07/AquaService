// lib/features/machines/screens/machine_payments_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../payments/providers/payment_provider.dart';
import '../../payments/widgets/balance_card.dart';
import '../../payments/widgets/profile_header.dart';
import '../providers/machine_provider.dart';
import '../widgets/machine_card.dart';

class MachinePaymentsScreen extends ConsumerWidget {
  const MachinePaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = ref.watch(paymentProvider);
    final machines = ref.watch(machineListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FAFB),
        leading: const _BackButton(),
        title: const Text('Machine and payments'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final hPad = isTablet ? AppSpacing.xxl : AppSpacing.base;

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: hPad,
              vertical: AppSpacing.base,
            ),
            children: [
              ProfileHeader(
                name: payment.userName,
                userId: payment.userId,
                avatarUrl: payment.avatarUrl,
              ),
              const SizedBox(height: AppSpacing.base),
              BalanceCard(
                amount: payment.outstandingBalance,
                dueDays: payment.dueDays,
                onPayNow: () {},
              ),
              const SizedBox(height: AppSpacing.base),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: machines.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.base),
                itemBuilder: (context, index) =>
                    MachineCard(machine: machines[index]),
              ),
              const SizedBox(height: AppSpacing.base),
            ],
          );
        },
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_left, size: 28),
      onPressed: () => Navigator.maybePop(context),
    );
  }
}
