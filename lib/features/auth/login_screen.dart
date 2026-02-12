import 'package:flutter/material.dart';
import 'package:ro_water/features/auth/language_selection_screen.dart';
import 'package:ro_water/features/admin/admin_dashboard_screen.dart';
import 'package:ro_water/features/customer/customer_home_screen.dart';

/// ------------------------------------------------------------
/// UPDATED REPLICA DESIGN SYSTEM
/// ------------------------------------------------------------

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// LOGO
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      size: 44,
                      color: RoColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Text(
                    "WELCOME BACK",
                    style: TextStyle(
                      color: RoColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const Text(
                    "Login Access",
                    style: TextStyle(
                      color: RoColors.darkText,
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 48),

                  /// INPUT FIELDS
                  _buildLabel("PHONE NUMBER"),
                  const SizedBox(height: 8),
                  _buildTextField(
                    hint: "Enter registered number",
                    icon: Icons.phone_android_outlined,
                  ),
                  const SizedBox(height: 24),

                  _buildLabel("CUSTOMER ID / ADMIN ID"),
                  const SizedBox(height: 8),
                  _buildTextField(
                    hint: "Enter your unique ID",
                    icon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 24),

                  _buildLabel("PASSWORD"),
                  const SizedBox(height: 8),
                  _buildTextField(
                    hint: "Enter secure password",
                    icon: Icons.lock_outline_rounded,
                    obscure: true,
                    suffix: Icons.visibility_off_outlined,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: RoColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  /// LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminDashboard(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RoColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "LOGIN TO ACCOUNT",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  /// LANGUAGE SELECTION
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageSelectionScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.language, size: 18),
                    label: const Text("CHANGE LANGUAGE"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: RoColors.subText,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  const Text(
                    "Purity You Can Trust.",
                    style: TextStyle(
                      color: RoColors.subText,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  // TINY TEST BUTTON
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: 0.3,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerHomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "TEST: CUSTOMER HOME",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 182, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: RoColors.subText,
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool obscure = false,
    IconData? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        obscureText: obscure,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: RoColors.darkText,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFBDBDBD),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          prefixIcon: Icon(icon, color: RoColors.primaryBlue, size: 20),
          suffixIcon: suffix != null
              ? Icon(suffix, color: RoColors.subText, size: 20)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
