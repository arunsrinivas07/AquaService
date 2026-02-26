import 'dart:async';
import 'package:flutter/material.dart';
import '../../login/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Animation for the main logo fade-in
  late Animation<double> _opacityAnimation;

  // Animation for the main logo scale-in
  late Animation<double> _scaleAnimation;

  // Animation for the subtle floating 'water flow' motion
  late Animation<Offset> _floatAnimation;

  // Animation for the final droplet 'bounce' effect
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Define the controller with a total duration of 2.5 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. Logo Entry: Fade-in and Scale-in
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    // 2. Wave Feel: Subtle upward float effect
    _floatAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.02), // Start slightly below
          end: Offset.zero, // End in normal position
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 0.7, curve: Curves.easeInOut),
          ),
        );

    // 3. Water Drop Animation: Slight bounce
    _bounceAnimation =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(begin: 1.0, end: 1.1),
            weight: 1,
          ), // scale up
          TweenSequenceItem(
            tween: Tween(begin: 1.1, end: 0.95),
            weight: 1,
          ), // scale down past normal
          TweenSequenceItem(
            tween: Tween(begin: 0.95, end: 1.0),
            weight: 1,
          ), // settle at normal
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
          ),
        );

    // Start the complete animation sequence
    _controller.forward();

    // Set a timer for the total sequence duration (2.5s) + the hold duration (0.5s)
    Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate logo size based on screen width, with a max and min
          double logoWidth = constraints.maxWidth * 0.7;
          if (logoWidth > 450) logoWidth = 450;
          if (logoWidth < 150) logoWidth = 150;

          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SlideTransition(
                position: _floatAnimation,
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Base logo layer
                        Image.asset(
                          'assets/images/logo_base.png',
                          width: logoWidth,
                          fit: BoxFit.contain,
                        ),
                        // Positioned and animated droplet
                        Positioned.fill(
                          child: Align(
                            alignment: const FractionalOffset(0.67, 0.52),
                            child: ScaleTransition(
                              scale: _bounceAnimation,
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                'assets/images/logo_droplet.png',
                                width: logoWidth * 0.10,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
