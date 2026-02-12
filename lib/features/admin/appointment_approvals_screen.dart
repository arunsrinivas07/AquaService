import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/admin_dashboard_screen.dart';
import 'package:ro_water/features/admin/customer_directory_screen.dart';

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

class AppointmentApprovalsScreen extends StatefulWidget {
  const AppointmentApprovalsScreen({super.key});

  @override
  State<AppointmentApprovalsScreen> createState() =>
      _AppointmentApprovalsScreenState();
}

class _AppointmentApprovalsScreenState extends State<AppointmentApprovalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedNavIndex = 0; // Usually linked to Overview or a specific tab

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> pendingAppointments = [
    {
      'type': 'METER REPAIR',
      'name': 'John Doe',
      'date': 'Oct 24',
      'time': '10:00 AM',
      'address': '123 Aqua Way, Riverside',
      'icon': Icons.water_drop,
      'color': Colors.blue,
    },
    {
      'type': 'LEAK INSPECTION',
      'name': 'Jane Smith',
      'date': 'Oct 25',
      'time': '02:30 PM',
      'address': '456 Brook Dr, West End',
      'icon': Icons.build,
      'color': Colors.orange,
    },
    {
      'type': 'VALVE REPLACEMENT',
      'name': 'Mike Ross',
      'date': 'Oct 26',
      'time': '09:15 AM',
      'address': '789 Stream Ln, Downtown',
      'icon': Icons.settings,
      'color': Colors.purple,
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

            /// TAB BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildCustomTabBar(),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPendingTab(),
                  _buildEmptyTab('No approved appointments'),
                  _buildEmptyTab('No history yet'),
                ],
              ),
            ),
          ],
        ),
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
        const Column(
          children: [
            Text(
              "Approvals Center",
              style: TextStyle(
                color: RoColors.darkText,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "Manage Bookings",
              style: TextStyle(
                fontSize: 12,
                color: RoColors.subText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.tune, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: RoColors.primaryBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: RoColors.subText,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        tabs: const [
          Tab(text: "Pending"),
          Tab(text: "Approved"),
          Tab(text: "History"),
        ],
      ),
    );
  }

  Widget _buildPendingTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: pendingAppointments.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(pendingAppointments[index]);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (appointment['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  appointment['type'],
                  style: TextStyle(
                    color: appointment['color'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Icon(Icons.more_horiz, color: RoColors.subText),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: (appointment['color'] as Color).withOpacity(
                  0.1,
                ),
                child: Icon(
                  appointment['icon'] as IconData,
                  color: appointment['color'] as Color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: RoColors.darkText,
                      ),
                    ),
                    Text(
                      appointment['address'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: RoColors.subText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildDateTimeItem(
                Icons.calendar_today_outlined,
                appointment['date'],
              ),
              const SizedBox(width: 24),
              _buildDateTimeItem(Icons.access_time, appointment['time']),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "RESCHEDULE",
                    style: TextStyle(
                      color: RoColors.subText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RoColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "APPROVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: RoColors.subText),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: RoColors.darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyTab(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 60,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: RoColors.subText,
              fontSize: 14,
              fontWeight: FontWeight.bold,
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
            // Already on Booking screen
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
