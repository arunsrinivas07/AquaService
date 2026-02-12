import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/admin_dashboard_screen.dart';
import 'package:ro_water/features/admin/customer_directory_screen.dart';
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

class ComplaintDetailScreen extends StatefulWidget {
  const ComplaintDetailScreen({super.key});

  @override
  State<ComplaintDetailScreen> createState() => _ComplaintDetailScreenState();
}

class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
  String selectedStatus = 'Technician Dispatched';
  int _selectedNavIndex =
      0; // Usually linked to complaints which is part of Overview/Home

  final List<Map<String, dynamic>> chatMessages = [
    {
      'message': 'Hello, the leak is getting worse. When can I expect someone?',
      'time': '11:02 AM',
      'sender': 'Customer',
      'isCustomer': true,
    },
    {
      'message':
          'We\'ve received your update. A technician is being assigned to your location immediately.',
      'time': '11:03 AM',
      'sender': 'System',
      'isCustomer': false,
    },
    {
      'message': 'Okay, thank you. I\'ll be waiting in the garage.',
      'time': '11:05 AM',
      'sender': 'Customer',
      'isCustomer': true,
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
                      "COMPLAINT #99210",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "Ticket Details",
                      style: TextStyle(
                        color: RoColors.darkText,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 32),

                    /// CUSTOMER PROFILE SECTION
                    _buildSectionLabel("CUSTOMER"),
                    const SizedBox(height: 12),
                    _buildProfileCard(),

                    const SizedBox(height: 24),

                    /// STATUS PICKER
                    _buildSectionLabel("TICKET STATUS"),
                    const SizedBox(height: 12),
                    _buildStatusPicker(),

                    const SizedBox(height: 24),

                    /// ISSUE DESCRIPTION
                    _buildSectionLabel("DESCRIPTION"),
                    const SizedBox(height: 12),
                    _buildDescriptionCard(),

                    const SizedBox(height: 24),

                    /// VOICE LOGS
                    _buildSectionLabel("VOICE LOGS"),
                    const SizedBox(height: 12),
                    _buildVoiceLogCard(),

                    const SizedBox(height: 24),

                    /// CHAT LOGS
                    _buildSectionLabel("CHAT LOGS"),
                    const SizedBox(height: 12),
                    ...chatMessages.map((msg) => _buildChatMessage(msg)),

                    const SizedBox(height: 40),

                    /// ACTION BUTTONS
                    _buildActionButtons(),
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
          "Review Ticket",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.share_outlined, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: RoColors.subText,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE8BCB3),
            ),
            child: const Center(
              child: Text(
                "RF",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Robert Fox",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
                Text(
                  "Acct #WS-99210",
                  style: TextStyle(fontSize: 12, color: RoColors.subText),
                ),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Reported",
                style: TextStyle(
                  fontSize: 10,
                  color: RoColors.subText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "10:45 AM",
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

  Widget _buildStatusPicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: RoColors.subText),
          onChanged: (v) => setState(() => selectedStatus = v!),
          items: ['Open', 'Technician Dispatched', 'In Progress', 'Resolved']
              .map((s) {
                return DropdownMenuItem(
                  value: s,
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: s == 'Resolved'
                              ? Colors.green
                              : (s == 'Open'
                                    ? Colors.red
                                    : RoColors.primaryBlue),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        s,
                        style: const TextStyle(
                          color: RoColors.darkText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              })
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        "Heavy water leakage reported in the main basement valve. Pressure levels fluctuating significantly since morning. Immediate attention required to prevent flooding in the storage area.",
        style: TextStyle(fontSize: 14, color: RoColors.darkText, height: 1.5),
      ),
    );
  }

  Widget _buildVoiceLogCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: RoColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: List.generate(20, (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    height: (index % 3 == 0) ? 24 : (index % 2 == 0 ? 16 : 8),
                    decoration: BoxDecoration(
                      color: index < 8
                          ? RoColors.primaryBlue
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            "0:12 / 0:45",
            style: TextStyle(
              fontSize: 10,
              color: RoColors.subText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(Map<String, dynamic> message) {
    final isCustomer = message['isCustomer'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isCustomer
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isCustomer ? Colors.white : RoColors.primaryBlue,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isCustomer ? 0 : 16),
                bottomRight: Radius.circular(isCustomer ? 16 : 0),
              ),
            ),
            child: Text(
              message['message'],
              style: TextStyle(
                fontSize: 14,
                color: isCustomer ? RoColors.darkText : Colors.white,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${message['time']} • ${message['sender']}",
            style: const TextStyle(
              fontSize: 10,
              color: RoColors.subText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: RoColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add_alt, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text(
                  "ASSIGN TECHNICIAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "MARK AS RESOLVED",
              style: TextStyle(
                color: RoColors.subText,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
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
