import 'package:flutter/material.dart';
import 'package:ro_water/features/customer/customer_home_screen.dart';
import 'package:ro_water/features/customer/customer_service_history_screen.dart';
import 'package:ro_water/features/customer/customer_report_issue_screen.dart';

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;

  // Status Colors
  static const Color statusActive = Color(0xFFE0F7FA);
  static const Color statusActiveText = Color(0xFF00BCD4);
}

class CustomerProfileSettingsScreen extends StatefulWidget {
  const CustomerProfileSettingsScreen({super.key});

  @override
  State<CustomerProfileSettingsScreen> createState() =>
      _CustomerProfileSettingsScreenState();
}

class _CustomerProfileSettingsScreenState
    extends State<CustomerProfileSettingsScreen> {
  int _selectedNavIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// SCROLLABLE HEADER (MATCHING ADMIN STYLE)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildScrollableHeader(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFFE8BCB3,
                            ), // Matching Admin Profile placeholder
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: const Center(
                            child: Text(
                              "AJ",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: RoColors.primaryBlue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Alex Johnson',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: RoColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'CUSTOMER ID: #RW-98234',
                      style: TextStyle(
                        fontSize: 12,
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildMenuCard(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      subtitle: 'MANAGE PROFILE DATA',
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: Icons.location_on_outlined,
                      title: 'Installation Address',
                      subtitle: 'MANAGE LOCATIONS',
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: Icons.description_outlined,
                      title: 'Plan Details',
                      subtitle: 'GOLD AMC - EXPIRES SEP 2024',
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: Icons.settings_outlined,
                      title: 'App Settings',
                      subtitle: 'NOTIFICATIONS & THEME',
                    ),
                    const SizedBox(height: 32),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'SUPPORT SYSTEM',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: RoColors.subText,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuCard(
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      subtitle: 'FAQS & SUPPORT',
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFFF5252),
                          size: 20,
                        ),
                        label: const Text(
                          'SIGN OUT',
                          style: TextStyle(
                            color: Color(0xFFFF5252),
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: const Color(
                            0xFFFFEBEE,
                          ).withOpacity(0.5),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'VERSION 2.4.0 (BUILD 82)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: RoColors.subText,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildScrollableHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: RoColors.darkText,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          "Profile Settings",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(
              Icons.edit_outlined,
              color: RoColors.primaryBlue,
              size: 18,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: RoColors.statusActive,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: RoColors.primaryBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: RoColors.subText,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: RoColors.subText,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, "HOME", 0),
          _buildNavItem(Icons.receipt_long, "HISTORY", 1),
          _buildNavItem(Icons.headset_mic, "SUPPORT", 2),
          _buildNavItem(Icons.person, "PROFILE", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedNavIndex == index;
    return InkWell(
      onTap: () {
        setState(() => _selectedNavIndex = index);
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomerServiceHistoryScreen(),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomerReportIssueScreen(),
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? RoColors.primaryBlue : RoColors.subText,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? RoColors.primaryBlue : RoColors.subText,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
