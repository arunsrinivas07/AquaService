// lib/features/customer_dashboard/widgets/payment_calendar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../payments/providers/payment_provider.dart';

class PaymentCalendar extends ConsumerWidget {
  const PaymentCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentAsync = ref.watch(paymentProvider);

    return paymentAsync.when(
      loading: () => const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (summary) {
        if (summary.payments.isEmpty) return const SizedBox.shrink();

        // Build set of paid months
        final paidMonths = <String>{};
        for (final p in summary.payments) {
          paidMonths.add('${p.dateTime.year}-${p.dateTime.month}');
        }

        // Find earliest payment and current date
        final sortedPayments = [...summary.payments]
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
        final firstPayment = sortedPayments.first.dateTime;
        final now = DateTime.now();

        // Generate list of months from first payment to now + 3 months
        final months = <DateTime>[];
        var cursor = DateTime(firstPayment.year, firstPayment.month);
        final end = DateTime(now.year, now.month + 3);
        while (cursor.isBefore(end) || cursor.isAtSameMomentAs(end)) {
          months.add(cursor);
          cursor = DateTime(cursor.year, cursor.month + 1);
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
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
              Row(
                children: [
                  Text(
                    'Payment Calendar',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const Spacer(),
                  // Legend
                  _legendDot(const Color(0xFF4CAF50), 'Paid'),
                  const SizedBox(width: 10),
                  _legendDot(const Color(0xFFF44336), 'Due'),
                  const SizedBox(width: 10),
                  _legendDot(Colors.grey.shade300, 'Upcoming'),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: months.map((month) {
                  final key = '${month.year}-${month.month}';
                  final isPaid = paidMonths.contains(key);
                  final isPast = month.isBefore(DateTime(now.year, now.month));
                  final isCurrent = month.year == now.year && month.month == now.month;


                  Color bgColor;
                  Color textColor;
                  if (isPaid) {
                    bgColor = const Color(0xFF4CAF50);
                    textColor = Colors.white;
                  } else if (isPast || isCurrent) {
                    bgColor = const Color(0xFFF44336);
                    textColor = Colors.white;
                  } else {
                    bgColor = Colors.grey.shade200;
                    textColor = Colors.black54;
                  }

                  final label = DateFormat('MMM').format(month);
                  final yearSuffix = month.year != now.year ? "\n'${month.year % 100}" : '';

                  return Container(
                    width: 52,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: isCurrent
                          ? Border.all(color: Colors.black87, width: 2)
                          : null,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$label$yearSuffix',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            height: 1.2,
                          ),
                        ),
                        if (isPaid) ...[
                          const SizedBox(height: 2),
                          Icon(Icons.check_circle, size: 14, color: textColor),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              // Summary row
              Row(
                children: [
                  Text(
                    'EMI: ₹${summary.payments.isNotEmpty ? summary.payments.first.emi.toStringAsFixed(0) : '0'}/mo',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Remaining: ₹${summary.outstandingBalance.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: summary.outstandingBalance > 0
                          ? Colors.red.shade400
                          : const Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
