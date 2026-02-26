// lib/features/service/models/service_model.dart

enum ServiceType { maintenance, installation }

class ServiceState {
  final ServiceType selectedServiceType;
  final DateTime?   selectedDate;
  final String?     selectedTime;
  final double      estimateCost;
  final String?     machineModel;

  const ServiceState({
    this.selectedServiceType = ServiceType.maintenance,
    this.selectedDate,
    this.selectedTime,
    this.estimateCost = 200.0,
    this.machineModel,
  });

  ServiceState copyWith({
    ServiceType? selectedServiceType,
    DateTime?    selectedDate,
    String?      selectedTime,
    double?      estimateCost,
    String?      machineModel,
  }) => ServiceState(
    selectedServiceType: selectedServiceType ?? this.selectedServiceType,
    selectedDate:        selectedDate        ?? this.selectedDate,
    selectedTime:        selectedTime        ?? this.selectedTime,
    estimateCost:        estimateCost        ?? this.estimateCost,
    machineModel:        machineModel        ?? this.machineModel,
  );
}

class MaintenanceInfo {
  final DateTime nextDate;
  final DateTime previousDate;

  const MaintenanceInfo({
    required this.nextDate,
    required this.previousDate,
  });
}
