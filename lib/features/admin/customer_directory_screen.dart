import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/customer_details_screen.dart';
import 'package:ro_water/features/admin/customer_profile_screen.dart';
import 'package:ro_water/features/admin/admin_dashboard_screen.dart';
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
}

class CustomerDirectoryScreen extends StatefulWidget {
  const CustomerDirectoryScreen({super.key});

  @override
  State<CustomerDirectoryScreen> createState() =>
      _CustomerDirectoryScreenState();
}

class _CustomerDirectoryScreenState extends State<CustomerDirectoryScreen> {
  String selectedFilter = 'All';
  int _selectedNavIndex = 1; // CLIENTS tab selected

  final List<Map<String, dynamic>> customers = [
    {
      'name': 'John Doe',
      'id': 'ID: #WS-90210',
      'status': 'ACTIVE',
      'hasAvatar': true,
      'initials': 'JD',
      'avatarColor': const Color(0xFF6B4423),
    },
    {
      'name': 'Sarah Smith',
      'id': 'ID: #WS-44321',
      'status': 'SERVICE DUE',
      'hasAvatar': true,
      'initials': 'SS',
      'avatarColor': const Color(0xFF8B6F47),
    },
    {
      'name': 'Aqua Corp',
      'id': 'ID: #WS-11223',
      'status': 'PAYMENT DUE',
      'hasAvatar': false,
      'initials': 'AC',
      'avatarColor': const Color(0xFF00BCD4),
    },
    {
      'name': 'Robert Johnson',
      'id': 'ID: #WS-88329',
      'status': 'ACTIVE',
      'hasAvatar': true,
      'initials': 'RJ',
      'avatarColor': const Color(0xFF5D4037),
    },
    {
      'name': 'Emily Davis',
      'id': 'ID: #WS-22941',
      'status': 'INACTIVE',
      'hasAvatar': true,
      'initials': 'ED',
      'avatarColor': const Color(0xFF8D6E63),
    },
    {
      'name': 'Michael Chen',
      'id': 'ID: #WS-66778',
      'status': 'ACTIVE',
      'hasAvatar': true,
      'initials': 'MC',
      'avatarColor': const Color(0xFF6D4C41),
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
                      "MANAGEMENT",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "Customer Directory",
                      style: TextStyle(
                        color: RoColors.darkText,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// SEARCH BAR
                    _buildSearchBar(),
                    const SizedBox(height: 24),

                    /// FILTER CHIPS
                    _buildFilters(),
                    const SizedBox(height: 24),

                    /// CUSTOMER LIST
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: customers.length,
                      itemBuilder: (context, index) {
                        return _buildCustomerCard(customers[index]);
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CustomerDetailsScreen()),
          );
        },
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
          "Clients Overview",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.tune, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: RoColors.subText, size: 20),
          SizedBox(width: 12),
          Text(
            'Search by name or ID...',
            style: TextStyle(fontSize: 14, color: RoColors.subText),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All'),
          const SizedBox(width: 8),
          _buildFilterChip('Service Due'),
          const SizedBox(width: 8),
          _buildFilterChip('Payment Due'),
          const SizedBox(width: 8),
          _buildFilterChip('Inactive'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
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
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomerProfileScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: RoColors.cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _buildAvatar(customer),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: RoColors.darkText,
                    ),
                  ),
                  Text(
                    customer['id'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: RoColors.subText,
                    ),
                  ),
                ],
              ),
            ),
            _buildStatusBadge(customer['status']),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              color: RoColors.subText,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(Map<String, dynamic> customer) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: customer['avatarColor'],
      ),
      child: Center(
        child: Text(
          customer['initials'],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = Colors.grey;
    Color bg = Colors.grey.shade100;

    if (status == 'ACTIVE') {
      color = const Color(0xFF4CAF50);
      bg = const Color(0xFFE8F5E9);
    } else if (status == 'SERVICE DUE') {
      color = Colors.orange;
      bg = const Color(0xFFFFF3E0);
    } else if (status == 'PAYMENT DUE') {
      color = Colors.red;
      bg = const Color(0xFFFFEBEE);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
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
            break; // Stay on Clients
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
