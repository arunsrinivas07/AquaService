import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../profile/screens/profile_screen.dart';
import '../../../shared/widgets/booking_success_popup.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_chip.dart';

import '../../payments/providers/payment_provider.dart';
import '../../profile/providers/customer_provider.dart';
import '../../login/providers/auth_provider.dart';
import '../../../core/services/firestore_service.dart';
import '../models/service_model.dart';
import '../providers/service_provider.dart';
import '../providers/maintenance_provider.dart';
import '../widgets/estimate_card.dart';
import '../widgets/maintenance_info_card.dart';
import '../widgets/schedule_selector.dart';
import '../widgets/service_info_card.dart';

class ServiceScheduleScreen extends ConsumerWidget {
  const ServiceScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(customerProvider);
    final customer = customerAsync.valueOrNull;
    final userName = customer?.name ?? 'User';
    final userId = customer != null
        ? '#${customer.docId.substring(0, customer.docId.length > 6 ? 6 : customer.docId.length)}'
        : '';

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
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              final hPad = constraints.maxWidth > 600
                  ? AppSpacing.xxl
                  : AppSpacing.base;
              return Column(
                children: [
                  _ProfileHeader(
                    name: userName,
                    userId: userId,
                    avatarUrl: '',
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: hPad,
                        vertical: AppSpacing.sm,
                      ),
                      children: [
                        const ServiceInfoCard(),
                        const SizedBox(height: AppSpacing.lg),
                        const _WhatDoYouNeedSection(),
                        const SizedBox(height: AppSpacing.lg),
                        const _ScheduleSection(),
                        const SizedBox(height: AppSpacing.base),
                        const EstimateRow(),
                        const SizedBox(height: AppSpacing.base),
                        const _ConfirmButton(),
                        const SizedBox(height: AppSpacing.base),
                        const MaintenanceInfoCard(),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ── Profile header ────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final String name;
  final String userId;
  final String avatarUrl;

  const _ProfileHeader({
    required this.name,
    required this.userId,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.deepPurple.shade100,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.jpeg',
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, color: Colors.deepPurple),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'ID : $userId',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.black87,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── "What do you need?" section ───────────────────────────────────────────────
class _WhatDoYouNeedSection extends ConsumerWidget {
  const _WhatDoYouNeedSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      serviceProvider.select((s) => s.selectedServiceType),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What do you need?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppChip(
                  label: 'Maintenance',
                  selected: selected == ServiceType.maintenance,
                  icon: const Icon(
                    Icons.build_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  onTap: () => ref
                      .read(serviceProvider.notifier)
                      .selectServiceType(ServiceType.maintenance),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppChip(
                  label: 'Installation',
                  selected: selected == ServiceType.installation,
                  icon: const Icon(
                    Icons.receipt_long_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  onTap: () => ref
                      .read(serviceProvider.notifier)
                      .selectServiceType(ServiceType.installation),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Schedule section ──────────────────────────────────────────────────────────
class _ScheduleSection extends StatelessWidget {
  const _ScheduleSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Schedule Service',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          ScheduleSelector(),
        ],
      ),
    );
  }
}

// ── Confirm button ────────────────────────────────────────────────────────────
class _ConfirmButton extends ConsumerStatefulWidget {
  const _ConfirmButton();

  @override
  ConsumerState<_ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends ConsumerState<_ConfirmButton> {
  bool _isLoading = false;

  void _confirmBooking() async {
    setState(() => _isLoading = true);
    
    try {
      final authState = ref.read(authProvider);
      final phone = authState.loggedInPhone;
      
      if (phone != null) {
        final serviceState = ref.read(serviceProvider);
        // We need machine type/model and date. Combine date and time
        // Note: For simplicity we just use the selectedDate here
        final dateTime = serviceState.selectedDate;
        
        // Machine model from state, fallback to generic
        final machineModel = serviceState.machineModel ?? 'Unknown Machine';
        
        final serviceType = serviceState.selectedServiceType == ServiceType.maintenance
            ? 'maintenance'
            : 'installation';

        final firestore = FirestoreService();
        await firestore.addMaintenanceBooking(
          phone: phone,
          dateTime: dateTime ?? DateTime.now(),
          machineModel: machineModel,
          serviceType: serviceType,
        );
        
        // Refresh maintenance provider so new booking reflects on dashboard
        ref.invalidate(maintenanceProvider);
      }
      
      if (mounted) {
        BookingSuccessPopup.show(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book service: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.shade200.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.cyan.shade100,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: _isLoading ? null : _confirmBooking,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isLoading)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black87,
                      ),
                    )
                  else ...[
                    const Text(
                      'Confirm Schedule',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
