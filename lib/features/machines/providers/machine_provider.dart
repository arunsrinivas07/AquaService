// lib/features/machines/providers/machine_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/machine_model.dart';

final machineListProvider = Provider<List<MachineModel>>((ref) {
  return const [
    MachineModel(
      id: '1',
      name: 'Industrial HVAC-X100',
      serialNumber: 'SN-99291-B',
      date: 'Jan 12, 2025',
      imageUrl:
          'https://cdn.prod.website-files.com/68acac1a76c1dc16e6ef6b50/68f298b06adb4e52ffa0358e_68c077704fd5e2f73bda9114_well-water-101-why-uv-purification-is-essential.jpeg?w=800&q=80',
      status: MachineStatus.active,
    ),
    MachineModel(
      id: '2',
      name: 'Industrial HVAC-X100',
      serialNumber: 'SN-99291-B',
      date: 'Jan 12, 2025',
      imageUrl:
          'https://cdn.prod.website-files.com/68acac1a76c1dc16e6ef6b50/68f298b06adb4e52ffa0358e_68c077704fd5e2f73bda9114_well-water-101-why-uv-purification-is-essential.jpeg?w=800&q=80',
      status: MachineStatus.active,
    ),
  ];
});
