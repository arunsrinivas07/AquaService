import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String time;
  final bool unread;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.time,
    this.unread = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: w * 0.03),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          CircleAvatar(
            radius: w * 0.06,
            backgroundColor: iconBg.withOpacity(0.15),
            child: Icon(icon, color: iconBg, size: w * 0.06),
          ),

          SizedBox(width: w * 0.03),

          /// CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: w * 0.03, color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(height: w * 0.015),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: w * 0.034, color: Colors.grey),
                ),
              ],
            ),
          ),

          if (unread)
            Padding(
              padding: EdgeInsets.only(left: w * 0.02, top: w * 0.01),
              child: Container(
                width: w * 0.02,
                height: w * 0.02,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
