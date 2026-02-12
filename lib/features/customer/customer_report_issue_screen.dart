import 'package:flutter/material.dart';
import 'package:ro_water/features/customer/customer_home_screen.dart';
import 'package:ro_water/features/customer/customer_service_history_screen.dart';
import 'package:ro_water/features/customer/customer_profile_settings_screen.dart';
import 'package:ro_water/features/customer/customer_track_complaint_screen.dart';

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

class CustomerReportIssueScreen extends StatefulWidget {
  const CustomerReportIssueScreen({super.key});

  @override
  State<CustomerReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<CustomerReportIssueScreen> {
  String selectedCategory = 'Leakage';
  final TextEditingController _descriptionController = TextEditingController();
  bool hasVoiceNote = true;
  int _selectedNavIndex = 2;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;

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
                    const Text(
                      'ISSUE CATEGORY',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: RoColors.subText,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryChip('Leakage'),
                          const SizedBox(width: 12),
                          _buildCategoryChip('Noise'),
                          const SizedBox(width: 12),
                          _buildCategoryChip('Quality'),
                          const SizedBox(width: 12),
                          _buildCategoryChip('Billing'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'DESCRIBE THE PROBLEM',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: RoColors.subText,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Max 500 words',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: RoColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: RoColors.cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: null,
                            maxLength: 500,
                            decoration: const InputDecoration(
                              hintText:
                                  'Tell us more about what\'s happening...',
                              hintStyle: TextStyle(
                                color: Color(0xFFCBD5E1),
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                              color: RoColors.darkText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          bottom: 12,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: RoColors.primaryBlue,
                            mini: true,
                            elevation: 4,
                            child: const Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    if (hasVoiceNote) _buildVoiceNotePlayer(h),
                    const SizedBox(height: 16),
                    _buildAttachPhotosButton(),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CustomerTrackComplaintScreen(),
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SUBMIT COMPLAINT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.1,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
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
          "Report an Issue",
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
            Icons.headset_mic_outlined,
            color: RoColors.primaryBlue,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? RoColors.primaryBlue : RoColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? RoColors.primaryBlue : const Color(0xFFF1F5F9),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: isSelected ? Colors.white : RoColors.subText,
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceNotePlayer(double h) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: RoColors.statusActive,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              color: RoColors.primaryBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    20,
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        height: (index % 3 == 0)
                            ? 20
                            : (index % 2 == 0)
                            ? 14
                            : 10,
                        decoration: BoxDecoration(
                          color: index < 6
                              ? RoColors.primaryBlue
                              : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0:12 / 0:12',
                      style: TextStyle(
                        fontSize: 11,
                        color: RoColors.subText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Voice note recorded',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 11,
                          color: RoColors.primaryBlue,
                          fontWeight: FontWeight.w900,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Color(0xFFFF5252),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachPhotosButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: RoColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: RoColors.primaryBlue,
          width: 1.5,
          style: BorderStyle.solid,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            color: RoColors.primaryBlue,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            'ATTACH PHOTOS (OPTIONAL)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: RoColors.primaryBlue,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, "HOME", 0),
          _buildNavItem(Icons.receipt_long, "HISTORY", 1),
          _buildNavItem(Icons.headset_mic, "SUPPORT", 2),
          _buildNavItem(Icons.person, "PROFILE", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedNavIndex == index;
    return InkWell(
      onTap: () {
        setState(() => _selectedNavIndex = index);
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomerServiceHistoryScreen(),
            ),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomerProfileSettingsScreen(),
            ),
          );
        }
      },
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? RoColors.primaryBlue : RoColors.subText,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? RoColors.primaryBlue : RoColors.subText,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
