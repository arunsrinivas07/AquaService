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

class ReviewConfirmScreen extends StatefulWidget {
  const ReviewConfirmScreen({super.key});

  @override
  State<ReviewConfirmScreen> createState() => _ReviewConfirmScreenState();
}

class _ReviewConfirmScreenState extends State<ReviewConfirmScreen> {
  int _selectedNavIndex = 1; // Clients area

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
                      "FINAL STEP",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "Review & Confirm",
                      style: TextStyle(
                        color: RoColors.darkText,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// STEPPER
                    _buildStepper(),
                    const SizedBox(height: 32),

                    /// CUSTOMER DETAILS SECTION
                    _buildSectionHeader('CUSTOMER DETAILS'),
                    const SizedBox(height: 12),
                    _buildInfoCard([
                      _buildInfoRow('NAME', 'Johnathan Doe'),
                      _buildDivider(),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoRow('PHONE', '+1 (555) 000-0000'),
                          ),
                          Expanded(child: _buildInfoRow('ID', 'CUST-82910')),
                        ],
                      ),
                      _buildDivider(),
                      _buildInfoRow(
                        'SERVICE ADDRESS',
                        '123 Aqua Way, Suite 400, SF, CA 94105',
                      ),
                    ]),

                    const SizedBox(height: 24),

                    /// MACHINE SPECIFICATIONS section
                    _buildSectionHeader('MACHINE SPECS'),
                    const SizedBox(height: 12),
                    _buildInfoCard([
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoRow('MODEL', 'HydroFlow X-500'),
                          ),
                          Expanded(
                            child: _buildInfoRow('SERIAL', 'HF-2024-9981'),
                          ),
                        ],
                      ),
                      _buildDivider(),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoRow(
                              'FILTER',
                              'Carbon Multi-Stage',
                            ),
                          ),
                          Expanded(
                            child: _buildInfoRow('INSTALL', 'Next Available'),
                          ),
                        ],
                      ),
                    ]),

                    const SizedBox(height: 24),

                    /// PLAN INFO section
                    _buildSectionHeader('PLAN & SERVICE'),
                    const SizedBox(height: 12),
                    _buildPlanSummaryCard(),

                    const SizedBox(height: 24),

                    /// BILLING NOTE
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F7FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: RoColors.primaryBlue,
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Billing starts after successful machine installation.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF00838F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

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
          "Confirmation",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.print_outlined, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildStepper() {
    return Row(
      children: [
        _buildStep(1, "Details", true),
        _buildLine(true),
        _buildStep(2, "Plan", true),
        _buildLine(true),
        _buildStep(3, "Review", true, isActive: true),
      ],
    );
  }

  Widget _buildStep(
    int step,
    String label,
    bool isCompleted, {
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCompleted ? RoColors.primaryBlue : Colors.white,
            border: Border.all(
              color: isCompleted ? RoColors.primaryBlue : Colors.grey.shade300,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted && !isActive
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    "$step",
                    style: TextStyle(
                      color: isCompleted ? Colors.white : RoColors.subText,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? RoColors.primaryBlue : RoColors.subText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool isFull) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
        color: isFull ? RoColors.primaryBlue : Colors.grey.shade200,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: RoColors.subText,
            letterSpacing: 1.1,
          ),
        ),
        const Icon(Icons.edit_square, size: 18, color: RoColors.primaryBlue),
      ],
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
          const SizedBox(height: 2),
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
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1, color: Color(0xFFF1F5F9)),
    );
  }

  Widget _buildPlanSummaryCard() {
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
            decoration: BoxDecoration(
              color: RoColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.water_drop,
              color: RoColors.primaryBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Monthly',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
                Text(
                  'Unlimited Service',
                  style: TextStyle(fontSize: 12, color: RoColors.subText),
                ),
              ],
            ),
          ),
          const Text(
            '\$49.99',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: RoColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "PREVIOUS",
              style: TextStyle(
                color: RoColors.subText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () => _showSuccessDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: RoColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              "ADD CUSTOMER",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            const Text(
              'SUCCESS!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Customer has been added to the registry.',
              textAlign: TextAlign.center,
              style: TextStyle(color: RoColors.subText),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminDashboard(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: RoColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'BACK TO DASHBOARD',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
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
          _buildNavItem(Icons.assignment_outlined, "BILLING", 2),
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
