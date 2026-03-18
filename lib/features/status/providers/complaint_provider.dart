// lib/features/status/providers/complaint_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firestore_service.dart';
import '../../login/providers/auth_provider.dart';

class ComplaintRecord {
  final String docId;
  final String complaintId;
  final String complaintType;
  final String status;
  final DateTime date;

  const ComplaintRecord({
    required this.docId,
    required this.complaintId,
    required this.complaintType,
    required this.status,
    required this.date,
  });

  factory ComplaintRecord.fromFirestore(Map<String, dynamic> data) {
    DateTime dt = DateTime.now();
    if (data['date'] is Timestamp) {
      dt = (data['date'] as Timestamp).toDate();
    } else if (data['date'] is String) {
      dt = DateTime.tryParse(data['date']) ?? DateTime.now();
    }

    return ComplaintRecord(
      docId: data['docId'] ?? '',
      complaintId: data['complaint_id']?.toString() ?? '',
      complaintType: data['complaint_type']?.toString() ?? 'Unknown',
      status: data['status']?.toString().toLowerCase() ?? 'pending',
      date: dt,
    );
  }
}

final complaintProvider = FutureProvider<List<ComplaintRecord>>((ref) async {
  final authState = ref.watch(authProvider);
  final phone = authState.loggedInPhone;

  if (phone == null) {
    return [];
  }

  final service = FirestoreService();
  final docs = await service.getComplaintsByPhone(phone);
  final records = docs.map((d) => ComplaintRecord.fromFirestore(d)).toList();

  // Sort locally by date descending to bypass Firestore index requirements
  records.sort((a, b) => b.date.compareTo(a.date));
  return records;
});
