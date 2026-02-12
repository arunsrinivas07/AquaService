import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/admin_dashboard_screen.dart';
import 'package:ro_water/features/admin/customer_directory_screen.dart';
import 'package:ro_water/features/admin/appointment_approvals_screen.dart';

/// ------------------------------------------------------------
/// UPDATED REPLICA DESIGN SYSTEM (Matching Admin Dashboard)
/// ------------------------------------------------------------

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;
}

class ActivityLogsArchiveScreen extends StatefulWidget {
  const ActivityLogsArchiveScreen({super.key});

  @override
  State<ActivityLogsArchiveScreen> createState() =>
      _ActivityLogsArchiveScreenState();
}

class _ActivityLogsArchiveScreenState extends State<ActivityLogsArchiveScreen> {
  int _selectedNavIndex = 2; // Assuming Billing/Logs is the 3rd item

  final List<Map<String, dynamic>> activities = [
    {
      'name': 'John Smith',
      'service': 'Water Pressure Regulator Repair',
      'time': '10:45 AM, Oct 24',
      'status': 'RESOLVED',
      'icon': Icons.build,
      'isCompleted': false,
    },
    {
      'name': 'Riverside Plaza',
      'service': 'Quarterly System Maintenance',
      'time': '02:15 PM, Oct 23',
      'status': 'COMPLETED',
      'icon': Icons.check,
      'isCompleted': true,
    },
    {
      'name': 'Central Mall',
      'service': 'Main Valve Installation Block A',
      'time': '09:00 AM, Oct 20',
      'status': 'COMPLETED',
      'icon': Icons.add,
      'isCompleted': true,
    },
    {
      'name': 'Heritage Estates',
      'service': 'Leak Detection & Repair',
      'time': '04:30 PM, Oct 18',
      'status': 'RESOLVED',
      'icon': Icons.build,
      'isCompleted': false,
    },
    {
      'name': 'Eastside Hospital',
      'service': 'Annual Safety Inspection',
      'time': '11:20 AM, Oct 12',
      'status': 'COMPLETED',
      'icon': Icons.check,
      'isCompleted': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// SCROLLABLE TOP PART (MATCHING DASHBOARD)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildScrollableHeader(),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "HISTORY",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "Activity Archive",
                      style: TextStyle(
                        color: RoColors.darkText,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// TIME PERIOD FILTER CARD
                    _buildTimePeriodCard(),
                    const SizedBox(height: 24),

                    /// ACTIVITY LIST
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activities.length + 1,
                      itemBuilder: (context, index) {
                        if (index == activities.length) {
                          return _buildEndOfArchive();
                        }
                        return _buildActivityItem(activities[index], index);
                      },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: RoColors.primaryBlue,
        child: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildScrollableHeader() {
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
          "Logs Archive",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.search, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildTimePeriodCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TIME PERIOD',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: RoColors.primaryBlue,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Oct 01 - Oct 31, 2023',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: RoColors.darkText,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: RoColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: RoColors.primaryBlue,
                ),
                SizedBox(width: 8),
                Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: RoColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline logic remains similar but styled
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: RoColors.primaryBlue, width: 2),
              ),
              child: Icon(
                activity['icon'],
                color: RoColors.primaryBlue,
                size: 20,
              ),
            ),
            if (index < activities.length - 1)
              Container(
                width: 2,
                height: 80,
                color: RoColors.primaryBlue.withOpacity(0.1),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        activity['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: RoColors.darkText,
                        ),
                      ),
                    ),
                    _buildStatusBadge(activity['status']),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  activity['service'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: RoColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: RoColors.subText,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      activity['time'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: RoColors.subText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    bool isCompleted = status == 'COMPLETED';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.shade50 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: isCompleted ? Colors.green : Colors.blue,
        ),
      ),
    );
  }

  Widget _buildEndOfArchive() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 2,
            color: RoColors.primaryBlue.withOpacity(0.1),
          ),
          const SizedBox(height: 16),
          const Text(
            'END OF ARCHIVE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: RoColors.subText,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- NAVIGATION LOGIC (MATCHING DASHBOARD) ----------------

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminDashboard()),
            );
            break;
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
