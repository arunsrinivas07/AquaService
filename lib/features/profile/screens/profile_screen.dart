import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login/screens/login_screen.dart';
import '../../login/providers/auth_provider.dart';
import '../../status/screens/status_screen.dart';
import '../providers/customer_provider.dart';
import '../models/customer_model.dart';
import 'edit_profile_screen.dart';
import 'machine_payments_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPref();
  }

  Future<void> _loadNotificationPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    setState(() {
      _notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerAsync = ref.watch(customerProvider);

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
      body: customerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (customer) {
          final name = customer?.name ?? 'User';
          final phone = customer?.phoneNumber ?? '';
          final email = customer?.email ?? '';
          final address = customer?.address ?? '';
          final docId = customer?.docId ?? '';
          final userId = docId.length > 6
              ? '#${docId.substring(0, 6)}'
              : '#$docId';
          final machines = customer?.machineDetails ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                _buildProfileCard(
                  context,
                  customer,
                  name,
                  userId,
                  phone,
                  email,
                  address,
                ),
                const SizedBox(height: 16),

                // Machine and Payments
                _buildSingleItemCard(
                  icon: Icons.point_of_sale_outlined,
                  iconColor: const Color(0xFF4DD9E0),
                  label: 'Machine and Payments',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MachinePaymentsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Account Overview section
                _buildSectionLabel('Account Overview'),
                const SizedBox(height: 8),
                _buildExpandableGroupCard(items: [
                  _ExpandableMenuItem(
                    icon: Icons.location_on_outlined,
                    iconColor: const Color(0xFF4DD9E0),
                    label: 'My Addresses',
                    expandedContent: address.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(52, 0, 16, 14),
                            child: Text(
                              address,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black87),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.fromLTRB(52, 0, 16, 14),
                            child: Text(
                              'No address on file.',
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                  ),
                  _ExpandableMenuItem(
                    icon: Icons.phone_android_outlined,
                    iconColor: const Color(0xFF4DD9E0),
                    label: 'My Devices',
                    expandedContent: machines.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.fromLTRB(52, 0, 16, 14),
                            child: Text(
                              'No devices registered.',
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(52, 0, 16, 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: machines
                                  .map(
                                    (m) => Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.circle,
                                              size: 6,
                                              color: Color(0xFF4DD9E0)),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              m.model.isNotEmpty
                                                  ? m.model
                                                  : m.machineType,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: m.isActive
                                                  ? Colors.green
                                                      .withValues(alpha: 0.12)
                                                  : Colors.red
                                                      .withValues(alpha: 0.12),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              m.statusLabel,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: m.isActive
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                  ),
                ]),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StatusScreen(),
                          ),
                        );
                      },
                    ),
                    _MenuItem(
                      icon: Icons.credit_card_outlined,
                      iconColor: const Color(0xFF4DD9E0),
                      label: 'Payment History',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MachinePaymentsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Support & Settings section
                _buildSectionLabel('Support & Settings'),
                const SizedBox(height: 8),
                _buildMixedGroupCard(
                  regularItems: [
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
                  ],
                  expandableItems: [
                    _ExpandableMenuItem(
                      icon: Icons.notifications_none_outlined,
                      iconColor: const Color(0xFFFF6B6B),
                      label: 'Notifications',
                      expandedContent: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Row(
                          children: [
                            const Icon(Icons.circle, size: 6, color: Colors.grey),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Enable push notifications',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            ),
                            Switch(
                              value: _notificationsEnabled,
                              onChanged: _toggleNotifications,
                              activeColor: const Color(0xFF4DD9E0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _ExpandableMenuItem(
                      icon: Icons.shield_outlined,
                      iconColor: Colors.black87,
                      label: 'Privacy & Policy',
                      expandedContent: const Padding(
                        padding: EdgeInsets.fromLTRB(52, 0, 16, 14),
                        child: Text(
                          'Privacy policy details coming soon.',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Log Out Button
                _buildLogOutButton(context, ref),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    CustomerModel? customer,
    String name,
    String userId,
    String phone,
    String email,
    String address,
  ) {
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
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    width: 3,
                  ),
                ),
                child: FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    String? localPic;
                    if (snapshot.hasData) {
                      localPic = snapshot.data!.getString('profile_pic_$phone');
                    }
                    return ClipOval(
                      child: localPic != null && File(localPic).existsSync()
                          ? Image.file(File(localPic), fit: BoxFit.cover)
                          : Image.asset(
                              'assets/images/avatar.jpeg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.purple.shade900,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Name and ID
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID : $userId',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
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
                      child: Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Email and Address
          if (email.isNotEmpty) ...[
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  email,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
          if (address.isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    address,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
          const SizedBox(height: 8),
          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: customer == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(customer: customer),
                        ),
                      );
                    },
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
                const Divider(
                  height: 1,
                  thickness: 0.8,
                  color: Colors.white,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }

  /// A group card that supports expandable items
  Widget _buildExpandableGroupCard(
      {required List<_ExpandableMenuItem> items}) {
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
              Theme(
                data: ThemeData(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: Icon(item.icon, color: item.iconColor, size: 22),
                  title: Text(
                    item.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  iconColor: Colors.black54,
                  collapsedIconColor: Colors.black54,
                  tilePadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 0),
                  childrenPadding: EdgeInsets.zero,
                  children: [item.expandedContent],
                ),
              ),
              if (!isLast)
                const Divider(
                  height: 1,
                  thickness: 0.8,
                  color: Colors.white,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }

  /// A group card that mixes regular tappable items with expandable items
  Widget _buildMixedGroupCard({
    required List<_MenuItem> regularItems,
    required List<_ExpandableMenuItem> expandableItems,
  }) {
    final allCount = regularItems.length + expandableItems.length;
    int itemIndex = 0;

    Widget buildDivider() => const Divider(
          height: 1,
          thickness: 0.8,
          color: Colors.white,
          indent: 16,
          endIndent: 16,
        );

    final widgets = <Widget>[];

    for (int i = 0; i < regularItems.length; i++) {
      final item = regularItems[i];
      widgets.add(ListTile(
        onTap: item.onTap,
        leading: Icon(item.icon, color: item.iconColor, size: 22),
        title: Text(
          item.label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ));
      itemIndex++;
      if (itemIndex < allCount) widgets.add(buildDivider());
    }

    for (int i = 0; i < expandableItems.length; i++) {
      final item = expandableItems[i];
      widgets.add(Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(item.icon, color: item.iconColor, size: 22),
          title: Text(
            item.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          iconColor: Colors.black54,
          collapsedIconColor: Colors.black54,
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: EdgeInsets.zero,
          children: [item.expandedContent],
        ),
      ));
      itemIndex++;
      if (itemIndex < allCount) widgets.add(buildDivider());
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDFF4F7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: widgets),
    );
  }

  Widget _buildLogOutButton(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: () {
            ref.read(authProvider.notifier).logout();
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

class _ExpandableMenuItem {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Widget expandedContent;

  const _ExpandableMenuItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.expandedContent,
  });
}
