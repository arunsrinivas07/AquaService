import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/complaint_management_screen.dart';
import 'package:ro_water/features/admin/notification_screen.dart';
import 'package:ro_water/features/admin/service_management_hub_screen.dart';
import 'package:ro_water/features/admin/customer_directory_screen.dart';
import 'package:ro_water/features/admin/appointment_approvals_screen.dart';
import 'package:ro_water/features/admin/admin_settings_screen.dart';
import 'package:ro_water/features/admin/activity_logs_archive_screen.dart';
import 'package:ro_water/features/payment/payment_dues_screen.dart';

/// ------------------------------------------------------------
/// UPDATED REPLICA DESIGN SYSTEM (Matching Service Hub)
/// ------------------------------------------------------------

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;

  // Status Colors from service hub
  static const Color statusActive = Color(0xFFE0F7FA);
  static const Color statusActiveText = Color(0xFF00BCD4);
}

/// ------------------------------------------------------------
/// ADMIN DASHBOARD
/// ------------------------------------------------------------

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SCROLLABLE HEADER (Replaces AppBar)
              _buildScrollableHeader(),
              const SizedBox(height: 24),

              const Text(
                "ADMINISTRATOR",
                style: TextStyle(
                  color: RoColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.1,
                ),
              ),
              const Text(
                "Aqua Operations",
                style: TextStyle(
                  color: RoColors.darkText,
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 24),

              /// STATS GRID (2x2) - NO SHADOWS
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                childAspectRatio: 0.88,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerDirectoryScreen(),
                      ),
                    ),
                    child: _buildStatCard(
                      "TOTAL CUSTOMERS",
                      "1,240",
                      Icons.people,
                      Colors.blue,
                      "ACTIVE",
                      RoColors.statusActive,
                      RoColors.statusActiveText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ServiceManagementHubScreen(),
                      ),
                    ),
                    child: _buildStatCard(
                      "SERVICES DUE",
                      "14",
                      Icons.home,
                      Colors.orange,
                      "+5%",
                      const Color(0xFFFFF3E0),
                      Colors.orange,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComplaintManagementScreen(),
                      ),
                    ),
                    child: _buildStatCard(
                      "COMPLAINTS",
                      "03",
                      Icons.warning_amber_rounded,
                      Colors.red,
                      "GOOD",
                      const Color(0xFFE0F2F1),
                      const Color(0xFF00897B),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Revenue breakdown coming soon!"),
                        ),
                      );
                    },
                    child: _buildStatCard(
                      "REVENUE TODAY",
                      "\$4,250",
                      Icons.account_balance_wallet,
                      const Color(0xFF00BFA5),
                      "+8%",
                      const Color(0xFFE0F2F1),
                      const Color(0xFF00BFA5),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              _buildSectionHeader("Operational Trends"),
              const SizedBox(height: 16),
              _buildTrendsCard(),

              const SizedBox(height: 32),
              _buildSectionHeader("Quick Actions", hasDetails: false),
              const SizedBox(height: 16),

              /// ACTION: MANAGE SERVICES - NO SHADOWS
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServiceManagementHubScreen(),
                  ),
                ),
                child: _buildActionButton(
                  title: "Manage Services",
                  subtitle: "SCHEDULE TECHNICIANS",
                  icon: Icons.settings_input_component,
                  color: RoColors.primaryBlue,
                ),
              ),

              const SizedBox(height: 16),

              /// ACTION: VIEW COMPLAINTS - NO SHADOWS
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComplaintManagementScreen(),
                  ),
                ),
                child: _buildActionButton(
                  title: "View Complaints",
                  subtitle: "RESOLVE ISSUES",
                  icon: Icons.report_problem_rounded,
                  color: const Color(0xFFFF5252), // Vibrant Red
                ),
              ),

              const SizedBox(height: 16),

              /// ACTION: ACTIVITY LOGS - NO SHADOWS
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActivityLogsArchiveScreen(),
                  ),
                ),
                child: _buildActionButton(
                  title: "Activity Logs",
                  subtitle: "HISTORY & ARCHIVE",
                  icon: Icons.history_rounded,
                  color: Colors.white,
                  textColor: RoColors.darkText,
                  iconBg: const Color(0xFFE8F5E9),
                  iconColor: Colors.green,
                  isOutlined: true,
                ),
              ),

              const SizedBox(height: 16),

              /// ACTION: PAYMENT DUE - NO SHADOWS
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentDuesScreen(),
                  ),
                ),
                child: _buildActionButton(
                  title: "Payment Due",
                  subtitle: "COLLECTIONS & DUES",
                  icon: Icons.payments_rounded,
                  color: Colors.white,
                  textColor: RoColors.darkText,
                  iconBg: const Color(0xFFE8F5E9),
                  iconColor: Colors.green,
                  isOutlined: true,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  /// ---------------- UI BUILDER METHODS ----------------

  Widget _buildScrollableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.water_drop, color: RoColors.primaryBlue, size: 20),
        ),
        const Text(
          "Admin Overview",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: Stack(
            alignment: Alignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.notifications_none, color: RoColors.darkText),
              ),
              Positioned(
                top: 2,
                right: 2,
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
    String badge,
    Color badgeBg,
    Color badgeText,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        // Shadows removed per request
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: CustomPaint(
              painter: SquigglePainter(
                color: color,
                isRevenue: label == "REVENUE TODAY",
                isComplaints: label == "COMPLAINTS",
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: RoColors.subText,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: RoColors.darkText,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        // Shadows removed per request
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "WEEKLY VOLUME",
                style: TextStyle(
                  color: RoColors.subText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "+12%",
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "\$28,500",
            style: TextStyle(
              color: RoColors.darkText,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar("MON", 0.3),
              _buildBar("TUE", 0.5),
              _buildBar("WED", 0.4),
              _buildBar("THU", 0.7),
              _buildBar("FRI", 0.6),
              _buildBar("SAT", 0.9, isSelected: true),
              _buildBar("SUN", 0.8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double heightFactor, {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          height: 100 * heightFactor,
          width: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? RoColors.primaryBlue
                : Colors.blue.withOpacity(0.1),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          day,
          style: const TextStyle(
            color: RoColors.subText,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required IconData icon,
    Color? color,
    Color? textColor,
    Color? iconBg,
    Color? iconColor,
    bool isOutlined = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOutlined ? Colors.white : (color ?? RoColors.primaryBlue),
        borderRadius: BorderRadius.circular(16),
        border: isOutlined ? Border.all(color: Colors.grey.shade200) : null,
        // Shadows removed per request
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg ?? Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor ?? Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: (textColor ?? Colors.white).withOpacity(0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: (textColor ?? Colors.white).withOpacity(0.5),
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool hasDetails = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: RoColors.darkText,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        if (hasDetails)
          const Text(
            "Details",
            style: TextStyle(
              color: RoColors.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
      ],
    );
  }

  /// ---------------- NAVIGATION LOGIC ----------------

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
          _buildNavItem(Icons.home_filled, "OVERVIEW", 0),
          _buildNavItem(Icons.people_alt_outlined, "CLIENTS", 1),
          _buildNavItem(Icons.assignment_outlined, "BOOKING", 2),
          _buildNavItem(Icons.settings_outlined, "SETTINGS", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedNavIndex == index;
    return InkWell(
      onTap: () {
        setState(() => _selectedNavIndex = index);
        switch (index) {
          case 0:
            break; // Stay on Overview
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerDirectoryScreen(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppointmentApprovalsScreen(),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminSettingsScreen(),
              ),
            );
            break;
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

class SquigglePainter extends CustomPainter {
  final Color color;
  final bool isRevenue;
  final bool isComplaints;

  SquigglePainter({
    required this.color,
    this.isRevenue = false,
    this.isComplaints = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (isRevenue) {
      // Upward green wave logic
      path.moveTo(0, size.height * 0.8);
      path.quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.9,
        size.width * 0.6,
        size.height * 0.5,
      );
      path.quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.1,
        size.width,
        size.height * 0.3,
      );
    } else if (isComplaints) {
      // Erratic red wave logic
      path.moveTo(0, size.height * 0.5);
      path.cubicTo(
        size.width * 0.2,
        size.height * 0.2,
        size.width * 0.4,
        size.height * 0.8,
        size.width * 0.6,
        size.height * 0.4,
      );
      path.cubicTo(
        size.width * 0.8,
        size.height * 0.1,
        size.width * 0.9,
        size.height * 0.9,
        size.width,
        size.height * 0.6,
      );
    } else {
      // Smooth blue/orange wave logic
      path.moveTo(0, size.height * 0.6);
      path.cubicTo(
        size.width * 0.25,
        size.height * 0.2,
        size.width * 0.5,
        size.height * 0.9,
        size.width * 0.75,
        size.height * 0.3,
      );
      path.quadraticBezierTo(
        size.width * 0.9,
        size.height * 0.1,
        size.width,
        size.height * 0.4,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
