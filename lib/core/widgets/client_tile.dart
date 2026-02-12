import 'package:flutter/material.dart';

class CustomerTile extends StatelessWidget {
  final String name;
  final String id;
  final String status;
  final String initials;
  final Color avatarColor;
  final bool hasAvatar;
  final VoidCallback? onTap;

  const CustomerTile({
    super.key,
    required this.name,
    required this.id,
    required this.status,
    required this.initials,
    required this.avatarColor,
    this.hasAvatar = false,
    this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ACTIVE':
        return const Color(0xFF4CAF50);
      case 'SERVICE DUE':
        return const Color(0xFFFF9800);
      case 'PAYMENT DUE':
        return const Color(0xFFFF5252);
      case 'INACTIVE':
        return const Color(0xFF9E9E9E);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'ACTIVE':
        return const Color(0xFFE8F5E9);
      case 'SERVICE DUE':
        return const Color(0xFFFFF3E0);
      case 'PAYMENT DUE':
        return const Color(0xFFFFEBEE);
      case 'INACTIVE':
        return const Color(0xFFF5F5F5);
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: h * 0.015),
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.025),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            _buildAvatar(w),

            SizedBox(width: w * 0.035),

            // Name and ID
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: h * 0.003),
                  Text(
                    id,
                    style: TextStyle(
                      fontSize: w * 0.033,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Status Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.025,
                vertical: h * 0.006,
              ),
              decoration: BoxDecoration(
                color: _getStatusBackgroundColor(status),
                borderRadius: BorderRadius.circular(w * 0.01),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: w * 0.028,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(status),
                ),
              ),
            ),

            SizedBox(width: w * 0.02),

            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: w * 0.06,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(double width) {
    return Container(
      width: width * 0.12,
      height: width * 0.12,
      decoration: BoxDecoration(shape: BoxShape.circle, color: avatarColor),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * (hasAvatar ? 0.04 : 0.045),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
