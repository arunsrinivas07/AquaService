// lib/features/machines/providers/machine_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../profile/providers/customer_provider.dart';
import '../models/machine_model.dart';

/// Provides the list of machines from CustomerDetails.MachineDetails
final machineListProvider = FutureProvider<List<MachineModel>>((ref) async {
  final customerAsync = ref.watch(customerProvider);
  final customer = customerAsync.valueOrNull;

  if (customer == null) return [];

  return customer.machineDetails.map((m) {
    MachineStatus status;
    if (m.isActive) {
      status = MachineStatus.active;
    } else {
      status = MachineStatus.inactive;
    }

    final dateStr = m.installationDate != null
        ? '${_monthName(m.installationDate!.month)} ${m.installationDate!.day}, ${m.installationDate!.year}'
        : 'N/A';

    return MachineModel(
      id: m.serialNumber,
      name: m.machineType,
      serialNumber: m.serialNumber,
      model: m.model,
      date: dateStr,
      imageUrl: '',
      status: status,
    );
  }).toList();
});

String _monthName(int month) {
  const months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return months[month];
}
