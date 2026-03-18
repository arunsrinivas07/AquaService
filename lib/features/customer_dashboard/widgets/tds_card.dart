// lib/features/customer_dashboard/presentation/widgets/tds_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';

class TdsCard extends ConsumerWidget {
  const TdsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final machineName = ref.watch(
      dashboardProvider.select((s) => s.machineName),
    );
    final modelNumber = ref.watch(
      dashboardProvider.select((s) => s.modelNumber),
    );
    final tdsValue = ref.watch(dashboardProvider.select((s) => s.tdsValue));

    const double maxTds = 550;
    const double minTds = 100;
    
    // Calculate progress as a percentage between 100 and 550
    final double progress = ((tdsValue - minTds) / (maxTds - minTds)).clamp(0.0, 1.0);

    // Determine color based on progress (green -> orange -> red)
    Color progressColor;
    if (progress < 0.5) {
      // 100 - 325
      progressColor = Colors.cyan.shade400; // Keep their initial green/cyan style
    } else if (progress < 0.8) {
      // 325 - 460
      progressColor = Colors.orange;
    } else {
      // 460+
      progressColor = Colors.red;
    }
    
    // Text changes
    final String statusText = tdsValue < 400 ? 'System Healthy' : (tdsValue < 500 ? 'Maintenance Due Soon' : 'Action Required');
    final Color statusColor = tdsValue < 400 ? Colors.green : (tdsValue < 500 ? Colors.orange : Colors.red);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'System Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            machineName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Model: $modelNumber',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tdsValue.toInt().toString(),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
              ),
              const Spacer(),
              const Text(
                'ppm TDS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Dynamic Progress Bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: progressColor.withOpacity(0.45),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
