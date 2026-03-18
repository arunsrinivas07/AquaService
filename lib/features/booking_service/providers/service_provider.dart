// lib/features/booking_service/providers/service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_model.dart';
import 'maintenance_provider.dart';
import '../../profile/providers/customer_provider.dart';

// ── State notifier ────────────────────────────────────────────────────────────
class ServiceNotifier extends Notifier<ServiceState> {
  @override
  ServiceState build() {
    final now = DateTime.now();
    return ServiceState(
      selectedDate: DateTime(now.year, now.month, now.day),
      selectedTime: '11:30 AM',
    );
  }

  void selectServiceType(ServiceType type) =>
      state = state.copyWith(selectedServiceType: type);

  void selectDate(DateTime date) => state = state.copyWith(selectedDate: date);

  void selectTime(String time) => state = state.copyWith(selectedTime: time);

  void selectMachineModel(String model) =>
      state = state.copyWith(machineModel: model);

  void selectAddress(String address) =>
      state = state.copyWith(selectedAddress: address);
}

final serviceProvider = NotifierProvider<ServiceNotifier, ServiceState>(
  ServiceNotifier.new,
);

// ── Dynamic service info from Firestore ───────────────────────────────────────
final serviceInfoProvider = Provider<({DateTime date, String daysFromNow})>((ref) {
  final maintenanceInfo = ref.watch(maintenanceInfoProvider);

  if (maintenanceInfo.nextDate != null) {
    final date = maintenanceInfo.nextDate!;
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    // Create correct display format
    String daysStr;
    if (difference < 0) {
      daysStr = 'Overdue by ${difference.abs()}';
    } else if (difference == 0) {
      daysStr = '0'; // Will render as "In 0 days" or similar below
    } else {
      daysStr = difference.toString();
    }
    
    return (date: date, daysFromNow: daysStr);
  }

  // Fallback
  final date = DateTime.now();
  return (date: date, daysFromNow: '0');
});

// ── Dynamic maintenance info from Firestore ───────────────────────────────────
final maintenanceInfoProvider = Provider<MaintenanceInfo>((ref) {
  final maintenanceAsync = ref.watch(maintenanceProvider);
  final maintenance = maintenanceAsync.valueOrNull;

  DateTime? prevDate = maintenance?.previousMaintenanceDate;
  DateTime? dueDate = prevDate != null 
      ? prevDate.add(const Duration(days: 90)) 
      : DateTime.now().add(const Duration(days: 90));
  
  DateTime? bDate;
  String? bStatus;
  
  if (maintenance != null && maintenance.records.isNotEmpty) {
      final futureBookings = maintenance.records.where((r) => r.dateTime.isAfter(DateTime.now())).toList();
      if (futureBookings.isNotEmpty) {
          futureBookings.sort((a, b) => a.dateTime.compareTo(b.dateTime));
          bDate = futureBookings.first.dateTime;
          bStatus = futureBookings.first.status;
      }
  }

  return MaintenanceInfo(
    nextDate: dueDate,
    previousDate: prevDate,
    bookingDate: bDate,
    bookingStatus: bStatus,
  );
});

// ── Machine models list ───────────────────────────────────────────────────────
final machineModelsProvider = Provider<List<String>>((ref) {
  final customerAsync = ref.watch(customerProvider);
  
  return customerAsync.maybeWhen(
    data: (customer) {
      if (customer == null || customer.machineDetails.isEmpty) {
        return ['No Machine Registered'];
      }
      final models = customer.machineDetails
          .map((m) => m.model)
          .where((m) => m.isNotEmpty)
          .toList();
          
      return models.isNotEmpty ? models : ['Unknown Model'];
    },
    orElse: () => ['Loading...'],
  );
});

// ── Addresses list ────────────────────────────────────────────────────────────
final addressListProvider = Provider<List<String>>((ref) {
  final customerAsync = ref.watch(customerProvider);
  return customerAsync.maybeWhen(
    data: (customer) => customer?.addresses ?? [],
    orElse: () => [],
  );
});
