// lib/features/status/screens/status_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/services/firestore_service.dart';
import '../../booking_service/providers/maintenance_provider.dart';
import '../../login/providers/auth_provider.dart';
import '../providers/complaint_provider.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maintenanceAsync = ref.watch(maintenanceProvider);
    final complaintAsync = ref.watch(complaintProvider);

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, ref),
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    const SliverPadding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 20),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Your Service Requests',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    _buildMaintenanceSection(maintenanceAsync),
                    const SliverPadding(
                      padding: EdgeInsets.fromLTRB(16, 24, 16, 20),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Your Complaints',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    _buildComplaintSection(complaintAsync),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.deepPurple.shade100,
            child: FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                final authState = ref.read(authProvider);
                final phone = authState.loggedInPhone ?? '';
                String? localPic;
                if (snapshot.hasData && phone.isNotEmpty) {
                  localPic = snapshot.data!.getString('profile_pic_$phone');
                }
                return ClipOval(
                  child: localPic != null && File(localPic).existsSync()
                      ? Image.file(
                          File(localPic),
                          fit: BoxFit.cover,
                          width: 48,
                          height: 48,
                        )
                      : Image.asset(
                          'assets/images/avatar.jpeg',
                          fit: BoxFit.cover,
                          width: 48,
                          height: 48,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.person, color: Colors.deepPurple),
                        ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Status & Tracking',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceSection(AsyncValue<MaintenanceSummary> summaryAsync) {
    return summaryAsync.when(
      data: (summary) {
        if (summary.records.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No service requests found.',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final record = summary.records[index];
            return _StatusCard(
              type: 'Service: ${record.serviceType.toUpperCase()}',
              id: record.docId,
              date: record.dateTime,
              status: record.status,
              collection: 'maintance_Installation',
              address: record.address,
            );
          }, childCount: summary.records.length),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildComplaintSection(
    AsyncValue<List<ComplaintRecord>> complaintAsync,
  ) {
    return complaintAsync.when(
      data: (complaints) {
        if (complaints.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  'No complaints found.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final record = complaints[index];
            return _StatusCard(
              type: 'Complaint: ${record.complaintType}',
              id: record.docId,
              refId: record.complaintId,
              date: record.date,
              status: record.status,
              collection: 'Complaints',
            );
          }, childCount: complaints.length),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}

class _StatusCard extends ConsumerStatefulWidget {
  final String type;
  final String id;
  final String? refId;
  final DateTime date;
  final String status;
  final String collection;
  final String? address;

  const _StatusCard({
    required this.type,
    required this.id,
    this.refId,
    required this.date,
    required this.status,
    required this.collection,
    this.address,
  });

  @override
  ConsumerState<_StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends ConsumerState<_StatusCard> {
  bool _isCancelling = false;

  void _cancelRequest() async {
    setState(() => _isCancelling = true);
    try {
      final firestoreService = FirestoreService();
      await firestoreService.cancelRequest(widget.collection, widget.id);

      // Refresh providers based on collection
      if (widget.collection == 'Complaints') {
        ref.invalidate(complaintProvider);
      } else {
        ref.invalidate(maintenanceProvider);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request cancelled successfully.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to cancel: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isCancelling = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(widget.status);
    final isPending = widget.status.toLowerCase() == 'pending';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          if (widget.id.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'ID: ${widget.id}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
                fontFamily: 'monospace',
              ),
            ),
          ],
          if (widget.refId != null && widget.refId!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'Ref. ID: #${widget.refId}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                DateFormat('MMM dd, yyyy').format(widget.date),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (widget.address != null && widget.address!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.address!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (isPending) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            SizedBox(
              width: double.infinity,
              child: _isCancelling
                  ? const Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: _cancelRequest,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel Request'),
                    ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }
}
