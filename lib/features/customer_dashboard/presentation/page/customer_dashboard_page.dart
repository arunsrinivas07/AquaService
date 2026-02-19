// lib/features/customer_dashboard/presentation/page/customer_dashboard_page.dart

import 'package:flutter/material.dart';
import '../widgets/header_section.dart';
import '../widgets/tds_card.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/payment_card.dart';
import '../widgets/service_card.dart';
import '../widgets/bottom_nav_bar.dart';

class CustomerDashboardPage extends StatelessWidget {
  const CustomerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFEEF6F8),
              Color(0xFFE8EAF6),
              Color(0xFFEEF6F8),
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const HeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: const [
                      SizedBox(height: 8),
                      TdsCard(),
                      SizedBox(height: 24),
                      QuickActionsSection(),
                      SizedBox(height: 20),
                      PaymentCard(),
                      SizedBox(height: 16),
                      ServiceCard(),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              const DashboardBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}