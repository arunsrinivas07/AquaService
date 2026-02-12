import 'package:flutter/material.dart';

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;

  // Status Colors
  static const Color statusOverdue = Color(0xFFFFEBEE);
  static const Color statusOverdueText = Color(0xFFFF5252);
  static const Color statusPending = Color(0xFFFFF3E0);
  static const Color statusPendingText = Color(0xFFFF9800);
  static const Color statusPaid = Color(0xFFE8F5E9);
  static const Color statusPaidText = Color(0xFF4CAF50);
}

class PaymentDuesScreen extends StatefulWidget {
  const PaymentDuesScreen({super.key});

  @override
  State<PaymentDuesScreen> createState() => _PaymentDuesScreenState();
}

class _PaymentDuesScreenState extends State<PaymentDuesScreen> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> payments = [
    {
      'name': 'Michael Henderson',
      'id': '#RW-7210',
      'amount': '\$185.50',
      'status': 'OVERDUE',
      'dueInfo': '12 Days Past',
      'plan': 'Premium Annual Plan',
      'hasAction': true,
    },
    {
      'name': 'Sarah Smith',
      'id': '#RW-9042',
      'amount': '\$45.00',
      'status': 'PENDING',
      'dueInfo': 'Due tomorrow',
      'plan': 'Standard Monthly',
      'hasAction': false,
    },
    {
      'name': 'John Doe',
      'id': '#RW-8821',
      'amount': '\$120.00',
      'status': 'PAID',
      'dueInfo': '3 days ago',
      'plan': 'Premium Annual',
      'hasAction': false,
    },
    {
      'name': 'Linda Garrison',
      'id': '#RW-4532',
      'amount': '\$29.90',
      'status': 'PAID',
      'dueInfo': 'Today',
      'plan': 'Starter Plan',
      'hasAction': false,
    },
    {
      'name': 'Robert Chen',
      'id': '#RW-5501',
      'amount': '\$450.00',
      'status': 'OVERDUE',
      'dueInfo': '21 Days Past',
      'plan': 'Business Pro',
      'hasAction': true,
    },
  ];

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
            _buildSearchAndFilters(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  return _buildPaymentCard(payments[index]);
                },
              ),
            ),
          ],
        ),
      ),
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
          "Payment & Dues",
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
            Icons.account_balance_wallet_outlined,
            color: RoColors.primaryBlue,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: RoColors.subText, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Search Customer Name or ID',
                    style: TextStyle(fontSize: 14, color: RoColors.subText),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Paid'),
                const SizedBox(width: 8),
                _buildFilterChip('Pending'),
                const SizedBox(width: 8),
                _buildFilterChip('Overdue'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? RoColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? RoColors.primaryBlue : const Color(0xFFF1F5F9),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : RoColors.subText,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    final status = payment['status'];
    final isOverdue = status == 'OVERDUE';
    final isPaid = status == 'PAID';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOverdue
              ? RoColors.statusOverdueText.withOpacity(0.3)
              : const Color(0xFFF1F5F9),
          width: isOverdue ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusBgColor(status),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: _getStatusColor(status),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'ID: ${payment['id']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: RoColors.subText,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          payment['amount'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: RoColors.darkText,
                          ),
                        ),
                        Text(
                          payment['dueInfo'].toUpperCase(),
                          style: TextStyle(
                            fontSize: 9,
                            color: isOverdue
                                ? RoColors.statusOverdueText
                                : isPaid
                                ? RoColors.statusPaidText
                                : RoColors.statusPendingText,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  payment['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: RoColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  payment['plan'].toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: RoColors.primaryBlue,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                if (payment['hasAction']) ...[
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            size: 18,
                          ),
                          label: const Text(
                            'SEND REMINDER',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: RoColors.primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFF1F5F9)),
                        ),
                        child: const Icon(
                          Icons.phone_outlined,
                          color: RoColors.darkText,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'OVERDUE':
        return RoColors.statusOverdueText;
      case 'PENDING':
        return RoColors.statusPendingText;
      case 'PAID':
        return RoColors.statusPaidText;
      default:
        return RoColors.subText;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'OVERDUE':
        return RoColors.statusOverdue;
      case 'PENDING':
        return RoColors.statusPending;
      case 'PAID':
        return RoColors.statusPaid;
      default:
        return const Color(0xFFF8FAFC);
    }
  }
}
