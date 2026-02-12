import 'package:flutter/material.dart';
import 'package:ro_water/features/admin/review_confirm_screen.dart';
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

class SelectServicePlanScreen extends StatefulWidget {
  const SelectServicePlanScreen({super.key});

  @override
  State<SelectServicePlanScreen> createState() =>
      _SelectServicePlanScreenState();
}

class _SelectServicePlanScreenState extends State<SelectServicePlanScreen> {
  String selectedPlan = 'Standard';
  String selectedFrequency = 'Quarterly';
  DateTime selectedDate = DateTime.now();
  int _selectedNavIndex = 1; // Clients area

  final List<Map<String, dynamic>> servicePlans = [
    {
      'name': 'Basic',
      'icon': Icons.water_drop_outlined,
      'description': 'Standard water delivery service with on-call support.',
    },
    {
      'name': 'Standard',
      'icon': Icons.water_drop,
      'description': 'Includes filter cleaning and priority delivery windows.',
    },
    {
      'name': 'AMC',
      'icon': Icons.build_outlined,
      'description': 'Annual Maintenance Contract with all repairs covered.',
    },
  ];

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
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
                      "ADD NEW",
                      style: TextStyle(
                        color: RoColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "Select Service Plan",
                      style: TextStyle(
                        color: RoColors.darkText,
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// STEPPER (MATCHING STYLE)
                    _buildStepper(),
                    const SizedBox(height: 32),

                    /// PLAN SELECTION
                    const Text(
                      "Service Plan Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: RoColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...servicePlans.map((plan) => _buildServicePlanCard(plan)),

                    const SizedBox(height: 24),

                    /// FREQUENCY
                    const Text(
                      "Service Frequency",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: RoColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDropdown(),

                    const SizedBox(height: 24),

                    /// START DATE
                    const Text(
                      "Service Start Date",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: RoColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(),

                    const SizedBox(height: 40),

                    /// PREVIOUS & NEXT BUTTONS
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
          "Plan Setup",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.help_outline, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildStepper() {
    return Row(
      children: [
        _buildStep(1, "Details", true),
        _buildLine(true),
        _buildStep(2, "Plan", true, isActive: true),
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

  Widget _buildServicePlanCard(Map<String, dynamic> plan) {
    final isSelected = selectedPlan == plan['name'];
    return GestureDetector(
      onTap: () => setState(() => selectedPlan = plan['name']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? RoColors.primaryBlue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? RoColors.primaryBlue.withOpacity(0.1)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                plan['icon'],
                color: isSelected ? RoColors.primaryBlue : RoColors.subText,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: RoColors.darkText,
                    ),
                  ),
                  Text(
                    plan['description'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: RoColors.subText,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: RoColors.primaryBlue,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white, // Removes the pinkish default background
          hoverColor: RoColors.primaryBlue.withOpacity(0.05),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedFrequency,
            isExpanded: true,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: RoColors.subText,
            ),
            onChanged: (val) => setState(() => selectedFrequency = val!),
            items: ['Weekly', 'Bi-weekly', 'Monthly', 'Quarterly', 'Yearly']
                .map((v) {
                  return DropdownMenuItem(
                    value: v,
                    child: Text(
                      v,
                      style: const TextStyle(
                        color: RoColors.darkText,
                        fontSize: 14,
                      ),
                    ),
                  );
                })
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: RoColors.primaryBlue,
                  onPrimary: Colors.white,
                  onSurface: RoColors.darkText,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: RoColors.primaryBlue,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != selectedDate) {
          setState(() => selectedDate = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(selectedDate),
              style: const TextStyle(color: RoColors.darkText),
            ),
            const Icon(Icons.calendar_today, color: RoColors.subText, size: 18),
          ],
        ),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReviewConfirmScreen()),
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
                  "CONTINUE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 18),
              ],
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
