import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/select_service_plan_screen.dart';
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

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({super.key});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final _fullNameController = TextEditingController(text: 'John Doe');
  final _phoneController = TextEditingController(text: '+1 (555) 000-0000');
  final _customerIdController = TextEditingController(text: 'CUST-82910');
  final _addressController = TextEditingController(
    text: 'Street name, house number, apartment...',
  );
  int _selectedNavIndex = 1; // Clients area

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _customerIdController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
                      "STEP 01",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "Customer Details",
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

                    /// FORM INPUTS
                    _buildLabel("FULL NAME"),
                    const SizedBox(height: 8),
                    _buildTextField(_fullNameController, "e.g. Johnathan Doe"),

                    const SizedBox(height: 24),
                    _buildLabel("PHONE NUMBER"),
                    const SizedBox(height: 8),
                    _buildTextField(_phoneController, "e.g. +1 234 567 890"),

                    const SizedBox(height: 24),
                    _buildLabel("SYSTEM ID"),
                    const SizedBox(height: 8),
                    _buildTextField(
                      _customerIdController,
                      "e.g. ID-9921",
                      suffix: Icons.qr_code_scanner,
                      verticalPadding: 16,
                    ),

                    const SizedBox(height: 24),
                    _buildLabel("SERVICE ADDRESS"),
                    const SizedBox(height: 8),
                    _buildTextField(
                      _addressController,
                      "Enter full address",
                      maxLines: 3,
                      verticalPadding: 16,
                    ),

                    const SizedBox(height: 24),

                    /// MAP PREVIEW (FLAT DESIGN)
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade50,
                                    Colors.teal.shade50,
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: RoColors.primaryBlue,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Tap to select on map",
                                    style: TextStyle(
                                      color: RoColors.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// NEXT BUTTON
                    _buildNextButton(),
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
          "Customer Setup",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.contact_phone_outlined,
            color: RoColors.darkText,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildStepper() {
    return Row(
      children: [
        _buildStep(1, "Details", true, isActive: true),
        _buildLine(false),
        _buildStep(2, "Plan", false),
        _buildLine(false),
        _buildStep(3, "Review", false),
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
            color: isActive ? RoColors.primaryBlue : Colors.white,
            border: Border.all(
              color: isActive ? RoColors.primaryBlue : Colors.grey.shade300,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "$step",
              style: TextStyle(
                color: isActive ? Colors.white : RoColors.subText,
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: RoColors.subText,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    IconData? suffix,
    int maxLines = 1,
    double? verticalPadding,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textAlignVertical: maxLines > 1
            ? TextAlignVertical.top
            : TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          contentPadding: verticalPadding != null
              ? EdgeInsets.symmetric(vertical: verticalPadding)
              : null,
          suffixIcon: suffix != null
              ? Icon(suffix, color: RoColors.subText, size: 20)
              : null,
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SelectServicePlanScreen()),
          );
        },
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
            Text(
              "CONTINUE TO PLAN",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward, color: Colors.white, size: 18),
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
