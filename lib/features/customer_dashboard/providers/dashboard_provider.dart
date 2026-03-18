// lib/features/customer_dashboard/providers/dashboard_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dashboard_state.dart';
import '../../profile/providers/customer_provider.dart';
import '../../payments/providers/payment_provider.dart';
import '../../booking_service/providers/maintenance_provider.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier()
    : super(
        DashboardState(
          userName: 'User',
          machineName: '',
          modelNumber: '',
          tdsValue: 100,
          isHealthy: true,
          outstandingBalance: 0,
          nextServiceDate: DateTime.now().add(const Duration(days: 30)),
          serviceCountdown: 'No data',
          currentNavIndex: 2,
        ),
      );

  void setNavIndex(int index) {
    state = state.copyWith(currentNavIndex: index);
  }

  void updateTds(double value) {
    state = state.copyWith(tdsValue: value);
  }

  void updateFromFirestore({
    String? userName,
    String? machineName,
    String? modelNumber,
    double? outstandingBalance,
    DateTime? nextServiceDate,
    String? serviceCountdown,
    DateTime? bookingDate,
    String? bookingStatus,
    double? tdsValue,
    bool? isHealthy,
  }) {
    state = state.copyWith(
      userName: userName,
      machineName: machineName,
      modelNumber: modelNumber,
      outstandingBalance: outstandingBalance,
      nextServiceDate: nextServiceDate,
      serviceCountdown: serviceCountdown,
      bookingDate: bookingDate,
      bookingStatus: bookingStatus,
      tdsValue: tdsValue,
      isHealthy: isHealthy,
    );
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final notifier = DashboardNotifier();

  // ── Customer details (machine name, model) ───────────────────────────────
  final customerAsync = ref.watch(customerProvider);
  customerAsync.whenData((customer) {
    if (customer != null) {
      final machine = customer.machineDetails.isNotEmpty
          ? customer.machineDetails.first
          : null;
      Future.microtask(() {
        notifier.updateFromFirestore(
          userName: customer.name,
          machineName: machine?.machineType,
          modelNumber: machine?.model,
        );
      });
    }
  });

  // ── Outstanding balance ───────────────────────────────────────────────────
  final paymentAsync = ref.watch(paymentProvider);
  paymentAsync.whenData((payment) {
    Future.microtask(() {
      notifier.updateFromFirestore(
        outstandingBalance: payment.outstandingBalance,
      );
    });
  });

  // ── TDS calculation: prefer stored Firestore date, fallback to computed ───
  final maintenanceAsync = ref.watch(maintenanceProvider);
  final customerValue = ref.watch(customerProvider).valueOrNull;

  maintenanceAsync.whenData((maintenance) {
    // Use the date stored in CustomerDetails.previous_maintenance_date first.
    // Fall back to the date computed from completed maintenance records.
    final storedPrev = customerValue?.previousMaintenanceDate;
    final computedPrev = maintenance.previousMaintenanceDate;
    final prevDate = storedPrev ?? computedPrev ?? DateTime.now();

    final now = DateTime.now();
    // TDS scales from 100 ppm (Day 0 after service) to 550 ppm (Day 90+)
    final daysSince = now.difference(prevDate).inDays.clamp(0, 90);
    final calculatedTds = 100.0 + (daysSince / 90.0) * 450.0;
    final isHealthy = calculatedTds < 500;

    DateTime? bDate;
    String? bStatus;
    if (maintenance.records.isNotEmpty) {
        final futureBookings = maintenance.records.where((r) => r.dateTime.isAfter(now)).toList();
        if (futureBookings.isNotEmpty) {
            futureBookings.sort((a, b) => a.dateTime.compareTo(b.dateTime));
            bDate = futureBookings.first.dateTime;
            bStatus = futureBookings.first.status;
        }
    }

    Future.microtask(() {
      notifier.updateFromFirestore(
        nextServiceDate: maintenance.nextMaintenanceDate,
        serviceCountdown: maintenance.serviceCountdown,
        bookingDate: bDate,
        bookingStatus: bStatus,
        tdsValue: calculatedTds,
        isHealthy: isHealthy,
      );
    });
  });

  return notifier;
});
