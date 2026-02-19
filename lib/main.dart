// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ro_water/features/booking%20service/screens/service_schedule_screen.dart';
import 'core/theme/app_theme.dart';
import 'features/machines/screens/machine_payments_screen.dart';

void main() {
  runApp(const ProviderScope(child: BookServiceApp()));
}

class BookServiceApp extends StatelessWidget {
  const BookServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ro Water Service',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ServiceScheduleScreen(),
    );
  }
}
