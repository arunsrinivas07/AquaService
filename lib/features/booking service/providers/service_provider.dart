// lib/features/service/providers/service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_model.dart';

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

// ── Static service info ───────────────────────────────────────────────────────
final serviceInfoProvider = Provider<({DateTime date, int daysFromNow})>((ref) {
  final date = DateTime(2025, 2, 28);
  final daysFromNow = date.difference(DateTime.now()).inDays.abs();
  return (date: date, daysFromNow: daysFromNow);
});

// ── Maintenance info ─────────────────────────────────────────────────────────
final maintenanceInfoProvider = Provider<MaintenanceInfo>(
  (ref) => MaintenanceInfo(
    nextDate: DateTime(2026, 1, 31),
    previousDate: DateTime(2025, 12, 12),
  ),
);

// ── Machine models list ───────────────────────────────────────────────────────
final machineModelsProvider = Provider<List<String>>(
  (_) => ['HVAC-X100', 'HVAC-X200', 'ChillPro 3000', 'ArcticFlow 500'],
);
