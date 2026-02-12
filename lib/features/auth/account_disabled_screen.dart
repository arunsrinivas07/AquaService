import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ro_water/features/auth/login_screen.dart';

/// ------------------------------------------------------------
/// UPDATED REPLICA DESIGN SYSTEM
/// ------------------------------------------------------------

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
}

class DisabledAccessScreen extends StatelessWidget {
  const DisabledAccessScreen({super.key});

  // Call Support
  Future<void> _callSupport() async {
    final Uri uri = Uri(scheme: 'tel', path: '6369298849');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // Email Support
  Future<void> _emailSupport() async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'ganeshdeepak65@gmail.com',
      queryParameters: {'subject': 'Account Access Issue'},
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: RoColors.darkText,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Access Restricted",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: RoColors.darkText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    /// LOCK ICON
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_person_rounded,
                        size: 60,
                        color: RoColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      "SECURITY STATUS",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Text(
                      "Account Disabled",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: RoColors.darkText,
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Your access to RoWater has been restricted by system administrators. Please contact support to resolve this issue.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: RoColors.subText,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 48),

                    /// SUPPORT OPTIONS
                    _buildSupportCard(
                      Icons.call_rounded,
                      "Call Help Center",
                      "+91 63692 98849",
                      _callSupport,
                    ),
                    const SizedBox(height: 16),
                    _buildSupportCard(
                      Icons.email_rounded,
                      "Email Support",
                      "ganeshdeepak65@gmail.com",
                      _emailSupport,
                    ),
                  ],
                ),
              ),
            ),

            /// LOGOUT BUTTON
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.red.withOpacity(0.1)),
                    ),
                    backgroundColor: Colors.red.withOpacity(0.05),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.red, size: 20),
                      SizedBox(width: 12),
                      Text(
                        "BACK TO LOGIN",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard(
    IconData icon,
    String title,
    String value,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: RoColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: RoColors.primaryBlue, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: RoColors.subText,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: RoColors.darkText,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFEEEEEE),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
