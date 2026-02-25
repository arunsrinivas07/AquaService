import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.deepPurple.shade100,
            child: ClipOval(
              child: Image.network(
                avatarUrl,
                fit: BoxFit.cover,
                width: 48,
                height: 48,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, color: Colors.deepPurple),
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
        ],
      ),
    );
  }
}
