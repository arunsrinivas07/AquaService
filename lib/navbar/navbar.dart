import 'package:flutter/material.dart';

class CustomCurvedNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomCurvedNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomCurvedNavigationBar> createState() => _CustomCurvedNavigationBarState();
}

class _CustomCurvedNavigationBarState extends State<CustomCurvedNavigationBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double itemWidth = width / 4;

    return Container(
      height: 90, 
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Painter
          CustomPaint(
            size: Size(width, 90),
            painter: NavPainter(selectedIndex: widget.currentIndex),
          ),

          // Animated Selection Circle - 62px diameter
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            left: (widget.currentIndex * itemWidth) + (itemWidth / 2) - 31,
            top: -20, 
            child: Container(
              width: 62, 
              height: 62,
              decoration: BoxDecoration(
                color: const Color(0xFF8ED6F5),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8ED6F5).withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  _getIcon(widget.currentIndex),
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),

          // Navigation Labels and inactive icons
          Positioned.fill(
            child: Row(
              children: [
                _buildNavItem(0, Icons.manage_accounts, "PROFILE"),
                _buildNavItem(1, Icons.account_balance_wallet, "CASH"),
                _buildNavItem(2, Icons.home, "HOME"),
                _buildNavItem(3, Icons.person_pin, "STATUS"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0: return Icons.manage_accounts;
      case 1: return Icons.account_balance_wallet;
      case 2: return Icons.home_outlined;
      case 3: return Icons.person_pin;
      default: return Icons.home;
    }
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = widget.currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 32,
              child: isSelected 
                ? const SizedBox.shrink() 
                : Icon(
                    icon,
                    color: const Color(0xFF0F172A),
                    size: 26,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              isSelected ? label : "",
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1.5,
                fontFamily: 'Roboto', 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavPainter extends CustomPainter {
  final int selectedIndex;

  NavPainter({required this.selectedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFF1FAFF)
      ..style = PaintingStyle.fill;

    double itemWidth = size.width / 4;
    double centerX = (selectedIndex * itemWidth) + (itemWidth / 2);

    Path path = Path();
    
    path.moveTo(0, 20); 
    path.quadraticBezierTo(0, 0, 20, 0); 
    
    // Wider start to create horizontal gap
    path.lineTo(centerX - 70, 0);

    // Deeper and smoother cubic Bézier for the "airy" gap
    path.cubicTo(
      centerX - 45, 0,
      centerX - 40, 38, // Slightly deeper for vertical gap
      centerX, 38,
    );
    path.cubicTo(
      centerX + 40, 38,
      centerX + 45, 0,
      centerX + 70, 0,
    );

    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20); 
    
    path.lineTo(size.width, size.height - 25);
    path.quadraticBezierTo(size.width, size.height, size.width - 25, size.height); 
    path.lineTo(25, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 25); 
    
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant NavPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}
