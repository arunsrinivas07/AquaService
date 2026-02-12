import 'package:flutter/material.dart';
import 'package:ro_water/features/customer/customer_report_issue_screen.dart';
import 'package:ro_water/features/customer/customer_profile_settings_screen.dart';
import 'package:ro_water/features/customer/customer_home_screen.dart';

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;

  // Status Colors
  static const Color statusActive = Color(0xFFE0F7FA);
  static const Color statusActiveText = Color(0xFF00BCD4);
  static const Color statusCompleted = Color(0xFFE8F5E9);
  static const Color statusCompletedText = Color(0xFF4CAF50);
}

class CustomerServiceHistoryScreen extends StatefulWidget {
  const CustomerServiceHistoryScreen({super.key});

  @override
  State<CustomerServiceHistoryScreen> createState() =>
      _CustomerServiceHistoryScreenState();
}

class _CustomerServiceHistoryScreenState
    extends State<CustomerServiceHistoryScreen> {
  int _selectedNavIndex = 1;
  String selectedYear = '2023';

  final List<Map<String, dynamic>> serviceHistory = [
    {
      'date': '08 NOV 2023',
      'title': 'Regular Maintenance',
      'status': 'COMPLETED',
      'technician': 'Robert Wilson',
      'color': RoColors.primaryBlue,
    },
    {
      'date': '15 SEP 2023',
      'title': 'Filter Replacement',
      'status': 'RESOLVED',
      'technician': 'Sarah Jenkins',
      'color': RoColors.primaryBlue,
    },
    {
      'date': '22 JUL 2023',
      'title': 'Water Leakage Issue',
      'status': 'RESOLVED',
      'technician': 'David Chen',
      'description': 'Complaint ID: #RO-44291. Resolved within 4 hours.',
      'color': const Color(0xFFFF5252),
    },
    {
      'date': '10 MAY 2023',
      'title': 'Installation & Setup',
      'status': 'COMPLETED',
      'technician': 'Robert Wilson',
      'color': RoColors.subText,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildScrollableHeader(context),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SERVICE TIMELINE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: RoColors.subText,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Year: $selectedYear',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: RoColors.darkText,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                                color: RoColors.darkText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: serviceHistory.length,
                      itemBuilder: (context, index) {
                        return _buildServiceCard(serviceHistory[index], index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildScrollableHeader(BuildContext context) {
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
          "Service History",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(Icons.history, color: RoColors.primaryBlue, size: 18),
        ),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, int index) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Timeline Line
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: service['color'],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: service['color'].withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              if (index < serviceHistory.length - 1)
                Expanded(
                  child: Container(width: 2, color: const Color(0xFFE2E8F0)),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: RoColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service['date'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: RoColors.primaryBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: service['status'] == 'COMPLETED'
                              ? RoColors.statusCompleted
                              : RoColors.statusActive,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          service['status'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: service['status'] == 'COMPLETED'
                                ? RoColors.statusCompletedText
                                : RoColors.statusActiveText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: RoColors.darkText,
                    ),
                  ),
                  if (service.containsKey('description')) ...[
                    const SizedBox(height: 8),
                    Text(
                      service['description'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: RoColors.subText,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            size: 16,
                            color: RoColors.subText,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'TECHNICIAN',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  color: RoColors.subText,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                service['technician'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: RoColors.darkText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: RoColors.primaryBlue,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          _buildNavItem(Icons.home_filled, "HOME", 0),
          _buildNavItem(Icons.receipt_long, "HISTORY", 1),
          _buildNavItem(Icons.headset_mic, "SUPPORT", 2),
          _buildNavItem(Icons.person, "PROFILE", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedNavIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() => _selectedNavIndex = index);
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomerReportIssueScreen(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomerProfileSettingsScreen(),
              ),
            );
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
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
