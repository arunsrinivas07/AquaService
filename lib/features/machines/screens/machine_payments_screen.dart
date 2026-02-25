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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFEEF6F8),
              Color(0xFFE8EAF6),
              Color(0xFFEEF6F8),
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth > 600;
              final hPad = isTablet ? AppSpacing.xxl : AppSpacing.base;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: ProfileHeader(
                      name: payment.userName,
                      userId: payment.userId,
                      avatarUrl: payment.avatarUrl,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: hPad,
                        vertical: AppSpacing.sm,
                      ),
                      children: [
                        const SizedBox(height: AppSpacing.xs),
                        BalanceCard(
                          amount: payment.outstandingBalance,
                          dueDays: payment.dueDays,
                          onPayNow: () {},
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 12),
                          child: Text(
                            'Your Machines',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
