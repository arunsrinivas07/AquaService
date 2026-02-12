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

class CustomerTrackComplaintScreen extends StatelessWidget {
  const CustomerTrackComplaintScreen({super.key});

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
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Technician is on the way',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: RoColors.darkText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: RoColors.statusActive,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'COMPLAINT ID: #RW-9921',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: RoColors.primaryBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    _buildTimeline(),
                    const SizedBox(height: 40),
                    _buildTechnicianCard(),
                    const SizedBox(height: 24),
                    _buildCancelButton(context),
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
          child: Row(
            children: [
              const Icon(
                Icons.chat_bubble_outline,
                color: RoColors.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Need help? Chat with Support',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: RoColors.subText,
                size: 14,
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
          "Track Complaint",
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
            Icons.location_on_outlined,
            color: RoColors.primaryBlue,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineStep(
          title: 'Submitted',
          time: 'Oct 24, 10:30 AM',
          isActive: true,
          icon: Icons.check,
          isLast: false,
        ),
        _buildTimelineStep(
          title: 'Under Review',
          time: 'Oct 24, 11:15 AM',
          isActive: true,
          icon: Icons.check,
          isLast: false,
        ),
        _buildTimelineStep(
          title: 'Technician Dispatched',
          time: 'Expected by 12:45 PM',
          isActive: true,
          icon: Icons.engineering_outlined,
          isHighlighted: true,
          isLast: false,
        ),
        _buildTimelineStep(
          title: 'Resolved',
          time: 'Pending arrival',
          isActive: false,
          icon: Icons.check,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String time,
    required bool isActive,
    required IconData icon,
    required bool isLast,
    bool isHighlighted = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Indicator column
          Column(
            children: [
              _buildTimelineCircle(isActive, icon),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isActive
                        ? RoColors.primaryBlue
                        : const Color(0xFFE2E8F0),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Content column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive
                        ? RoColors.darkText
                        : RoColors.subText.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: isHighlighted
                        ? RoColors.primaryBlue
                        : isActive
                        ? RoColors.subText
                        : RoColors.subText.withOpacity(0.3),
                    letterSpacing: 0.5,
                  ),
                ),
                if (!isLast) const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCircle(bool isActive, IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isActive ? RoColors.primaryBlue : const Color(0xFFF8FAFC),
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? RoColors.primaryBlue : const Color(0xFFE2E8F0),
          width: 2,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: RoColors.primaryBlue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : const Color(0xFFCBD5E1),
        size: 20,
      ),
    );
  }

  Widget _buildTechnicianCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8BCB3),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Arul',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFB300), size: 14),
                    const SizedBox(width: 4),
                    const Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: RoColors.darkText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'ROWATER SPECIALIST',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: RoColors.subText.withOpacity(0.7),
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: RoColors.statusActive,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.phone_outlined,
              color: RoColors.primaryBlue,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _showCancelDialog(context),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          side: const BorderSide(color: Color(0xFFFF5252), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: const Color(0xFFFFEBEE).withOpacity(0.3),
        ),
        child: const Text(
          'CANCEL BOOKING',
          style: TextStyle(
            color: Color(0xFFFF5252),
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBEE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFFF5252),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Cancel Booking?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: RoColors.darkText,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Are you sure you want to cancel this service appointment? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: RoColors.subText,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Keep It',
                          style: TextStyle(
                            color: RoColors.subText,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Booking cancelled successfully',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: const Color(0xFFFF5252),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5252),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Yes, Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
