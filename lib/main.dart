import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/machines/screens/machine_payments_screen.dart';

void main() {
  runApp(const ProviderScope(child: MachinePaymentsApp()));
}

class MachinePaymentsApp extends StatelessWidget {
  const MachinePaymentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Machine & Payments',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MachinePaymentsScreen(),
    );
  }
}
