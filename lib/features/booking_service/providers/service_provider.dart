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
}

final serviceProvider = NotifierProvider<ServiceNotifier, ServiceState>(
  ServiceNotifier.new,
);

// ── Dynamic service info from Firestore ───────────────────────────────────────
final serviceInfoProvider = Provider<({DateTime date, int daysFromNow})>((ref) {
  final maintenanceAsync = ref.watch(maintenanceProvider);
  final maintenance = maintenanceAsync.valueOrNull;

  if (maintenance != null && maintenance.previousMaintenanceDate != null) {
    final date = maintenance.previousMaintenanceDate!;
    final daysFromNow = date.difference(DateTime.now()).inDays.abs();
    return (date: date, daysFromNow: daysFromNow);
  }

  // Fallback
  final date = DateTime.now();
  return (date: date, daysFromNow: 0);
});

// ── Dynamic maintenance info from Firestore ───────────────────────────────────
final maintenanceInfoProvider = Provider<MaintenanceInfo>((ref) {
  final maintenanceAsync = ref.watch(maintenanceProvider);
  final maintenance = maintenanceAsync.valueOrNull;

  return MaintenanceInfo(
    nextDate: maintenance?.nextMaintenanceDate ?? DateTime.now().add(const Duration(days: 90)),
    previousDate: maintenance?.previousMaintenanceDate ?? DateTime.now().subtract(const Duration(days: 90)),
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
