// lib/features/customer_dashboard/presentation/widgets/payment_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/dashboard_provider.dart';

class PaymentCard extends ConsumerWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance =
        ref.watch(dashboardProvider.select((s) => s.outstandingBalance));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.72),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFFB3E5FC).withOpacity(0.35),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUTSTANDING BALANCE',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '₹ ${balance.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 20,
                      color: Colors.black54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // "Due in 5 days" text + Pay Now button on same row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Due in 5 days pill — wraps content only
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Due in',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '5',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'days',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Pay Now button — fixed width
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.shade200.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.cyan.shade100,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay Now',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}