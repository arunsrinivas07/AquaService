// lib/features/service/models/service_model.dart

enum ServiceType { maintenance, installation }

class ServiceState {
  final ServiceType selectedServiceType;
  final DateTime?   selectedDate;
  final String?     selectedTime;
  final double      estimateCost;
  final String?     machineModel;
  final String?     selectedAddress;

  const ServiceState({
    this.selectedServiceType = ServiceType.maintenance,
    this.selectedDate,
    this.selectedTime,
    this.estimateCost = 200.0,
    this.machineModel,
    this.selectedAddress,
  });

  ServiceState copyWith({
    ServiceType? selectedServiceType,
    DateTime?    selectedDate,
    String?      selectedTime,
    double?      estimateCost,
    String?      machineModel,
    String?      selectedAddress,
  }) => ServiceState(
    selectedServiceType: selectedServiceType ?? this.selectedServiceType,
    selectedDate:        selectedDate        ?? this.selectedDate,
    selectedTime:        selectedTime        ?? this.selectedTime,
    estimateCost:        estimateCost        ?? this.estimateCost,
    machineModel:        machineModel        ?? this.machineModel,
    selectedAddress:     selectedAddress     ?? this.selectedAddress,
  );
}

class MaintenanceInfo {
  final DateTime? nextDate;
  final DateTime? previousDate;
  final DateTime? bookingDate;
  final String? bookingStatus;

  const MaintenanceInfo({
    this.nextDate,
    this.previousDate,
    this.bookingDate,
    this.bookingStatus,
  });
}
