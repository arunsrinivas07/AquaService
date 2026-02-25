// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/customer_dashboard/presentation/page/customer_dashboard_page.dart';
import 'features/machines/screens/machine_payments_screen.dart';

void main() {
  runApp(const ProviderScope(child: AquaPureApp()));
}

class AquaPureApp extends StatelessWidget {
  const AquaPureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaPure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.cyan,
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: CustomerDashboardPage(),
    );
  }
}
