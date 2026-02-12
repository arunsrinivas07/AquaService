import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/admin_dashboard_screen.dart';
import 'package:ro_water/features/admin/customer_directory_screen.dart';
import 'package:ro_water/features/admin/customer_map_screen.dart';
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

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool hasAccess = true;
  int _selectedNavIndex = 1; // Clients tab

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
                    /// PROFILE HEADER
                    _buildProfileMainHeader(),
                    const SizedBox(height: 32),

                    /// ACCESS TOGGLE CARD
                    _buildAccessToggleCard(),
                    const SizedBox(height: 24),

                    /// PROFILE DETAILS SECTION
                    _buildSectionLabel("PROFILE DETAILS"),
                    const SizedBox(height: 12),
                    _buildInfoCard([
                      _buildDetailRow(
                        Icons.phone_outlined,
                        "Phone",
                        "+1 (555) 012-3456",
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        Icons.email_outlined,
                        "Email",
                        "m.richardson@email.com",
                      ),
                      _buildDivider(),
                      _buildDetailRow(
                        Icons.location_on_outlined,
                        "Address",
                        "742 Evergreen Terrace,\nSpringfield, OR",
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomerMapScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: RoColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  color: RoColors.primaryBlue,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "LOCATE",
                                  style: TextStyle(
                                    color: RoColors.primaryBlue,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),

                    const SizedBox(height: 24),

                    /// MACHINE SPECS SECTION
                    _buildSectionLabel("MACHINE SPECS"),
                    const SizedBox(height: 12),
                    _buildInfoCard([
                      Row(
                        children: [
                          Expanded(
                            child: _buildSpecsItem("MODEL", "AquaPure Pro V2"),
                          ),
                          Expanded(
                            child: _buildSpecsItem("SERIAL", "SRN-883-9910"),
                          ),
                        ],
                      ),
                      _buildDivider(),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSpecsItem("INSTALL", "Jan 12, 2023"),
                          ),
                          Expanded(child: _buildFilterLifeItem(0.75)),
                        ],
                      ),
                    ]),

                    const SizedBox(height: 24),

                    /// SERVICE HISTORY SECTION
                    _buildSectionLabel("SERVICE HISTORY"),
                    const SizedBox(height: 12),
                    _buildServiceHistoryList(),

                    const SizedBox(height: 24),

                    /// PAYMENT STATUS SECTION
                    _buildSectionLabel("PAYMENT STATUS"),
                    const SizedBox(height: 12),
                    _buildPaymentStatusCard(),

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
        child: const Icon(Icons.edit_outlined, color: Colors.white),
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
          "Customer Profile",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.more_horiz, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildProfileMainHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8BCB3),
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: const Center(
                child: Text(
                  "MR",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Marcus Richardson",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: RoColors.darkText,
                    ),
                  ),
                  Text(
                    "ID: #WTR-9902T-X",
                    style: TextStyle(
                      fontSize: 14,
                      color: RoColors.subText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusBadge(
                        "PREMIUM",
                        const Color(0xFFE3F2FD),
                        Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _buildStatusBadge(
                        "ACTIVE",
                        const Color(0xFFE8F5E9),
                        Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String text, Color bg, Color textC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textC,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccessToggleCard() {
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
                "SYSTEM ACCESS",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: RoColors.subText,
                ),
              ),
              Text(
                "Service connectivity status",
                style: TextStyle(fontSize: 12, color: RoColors.subText),
              ),
            ],
          ),
          Switch(
            value: hasAccess,
            activeThumbColor: RoColors.primaryBlue,
            onChanged: (v) => setState(() => hasAccess = v),
          ),
        ],
      ),
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

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, color: RoColors.subText, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: RoColors.subText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: RoColors.darkText,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildSpecsItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: RoColors.subText,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: RoColors.darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterLifeItem(double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "FILTER LIFE",
          style: TextStyle(
            fontSize: 10,
            color: RoColors.subText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey.shade100,
                color: RoColors.primaryBlue,
                minHeight: 4,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "${(value * 100).toInt()}%",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: Color(0xFFF1F5F9)),
    );
  }

  Widget _buildServiceHistoryList() {
    return _buildInfoCard([
      _buildServiceHistoryItem(
        Icons.auto_awesome_outlined,
        "Filter Replacement",
        "Oct 12",
        Colors.blue,
      ),
      _buildDivider(),
      _buildServiceHistoryItem(
        Icons.build_outlined,
        "Leak Repair",
        "Aug 05",
        Colors.purple,
      ),
      _buildDivider(),
      _buildServiceHistoryItem(
        Icons.check_circle_outline,
        "Initial Install",
        "Jan 12",
        Colors.green,
      ),
    ]);
  }

  Widget _buildServiceHistoryItem(
    IconData icon,
    String title,
    String date,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: RoColors.darkText,
            ),
          ),
        ),
        Text(
          date,
          style: const TextStyle(fontSize: 12, color: RoColors.subText),
        ),
      ],
    );
  }

  Widget _buildPaymentStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.credit_card, color: Colors.red, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DUE BALANCE",
                  style: TextStyle(
                    fontSize: 10,
                    color: RoColors.subText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$84.50",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: RoColors.darkText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "OVERDUE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
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
