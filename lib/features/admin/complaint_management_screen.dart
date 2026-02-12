import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/customer_directory_screen.dart';
import 'package:ro_water/features/admin/admin_dashboard_screen.dart';
import 'package:ro_water/features/admin/complaint_detail_screen.dart';
import 'package:ro_water/features/admin/appointment_approvals_screen.dart';
import 'package:ro_water/features/admin/admin_settings_screen.dart';

/// ------------------------------------------------------------
/// UPDATED REPLICA DESIGN SYSTEM (Matching Admin Dashboard)
/// ------------------------------------------------------------

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;

  // Status Colors
  static const Color statusOpen = Color(0xFFFFEBEE);
  static const Color statusOpenText = Color(0xFFFF5252);
  static const Color statusProgress = Color(0xFFE3F2FD);
  static const Color statusProgressText = Color(0xFF2196F3);
}

class ComplaintManagementScreen extends StatefulWidget {
  const ComplaintManagementScreen({super.key});

  @override
  State<ComplaintManagementScreen> createState() =>
      _ComplaintManagementScreenState();
}

class _ComplaintManagementScreenState extends State<ComplaintManagementScreen> {
  String selectedStatus = 'All Status';
  int _selectedNavIndex =
      2; // Default to BILLING/LOGS or similar if applicable, but for this screen we match dashboard logic

  final List<Map<String, dynamic>> complaints = [
    {
      'customer': 'John Doe',
      'issue': 'Low water pressure',
      'ticketId': '#WQ-8921',
      'date': 'Oct 24, 2023',
      'time': '10:30 AM',
      'status': 'Open',
      'priority': 'HIGH',
      'icon': Icons.water_drop,
    },
    {
      'customer': 'Jane Smith',
      'issue': 'Main Pipe Leakage',
      'ticketId': '#WQ-8945',
      'date': 'Oct 24, 2023',
      'time': '11:15 AM',
      'status': 'Open',
      'priority': 'HIGH',
      'icon': Icons.build,
    },
    {
      'customer': 'Robert Wilson',
      'issue': 'Billing discrepancy',
      'ticketId': '#WQ-8890',
      'date': 'Oct 23, 2023',
      'time': '04:45 PM',
      'status': 'Resolved',
      'priority': 'LOW',
      'icon': Icons.description,
    },
    {
      'customer': 'Maria Garcia',
      'issue': 'Meter installation request',
      'ticketId': '#WQ-8912',
      'date': 'Oct 24, 2023',
      'time': '09:00 AM',
      'status': 'In Progress',
      'priority': 'MED',
      'icon': Icons.build_circle,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

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
                      "MANAGEMENT",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "Customer Complaints",
                      style: TextStyle(
                        color: RoColors.darkText,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// FILTERS (MATCHING THEME - NO SHADOWS)
                    _buildFilters(w),
                    const SizedBox(height: 24),

                    /// COMPLAINTS LIST
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ComplaintDetailScreen(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: _buildComplaintCard(complaints[index], w),
                        );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: RoColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      bottomNavigationBar: _buildBottomNav(),
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
          "Complaints Overview",
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

  Widget _buildFilters(double w) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('All Status', true, w),
              const SizedBox(width: 8),
              _buildFilterChip('Open', false, w),
              const SizedBox(width: 8),
              _buildFilterChip('In Progress', false, w),
              const SizedBox(width: 8),
              _buildFilterChip('Closed', false, w),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, double w) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? RoColors.primaryBlue : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? RoColors.primaryBlue : Colors.grey.shade200,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : RoColors.subText,
        ),
      ),
    );
  }

  Widget _buildComplaintCard(Map<String, dynamic> complaint, double w) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        // No shadows per request
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                complaint['ticketId'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: RoColors.primaryBlue,
                ),
              ),
              _buildPriorityBadge(complaint['priority']),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            complaint['customer'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: RoColors.darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            complaint['issue'],
            style: const TextStyle(fontSize: 14, color: RoColors.subText),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: RoColors.subText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${complaint['date']} • ${complaint['time']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: RoColors.subText,
                    ),
                  ),
                ],
              ),
              _buildStatusIndicator(complaint['status']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = Colors.grey;
    if (priority == 'HIGH') color = Colors.redAccent;
    if (priority == 'MED') color = Colors.blueAccent;
    if (priority == 'LOW') color = Colors.orangeAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color color = Colors.grey;
    if (status == 'Open') color = Colors.red;
    if (status == 'In Progress') color = Colors.blue;
    if (status == 'Resolved') color = Colors.green;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          status,
          style: TextStyle(
            color: RoColors.darkText,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
