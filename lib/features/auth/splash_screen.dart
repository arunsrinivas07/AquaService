import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dart:async';

/// ------------------------------------------------------------
/// UPDATED REPLICA DESIGN SYSTEM
/// ------------------------------------------------------------

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// APP LOGO
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.water_drop,
                size: 50,
                color: RoColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Aqua Service',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: RoColors.darkText,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            const Text(
              'Pure Water, Delivered',
              style: TextStyle(
                fontSize: 14,
                color: RoColors.primaryBlue,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
