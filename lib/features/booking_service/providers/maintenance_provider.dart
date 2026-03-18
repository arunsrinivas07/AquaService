// lib/features/booking_service/providers/maintenance_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firestore_service.dart';
import '../../login/providers/auth_provider.dart';

class MaintenanceRecord {
  final String docId;
  final DateTime dateTime;
  final String machineModel;
  final String serviceType;
  final String status;

  const MaintenanceRecord({
    required this.docId,
    required this.dateTime,
    required this.machineModel,
    this.serviceType = 'maintenance',
    this.status = 'pending',
  });

  factory MaintenanceRecord.fromFirestore(Map<String, dynamic> data) {
    DateTime dt = DateTime.now();
    if (data['date_time'] is Timestamp) {
      dt = (data['date_time'] as Timestamp).toDate();
    }

    String rawStatus = data['status']?.toString().toLowerCase() ?? '';
    if (rawStatus.isEmpty) {
      // For backwards compatibility: if no status, assume past is completed, future is pending
      rawStatus = dt.isBefore(DateTime.now()) ? 'completed' : 'pending';
    }

    return MaintenanceRecord(
      docId: data['docId'] ?? '',
      dateTime: dt,
      machineModel: data['machine Model']?.toString() ?? '',
      serviceType: (data['service_type'] ?? data['type'])?.toString() ?? 'maintenance',
      status: rawStatus,
    );
  }
}

class MaintenanceSummary {
  final List<MaintenanceRecord> records;
  final DateTime? previousMaintenanceDate;
  final DateTime? nextMaintenanceDate;
  final String serviceCountdown;

  const MaintenanceSummary({
    required this.records,
    this.previousMaintenanceDate,
    this.nextMaintenanceDate,
    required this.serviceCountdown,
  });
}

/// Provides maintenance/installation records for the logged-in user.
/// Also auto-syncs the most recent completed maintenance date back to
/// CustomerDetails so TDS is always calculated from the true last service date.
final maintenanceProvider = FutureProvider<MaintenanceSummary>((ref) async {
  final authState = ref.watch(authProvider);
  final phone = authState.loggedInPhone;

  if (phone == null) {
    return const MaintenanceSummary(
      records: [],
      serviceCountdown: 'No data',
    );
  }

  final service = FirestoreService();
  final docs = await service.getMaintenanceByPhone(phone);
  final records = docs.map((d) => MaintenanceRecord.fromFirestore(d)).toList();

  // Sort by date descending
  records.sort((a, b) => b.dateTime.compareTo(a.dateTime));

  DateTime? previousDate;
  DateTime? nextDate;
  String countdown = 'No service booked';

  final now = DateTime.now();

  // Find previous (past) completed maintenance dates
  for (final r in records) {
    if (r.serviceType.toLowerCase() == 'maintenance' &&
        r.dateTime.isBefore(now) &&
        r.status == 'completed' &&
        previousDate == null) {
      previousDate = r.dateTime;
    }
  }

  // Fallback: if no explicitly completed past records, take most recent past one
  if (previousDate == null) {
    for (final r in records) {
      if (r.serviceType.toLowerCase() == 'maintenance' &&
          r.dateTime.isBefore(now) &&
          previousDate == null) {
        previousDate = r.dateTime;
      }
    }
  }

  // ── Auto-sync: persist the latest completed maintenance date ─────────────
  // If we found a completed date, compare it with what's stored in
  // CustomerDetails and update if the computed date is newer.
  if (previousDate != null) {
    final customerData = await service.getCustomerByPhone(phone);
    if (customerData != null) {
      final docId = customerData['docId']?.toString() ?? '';
      final storedRaw = customerData['previous_maintenance_date'];
      DateTime? storedDate;
      if (storedRaw is Timestamp) {
        storedDate = storedRaw.toDate();
      }

      final shouldUpdate =
          docId.isNotEmpty &&
          (storedDate == null || previousDate.isAfter(storedDate));

      if (shouldUpdate) {
        try {
          await service.updatePreviousMaintenanceDate(docId, previousDate);
          // Invalidate customerProvider so dashboard re-reads the updated date
          ref.invalidateSelf();
        } catch (e) {
          debugPrint('Auto-sync previousMaintenanceDate failed: $e');
        }
      }
    }
  }
  // ─────────────────────────────────────────────────────────────────────────

  // Find explicit future bookings
  final futureRecords = records.where((r) => r.dateTime.isAfter(now)).toList();
  if (futureRecords.isNotEmpty) {
    futureRecords.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    nextDate = futureRecords.first.dateTime;
  } else if (previousDate != null) {
    // No explicit booking → next maintenance is 3 months after last service
    nextDate = previousDate.add(const Duration(days: 90));
  } else {
    nextDate = now.add(const Duration(days: 90));
  }

  final days = nextDate.difference(now).inDays;
  if (days < 0) {
    countdown = 'Service Overdue by ${days.abs()} days';
  } else if (days == 0) {
    countdown = 'Today';
  } else {
    countdown = 'In $days days';
  }

  return MaintenanceSummary(
    records: records,
    previousMaintenanceDate: previousDate,
    nextMaintenanceDate: nextDate,
    serviceCountdown: countdown,
  );
});
