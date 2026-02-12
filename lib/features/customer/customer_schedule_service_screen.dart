import 'package:flutter/material.dart';

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;

  // Status Colors
  static const Color statusActive = Color(0xFFE0F7FA);
  static const Color statusActiveText = Color(0xFF00BCD4);
}

class CustomerScheduleServiceScreen extends StatefulWidget {
  const CustomerScheduleServiceScreen({super.key});

  @override
  State<CustomerScheduleServiceScreen> createState() =>
      _CustomerScheduleServiceScreenState();
}

class _CustomerScheduleServiceScreenState
    extends State<CustomerScheduleServiceScreen> {
  DateTime selectedDate = DateTime(2023, 10, 5);
  String selectedTimeSlot = 'Morning';

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServiceCard(),
                    const SizedBox(height: 32),
                    const Text(
                      'SELECT SERVICE DATE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: RoColors.subText,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCalendar(),
                    const SizedBox(height: 32),
                    const Text(
                      'SELECT TIME SLOT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: RoColors.subText,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTimeSlot(
                      icon: Icons.wb_sunny_outlined,
                      title: 'Morning',
                      time: '9:00 AM - 12:00 PM',
                      isSelected: selectedTimeSlot == 'Morning',
                    ),
                    const SizedBox(height: 12),
                    _buildTimeSlot(
                      icon: Icons.wb_sunny,
                      title: 'Afternoon',
                      time: '12:00 PM - 4:00 PM',
                      isSelected: selectedTimeSlot == 'Afternoon',
                    ),
                    const SizedBox(height: 12),
                    _buildTimeSlot(
                      icon: Icons.nightlight_round,
                      title: 'Evening',
                      time: '4:00 PM - 7:00 PM',
                      isSelected: selectedTimeSlot == 'Evening',
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SELECTED APPOINTMENT',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: RoColors.subText,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Filter Replacement Service',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: RoColors.darkText,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: RoColors.primaryBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'OCT 5 • MORNING',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RoColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'CONFIRM BOOKING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Free cancellation up to 24h before service.',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: RoColors.subText,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
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
          "Schedule Service",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(
            Icons.calendar_today_outlined,
            color: RoColors.primaryBlue,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: RoColors.statusActive,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.water_drop_outlined,
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
                  'Filter Replacement',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ROWATER MAINTENANCE PLUS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: RoColors.subText,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, size: 20),
                onPressed: () {},
                color: RoColors.darkText,
              ),
              const Text(
                'October 2023',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: RoColors.darkText,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 20),
                onPressed: () {},
                color: RoColors.darkText,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map(
                  (day) => Flexible(
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 11,
                          color: RoColors.subText,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          ..._buildCalendarWeeks(),
        ],
      ),
    );
  }

  List<Widget> _buildCalendarWeeks() {
    final weeks = [
      [24, 25, 26, 27, 28, 29, 1],
      [2, 3, 4, 5, 6, 7, 8],
      [9, 10, 11, 12, 13, 14, 15],
      [16, 17, 18, 19, 20, 21, 22],
    ];

    return weeks.map((week) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: week.map((day) {
            final isSelected = day == 5;
            final isPastMonth = day > 22;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDate = DateTime(2023, 10, day);
                });
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isSelected ? RoColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w900
                          : FontWeight.bold,
                      color: isSelected
                          ? Colors.white
                          : isPastMonth
                          ? const Color(0xFFCBD5E1)
                          : RoColors.darkText,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  Widget _buildTimeSlot({
    required IconData icon,
    required String title,
    required String time,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeSlot = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: RoColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? RoColors.primaryBlue : const Color(0xFFF1F5F9),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? RoColors.statusActive
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? RoColors.primaryBlue : RoColors.subText,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: RoColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? RoColors.primaryBlue
                      : const Color(0xFFCBD5E1),
                  width: 2,
                ),
                color: isSelected ? RoColors.primaryBlue : Colors.white,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.check, color: Colors.white, size: 12),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
