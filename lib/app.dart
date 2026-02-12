import 'package:flutter/material.dart';
import 'package:ro_water/features/auth/splash_screen.dart';

class RoWaterApp extends StatelessWidget {
  const RoWaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aqua Service',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan, useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}
