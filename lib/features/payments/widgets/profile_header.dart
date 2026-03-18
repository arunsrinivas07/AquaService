import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login/providers/auth_provider.dart';
import '../../profile/screens/profile_screen.dart';
import '../../notifications/screens/notifications_screen.dart';

class ProfileHeader extends ConsumerWidget {
  final String name;
  final String userId;
  final String avatarUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.userId,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.deepPurple.shade100,
              child: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  final authState = ref.read(authProvider);
                  final phone = authState.loggedInPhone ?? '';
                  String? localPic;
                  if (snapshot.hasData && phone.isNotEmpty) {
                    localPic = snapshot.data!.getString('profile_pic_$phone');
                  }
                  return ClipOval(
                    child: localPic != null && File(localPic).existsSync()
                        ? Image.file(
                            File(localPic),
                            fit: BoxFit.cover,
                            width: 48,
                            height: 48,
                          )
                        : Image.asset(
                            'assets/images/avatar.jpeg',
                            fit: BoxFit.cover,
                            width: 48,
                            height: 48,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.person, color: Colors.deepPurple),
                          ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'ID : $userId',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.black87,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
