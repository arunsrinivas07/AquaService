// lib/main.dart

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/customer_dashboard/presentation/page/customer_dashboard_page.dart';
import 'features/machines/screens/machine_payments_screen.dart';

void main() {
  runApp(const ProviderScope(child: AquaPureApp()));
}

class AquaPureApp extends StatelessWidget {
  const AquaPureApp({super.key});
=======
import 'navbar/navbar.dart';
import 'payment/payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
>>>>>>> vishnu

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'AquaPure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.cyan,
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: CustomerDashboardPage(),
=======
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2; // Home selected by default

  final List<Widget> _pages = [
    const Center(child: Text("Profile Page")),
    const PaymentSourceScreen(), // Index 1: Cash
    const Center(child: Text("Home Page")), // Index 2: Home
    const Center(child: Text("Status Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
>>>>>>> vishnu
    );
  }
}
