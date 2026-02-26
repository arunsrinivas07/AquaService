// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/customer_dashboard/providers/dashboard_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/customer_dashboard/screens/customer_dashboard_page.dart';
import 'features/booking_service/screens/service_schedule_screen.dart';
import 'features/machines/screens/machine_payments_screen.dart';
import 'features/splash/screens/splash_screen.dart';
import 'shared/widgets/navbar/navbar.dart';

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
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  final List<Widget> _pages = const [
    ServiceScheduleScreen(), // Index 0: Book Service
    MachinePaymentsScreen(), // Index 1: Payment / Due
    CustomerDashboardPage(), // Index 2: Home
    Center(child: Text("Status Page")), // Index 3: Status
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(dashboardProvider).currentNavIndex;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(dashboardProvider.notifier).setNavIndex(index);
        },
      ),
    );
  }
}
