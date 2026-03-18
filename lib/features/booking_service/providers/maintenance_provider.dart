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
  final String? address;

  const MaintenanceRecord({
    required this.docId,
    required this.dateTime,
    required this.machineModel,
    this.serviceType = 'maintenance',
    this.status = 'pending',
    this.address,
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
      address: data['address']?.toString(),
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

  // Try to parse 'previous_maintenance_date' and 'next_maintenance_date' from CustomerDetails
  final customerData = await service.getCustomerByPhone(phone);
  if (customerData != null) {
      if (customerData['previous_maintenance_date'] is Timestamp) {
          previousDate = (customerData['previous_maintenance_date'] as Timestamp).toDate();
      }
      if (customerData['next_maintenance_date'] is Timestamp) {
          nextDate = (customerData['next_maintenance_date'] as Timestamp).toDate();
      }
  }

  // Find previous (past) completed maintenance dates if not found in CustomerDetails
  if (previousDate == null) {
      for (final r in records) {
        if (r.serviceType.toLowerCase() == 'maintenance' &&
            r.dateTime.isBefore(now) &&
            r.status == 'completed' &&
            previousDate == null) {
          previousDate = r.dateTime;
        }
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
  // If we found a completed date from records, compare it with what's stored in
  // CustomerDetails and update if the computed date is newer.
  bool updateRequired = false;
  if (previousDate != null && customerData != null) {
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
        updateRequired = true;
    }
  }

  // ── Check if any pending bookings transition to completed ───────────────
  // We simulate updating the database here if a record is completed. In reality,
  // the database itself updates the records. Here we handle syncing the
  // previous_maintenance_date field when a record is marked completed.
  
  if (updateRequired && previousDate != null && customerData != null) {
      final docId = customerData['docId']?.toString() ?? '';
      try {
          // Calculate new next date
          DateTime updatedNextDate = previousDate.add(const Duration(days: 90));

          await service.updatePreviousMaintenanceDate(docId, previousDate);

          // We also need a service method to update next_maintenance_date
          // Assuming we add it to firestore_service.dart
          await service.updateNextMaintenanceDate(docId, updatedNextDate);

          nextDate = updatedNextDate;

          // Invalidate customerProvider so dashboard re-reads the updated date
          ref.invalidateSelf();
      } catch (e) {
          debugPrint('Auto-sync maintenance dates failed: $e');
      }
  }

  // ─────────────────────────────────────────────────────────────────────────

  // Default next_maintenance_date logic if null
  if (nextDate == null) {
      if (previousDate != null) {
          // No explicit next date → next maintenance is 90 days after last service
          nextDate = previousDate.add(const Duration(days: 90));
      } else {
          nextDate = now.add(const Duration(days: 90));
      }
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
