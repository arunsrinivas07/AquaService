import 'package:flutter/material.dart';
import 'select_payment_screen.dart';

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;
}

class PaymentOverviewScreen extends StatelessWidget {
  const PaymentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildScrollableHeader(context),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildTotalDueCard(),
                    const SizedBox(height: 32),
                    _buildSectionHeader(
                      'UPCOMING INSTALLMENTS',
                      'See Schedule',
                    ),
                    const SizedBox(height: 12),
                    _buildInstallmentList(),
                    const SizedBox(height: 32),
                    const Text(
                      'PAYMENT HISTORY',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: RoColors.subText,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildHistoryItem(
                      'Monthly Installment',
                      'Sept 25, 2023 • 10:45 AM',
                      '\$40.00',
                    ),
                    _buildHistoryItem(
                      'Initial Setup Fee',
                      'Aug 25, 2023 • 09:12 AM',
                      '\$40.00',
                    ),
                    _buildHistoryItem(
                      'Account Activation',
                      'July 25, 2023 • 03:30 PM',
                      '\$25.00',
                    ),
                    const SizedBox(height: 100), // Padding for button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildPayButton(context),
    );
  }

  Widget _buildScrollableHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: RoColors.darkText,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          "Payment Overview",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(
            Icons.history_outlined,
            color: RoColors.primaryBlue,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalDueCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL AMOUNT DUE',
                style: TextStyle(
                  color: RoColors.subText,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1.1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'OVERDUE',
                  style: TextStyle(
                    color: Color(0xFFFF5252),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '\$120.50',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: RoColors.darkText,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: RoColors.subText,
              ),
              const SizedBox(width: 8),
              Text(
                'Due Date: Oct 25, 2023',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: RoColors.darkText.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstallmentList() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _installmentCard(
            '\$40.00',
            'Due Nov 25',
            Icons.access_time_filled,
            const Color(0xFF00BCD4),
            0.4,
          ),
          _installmentCard(
            '\$40.00',
            'Due Dec 25',
            Icons.hourglass_empty_rounded,
            const Color(0xFFCBD5E1),
            0.0,
          ),
        ],
      ),
    );
  }

  Widget _installmentCard(
    String amt,
    String date,
    IconData icon,
    Color color,
    double progress,
  ) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const Spacer(),
          Text(
            amt,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: RoColors.darkText,
            ),
          ),
          Text(
            date,
            style: const TextStyle(
              color: RoColors.subText,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF1F5F9),
              color: RoColors.primaryBlue,
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String subtitle, String amt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF4CAF50),
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: RoColors.darkText,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: RoColors.subText,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amt,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  color: RoColors.darkText,
                ),
              ),
              const Text(
                'SUCCESS',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: RoColors.subText,
            letterSpacing: 1.1,
          ),
        ),
        Text(
          action.toUpperCase(),
          style: const TextStyle(
            color: RoColors.primaryBlue,
            fontWeight: FontWeight.w900,
            fontSize: 11,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectPaymentMethodScreen(),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: RoColors.primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.payments_outlined, size: 20),
            SizedBox(width: 12),
            Text(
              'Pay Now - \$120.50',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
