import 'package:flutter/material.dart';
import 'package:ro_water/features/customer/customer_schedule_service_screen.dart';

class RoColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF00BCD4);
  static const Color darkText = Color(0xFF212121);
  static const Color subText = Color(0xFF757575);
  static const Color cardBg = Colors.white;

  // Status Colors
  static const Color statusActive = Color(0xFFE0F7FA);
  static const Color statusActiveText = Color(0xFF00BCD4);
}

class CustomerMachineDetailsScreen extends StatelessWidget {
  const CustomerMachineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: RoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// SCROLLABLE HEADER (MATCHING ADMIN STYLE)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _buildScrollableHeader(context),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: w * 0.5,
                      height: w * 0.5,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: RoColors.statusActive,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://www.pngmart.com/files/6/Kent-RO-Water-Purifier-PNG-Image.png',
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                                color: RoColors.primaryBlue,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.water_damage_outlined,
                            size: 48,
                            color: RoColors.primaryBlue.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            'RoWater Ultra Max',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: RoColors.darkText,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'SN: RW-9920-X12',
                      style: TextStyle(
                        fontSize: 14,
                        color: RoColors.subText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'ACTIVE STATUS',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildFilterHealthCard(w, h),
                    const SizedBox(height: 24),
                    _buildInstallationDetailsCard(w, h),
                    const SizedBox(height: 24),
                    _buildLastServiceCard(w, h),
                    const SizedBox(height: 24),
                    _buildTechnicalSpecsCard(w, h),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CustomerScheduleServiceScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: RoColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'BOOK MAINTENANCE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            color: RoColors.subText,
                          ),
                          children: [
                            const TextSpan(text: 'Need help? '),
                            const TextSpan(
                              text: 'Contact Support',
                              style: TextStyle(
                                color: RoColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  ' for technical assistance with your RoWater Ultra Max.',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
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
          "Machine Details",
          style: TextStyle(
            color: RoColors.darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(Icons.more_horiz, color: RoColors.darkText, size: 20),
        ),
      ],
    );
  }

  Widget _buildFilterHealthCard(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FILTER HEALTH',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: RoColors.darkText,
                  letterSpacing: 1.1,
                ),
              ),
              Icon(Icons.water_drop, color: RoColors.primaryBlue, size: 24),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Life Remaining',
                style: TextStyle(
                  fontSize: 14,
                  color: RoColors.subText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '75%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: RoColors.darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.75,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: const AlwaysStoppedAnimation<Color>(
              RoColors.primaryBlue,
            ),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: RoColors.subText),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Estimated change needed in 3 months (Aug 2024)',
                  style: TextStyle(
                    fontSize: 12,
                    color: RoColors.subText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstallationDetailsCard(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.tune, color: RoColors.subText, size: 20),
              const SizedBox(width: 8),
              const Text(
                'INSTALLATION DETAILS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: RoColors.darkText,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDetailRow('Install Date', 'Oct 12, 2023'),
          _buildDivider(),
          _buildDetailRow('Location', 'Main Kitchen, Area 2'),
          _buildDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Technician',
                style: TextStyle(
                  fontSize: 14,
                  color: RoColors.subText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: RoColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastServiceCard(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.history, color: RoColors.subText, size: 20),
              const SizedBox(width: 8),
              const Text(
                'LAST SERVICE SUMMARY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: RoColors.darkText,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Routine Maintenance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: RoColors.darkText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Jan 15, 2024',
                style: TextStyle(
                  fontSize: 12,
                  color: RoColors.subText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Periodic check and internal sanitation completed successfully.',
            style: TextStyle(
              fontSize: 13,
              color: RoColors.subText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'REPLACED PARTS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: RoColors.subText,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPartRow('Carbon Block Filter'),
                const SizedBox(height: 12),
                _buildPartRow('Sediment Filter (Pre-RO)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalSpecsCard(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: RoColors.subText, size: 20),
              const SizedBox(width: 8),
              const Text(
                'TECHNICAL SPECS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: RoColors.darkText,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildSpecItem('CAPACITY', '15 Liters'),
              _buildSpecItem('STAGES', '7 Stage RO+UV'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: RoColors.subText,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: RoColors.darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: RoColors.subText,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: RoColors.darkText,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPartRow(String part) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: RoColors.primaryBlue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            part,
            style: const TextStyle(
              fontSize: 13,
              color: RoColors.darkText,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 1, color: Color(0xFFF1F5F9)),
    );
  }
}
