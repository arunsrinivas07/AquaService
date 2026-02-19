// lib/features/customer_dashboard/presentation/widgets/service_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../provider/dashboard_provider.dart';

class ServiceCard extends ConsumerWidget {
  const ServiceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextServiceDate =
        ref.watch(dashboardProvider.select((s) => s.nextServiceDate));
    final serviceCountdown =
        ref.watch(dashboardProvider.select((s) => s.serviceCountdown));

    final formattedDate =
        DateFormat('EEEE, MMMM d').format(nextServiceDate);

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
            'Service Booked Info',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 22,
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.handyman_outlined,
                      size: 20,
                      color: Colors.black54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // "In 15 days" text + Book a Service button on same row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Countdown text
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.info_outline,
                      size: 14, color: Colors.black45),
                  const SizedBox(width: 4),
                  Text(
                    serviceCountdown,
                    style: const TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Book a Service button — same fixed width as Pay Now
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
                              'Book a Service',
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