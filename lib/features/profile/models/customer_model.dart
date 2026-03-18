// lib/features/profile/models/customer_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class MachineDetail {
  final String machineType;
  final String serialNumber;
  final String model;
  final DateTime? installationDate;
  final int status; // 1 = active

  const MachineDetail({
    required this.machineType,
    required this.serialNumber,
    required this.model,
    this.installationDate,
    this.status = 1,
  });

  bool get isActive => status == 1;

  String get statusLabel => isActive ? 'Active' : 'Inactive';

  factory MachineDetail.fromFirestore(List<dynamic> data) {
    DateTime? date;
    if (data.length > 3 && data[3] is Timestamp) {
      date = (data[3] as Timestamp).toDate();
    }

    return MachineDetail(
      machineType: data.isNotEmpty ? data[0]?.toString() ?? '' : '',
      serialNumber: data.length > 1 ? data[1]?.toString() ?? '' : '',
      model: data.length > 2 ? data[2]?.toString() ?? '' : '',
      installationDate: date,
      status: data.length > 4 ? (data[4] as num?)?.toInt() ?? 0 : 0,
    );
  }
}

class CustomerModel {
  final String docId;
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final double initialPayment;
  final String location;
  final List<MachineDetail> machineDetails;
  final DateTime? previousMaintenanceDate;

  const CustomerModel({
    required this.docId,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.initialPayment,
    required this.location,
    required this.machineDetails,
    this.previousMaintenanceDate,
  });

  /// Helper to get a value from a map with multiple possible key names
  static dynamic _getField(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      if (data.containsKey(key)) return data[key];
    }
    return null;
  }

  factory CustomerModel.fromFirestore(Map<String, dynamic> data) {
    // Parse MachineDetails — could be array or nested
    final machineData = _getField(data, ['MachineDetails', 'machineDetails', 'Machine Details', 'machine_details']);
    List<MachineDetail> machines = [];
    if (machineData is List && machineData.isNotEmpty) {
      // Could be a single machine as flat array or list of arrays
      if (machineData.first is List) {
        machines = machineData.map<MachineDetail>((m) => MachineDetail.fromFirestore(m as List)).toList();
      } else {
        machines = [MachineDetail.fromFirestore(machineData)];
      }
    }

    final name = _getField(data, ['Name', 'name', 'CustomerName', 'customerName']);
    final address = _getField(data, ['Address', 'address']);
    final email = _getField(data, ['email', 'Email', 'e-mail']);
    final phone = _getField(data, ['Phone Number', 'PhoneNumber', 'phoneNumber', 'phone']);
    final payment = _getField(data, ['InitialPayment', 'initialPayment', 'Initial Payment']);
    final location = _getField(data, ['Location', 'location']);
    final prevMaintenanceRaw = _getField(data, ['previous_maintenance_date', 'previousMaintenanceDate']);
    DateTime? prevMaintenance;
    if (prevMaintenanceRaw is Timestamp) {
      prevMaintenance = prevMaintenanceRaw.toDate();
    }

    return CustomerModel(
      docId: data['docId']?.toString() ?? '',
      name: name?.toString() ?? '',
      address: address?.toString() ?? '',
      email: email?.toString() ?? '',
      phoneNumber: phone?.toString() ?? '',
      initialPayment: (payment is num) ? payment.toDouble() : 0,
      location: location?.toString() ?? '',
      machineDetails: machines,
      previousMaintenanceDate: prevMaintenance,
    );
  }
}
