// lib/features/machines/models/machine_model.dart

enum MachineStatus { active, inactive, maintenance }

class MachineModel {
  final String id;
  final String name;
  final String serialNumber;
  final String date;
  final String imageUrl;
  final MachineStatus status;

  const MachineModel({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.date,
    required this.imageUrl,
    required this.status,
  });

  String get statusLabel {
    switch (status) {
      case MachineStatus.active:
        return 'Active';
      case MachineStatus.inactive:
        return 'Inactive';
      case MachineStatus.maintenance:
        return 'Maintenance';
    }
  }
}
