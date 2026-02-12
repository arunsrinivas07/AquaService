import 'package:flutter/material.dart';
import 'package:ro_water/features/customer/customer_schedule_service_screen.dart';
import 'package:ro_water/features/customer/customer_machine_details_screen.dart';
import 'package:ro_water/features/customer/customer_report_issue_screen.dart';
import 'package:ro_water/features/customer/customer_service_history_screen.dart';
import 'package:ro_water/features/customer/customer_profile_settings_screen.dart';

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

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SCROLLABLE HEADER (Replaces AppBar)
              _buildScrollableHeader(w),
              const SizedBox(height: 24),

              const Text(
                "CUSTOMER",
                style: TextStyle(
                  color: RoColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.1,
                ),
              ),
              const Text(
                "Aqua Service",
                style: TextStyle(
                  color: RoColors.darkText,
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 24),

              _buildMachineHealthCard(w, h),
              const SizedBox(height: 24),
              _buildServiceCountdownCard(w, h),
              const SizedBox(height: 32),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: RoColors.darkText,
                ),
              ),
              const SizedBox(height: 16),

              _buildQuickActionCard(
                icon: Icons.calendar_today,
                color: const Color(0xFF4CAF50),
                textColor: Colors.white,
                iconBg: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                title: 'Book Service',
                subtitle: 'SCHEDULE CHECKUP',
                w: w,
                h: h,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CustomerScheduleServiceScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              _buildQuickActionCard(
                icon: Icons.bar_chart,
                color: RoColors.cardBg,
                textColor: RoColors.darkText,
                iconBg: RoColors.primaryBlue.withOpacity(0.1),
                iconColor: RoColors.primaryBlue,
                title: 'View Machine Details',
                subtitle: 'SPECS & PERFORMANCE',
                w: w,
                h: h,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CustomerMachineDetailsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              _buildQuickActionCard(
                icon: Icons.warning_amber_rounded,
                color: const Color(0xFFFF5252),
                textColor: Colors.white,
                iconBg: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                title: 'Raise Complaint',
                subtitle: 'RESOLVE ISSUES',
                w: w,
                h: h,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CustomerReportIssueScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      'LAST SERVICE',
                      '15 Sep 2023',
                      Icons.history,
                      w,
                      h,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const CustomerServiceHistoryScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoCard(
                      'CURRENT PLAN',
                      'Gold AMC',
                      Icons.star,
                      w,
                      h,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildReferralCard(w, h),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildScrollableHeader(double w) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(Icons.water_drop, color: RoColors.primaryBlue, size: 20),
        ),
        const Text(
          "Service Overview",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(Icons.notifications_none, color: RoColors.darkText),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMachineHealthCard(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'KITCHEN PURIFIER',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: RoColors.primaryBlue,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Machine Health',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: RoColors.darkText,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: RoColors.statusActive,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.water_drop,
                  color: RoColors.primaryBlue,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: RoColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'ACTIVE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: RoColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Optimal Performance',
                style: TextStyle(fontSize: 12, color: RoColors.subText),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: RoColors.primaryBlue,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Verified 09:00 AM Today',
                    style: TextStyle(fontSize: 12, color: RoColors.primaryBlue),
                  ),
                ],
              ),
              const Text(
                'REFRESH',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: RoColors.darkText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCountdownCard(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Countdown',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: RoColors.darkText,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Next maintenance is scheduled soon.',
                  style: TextStyle(fontSize: 12, color: RoColors.primaryBlue),
                ),
                SizedBox(height: 8),
                Text(
                  'Scheduled for Oct 12',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: 0.6,
                    strokeWidth: 6,
                    backgroundColor: Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      RoColors.primaryBlue,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '12',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: RoColors.darkText,
                      ),
                    ),
                    Text(
                      'DAYS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: RoColors.subText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required double w,
    required double h,
    required VoidCallback onTap,
    Color? color,
    Color? textColor,
  }) {
    final bgColor = color ?? RoColors.cardBg;
    final isDark = bgColor != RoColors.cardBg;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: isDark ? null : Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor ?? RoColors.darkText,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: (textColor ?? RoColors.subText).withOpacity(0.7),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: (textColor ?? RoColors.subText).withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    String value,
    IconData icon,
    double w,
    double h, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: RoColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: icon == Icons.star
                  ? const Color(0xFFFFB300)
                  : RoColors.primaryBlue,
              size: 24,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: RoColors.subText,
                letterSpacing: 1.1,
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
    );
  }

  Widget _buildReferralCard(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RoColors.primaryBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Refer a Friend',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Get 1 month extra warranty for every referral.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: RoColors.primaryBlue,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'SHARE NOW',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
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
        if (index == 1) {
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
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomerProfileSettingsScreen(),
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
