import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6F6),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 20),
                  _buildSectionHeader('TODAY'),
                  const SizedBox(height: 12),
                  _buildNotificationItem(
                    icon: Icons.settings_backup_restore,
                    iconColor: Colors.blue,
                    title: 'Filter Change Due',
                    description:
                        'Your AquaPur system filter needs a replacement to maintain optimal water quality.',
                    time: '2H AGO',
                    showDot: true,
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    icon: Icons.local_offer_outlined,
                    iconColor: Colors.lightBlue,
                    title: 'Summer Discount: 20% Off',
                    description:
                        'Get 20% off on all annual maintenance plans this week! Limited time offer.',
                    time: '5H AGO',
                  ),
                  const SizedBox(height: 30),
                  _buildSectionHeader('YESTERDAY'),
                  const SizedBox(height: 12),
                  _buildNotificationItem(
                    icon: Icons.water_drop_outlined,
                    iconColor: Colors.teal,
                    title: 'Water Quality Alert',
                    description:
                        'TDS levels are slightly higher than usual. Consider a quick system flush.',
                    time: '1D AGO',
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    icon: Icons.verified_outlined,
                    iconColor: Colors.grey,
                    title: 'Service Completed',
                    description:
                        'Your maintenance appointment was successfully completed. Rate your experience!',
                    time: '1D AGO',
                  ),
                  const SizedBox(height: 40),
                  _buildCaughtUpSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
          const Icon(
            Icons.notifications_active_outlined,
            color: Color(0xFF00BCD4),
            size: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Clear All',
              style: TextStyle(
                color: Color(0xFF00BCD4),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
    bool showDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: iconColor),
              ),
              if (showDot)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00BCD4),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue[300],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaughtUpSection() {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.done_all, color: Colors.blue, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          "You're all caught up!",
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
