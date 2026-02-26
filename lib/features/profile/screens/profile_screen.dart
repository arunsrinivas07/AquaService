import 'package:flutter/material.dart';

import '../../login/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PROFILE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            _buildProfileCard(context),
            const SizedBox(height: 16),

            // Machine and Payments
            _buildSingleItemCard(
              icon: Icons.point_of_sale_outlined,
              iconColor: const Color(0xFF4DD9E0),
              label: 'Machine and Payments',
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Account Overview section
            _buildSectionLabel('Account Overview'),
            const SizedBox(height: 8),
            _buildGroupCard(
              items: [
                _MenuItem(
                  icon: Icons.location_on_outlined,
                  iconColor: const Color(0xFF4DD9E0),
                  label: 'My addresses',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.phone_android_outlined,
                  iconColor: const Color(0xFF4DD9E0),
                  label: 'My Devices',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // History section
            _buildSectionLabel('History'),
            const SizedBox(height: 8),
            _buildGroupCard(
              items: [
                _MenuItem(
                  icon: Icons.build_outlined,
                  iconColor: const Color(0xFF4DD9E0),
                  label: 'Service History',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.credit_card_outlined,
                  iconColor: const Color(0xFF4DD9E0),
                  label: 'Payment History',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Support & Settings section
            _buildSectionLabel('Support & Settings'),
            const SizedBox(height: 8),
            _buildGroupCard(
              items: [
                _MenuItem(
                  icon: Icons.headset_mic_outlined,
                  iconColor: const Color(0xFF4DD9E0),
                  label: 'Support Center',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.language_outlined,
                  iconColor: const Color(0xFF4DD9E0),
                  label: 'Language',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.notifications_none_outlined,
                  iconColor: const Color(0xFFFF6B6B),
                  label: 'Notifications',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.shield_outlined,
                  iconColor: Colors.black87,
                  label: 'Privacy & Policy',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Log Out Button
            _buildLogOutButton(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF4F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/avatar.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.purple.shade900,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Name and ID
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VIZNU',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ID : #123456-A',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '6374334250',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB2EBF2),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleItemCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDFF4F7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor, size: 24),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildGroupCard({required List<_MenuItem> items}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDFF4F7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Column(
            children: [
              ListTile(
                onTap: item.onTap,
                leading: Icon(item.icon, color: item.iconColor, size: 22),
                title: Text(
                  item.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 0.8,
                  color: Colors.grey.shade300,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLogOutButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout, color: Color(0xFFE53935), size: 20),
          label: const Text(
            'Log Out',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });
}
