import 'package:flutter/material.dart';

class BookingSuccessPopup extends StatefulWidget {
  const BookingSuccessPopup({super.key});

  @override
  State<BookingSuccessPopup> createState() => _BookingSuccessPopupState();

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const BookingSuccessPopup(),
    );
  }
}

class _BookingSuccessPopupState extends State<BookingSuccessPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    // Auto-close after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: TickPainter(progress: _animation.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Service Booked Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TickPainter extends CustomPainter {
  final double progress;

  TickPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw Circle
    canvas.drawCircle(center, radius - 3, paint);

    if (progress > 0) {
      final path = Path();

      // Starting point of the tick
      final start = Offset(size.width * 0.25, size.height * 0.5);
      final mid = Offset(size.width * 0.45, size.height * 0.7);
      final end = Offset(size.width * 0.75, size.height * 0.3);

      path.moveTo(start.dx, start.dy);

      if (progress < 0.5) {
        // Draw the first part of the tick
        final currentProgress = progress / 0.5;
        path.lineTo(
          start.dx + (mid.dx - start.dx) * currentProgress,
          start.dy + (mid.dy - start.dy) * currentProgress,
        );
      } else {
        // Draw the full first part and the second part
        path.lineTo(mid.dx, mid.dy);
        final currentProgress = (progress - 0.5) / 0.5;
        path.lineTo(
          mid.dx + (end.dx - mid.dx) * currentProgress,
          mid.dy + (end.dy - mid.dy) * currentProgress,
        );
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant TickPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
