// lib/features/payments/providers/payment_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firestore_service.dart';
import '../../login/providers/auth_provider.dart';
import '../../profile/providers/customer_provider.dart';
import '../models/payment_model.dart';

/// Provides the payment summary for the logged-in user.
final paymentProvider = FutureProvider<PaymentSummary>((ref) async {
  final authState = ref.watch(authProvider);
  final phone = authState.loggedInPhone;
  final customerAsync = ref.watch(customerProvider);

  final customer = customerAsync.valueOrNull;
  final userName = customer?.name ?? 'User';
  final docId = customer?.docId ?? '';

  if (phone == null) {
    return PaymentSummary(
      totalAmount: 0,
      totalPaid: 0,
      outstandingBalance: 0,
      dueDays: 0,
      userName: 'Guest',
      userId: '',
      avatarUrl: '',
      payments: [],
    );
  }

  final service = FirestoreService();
  final paymentDocs = await service.getPaymentsByPhone(phone);
  final records = paymentDocs.map((d) => PaymentRecord.fromFirestore(d)).toList();

  // Calculate totals
  double totalAmount = 0;
  double totalEmiPaid = 0;
  for (final r in records) {
    totalAmount = r.totalAmount; // All records for the same user should have same TotalAmount
    totalEmiPaid += r.emi;
  }

  final outstanding = totalAmount - totalEmiPaid;

  // Calculate due days (next month from last payment)
  int dueDays = 0;
  if (records.isNotEmpty) {
    records.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    final lastPayment = records.first.dateTime;
    final nextDue = DateTime(lastPayment.year, lastPayment.month + 1, lastPayment.day);
    dueDays = nextDue.difference(DateTime.now()).inDays;
    if (dueDays < 0) dueDays = 0;
  }

  return PaymentSummary(
    totalAmount: totalAmount,
    totalPaid: totalEmiPaid,
    outstandingBalance: outstanding,
    dueDays: dueDays,
    userName: userName,
    userId: '#${docId.substring(0, docId.length > 6 ? 6 : docId.length)}',
    avatarUrl: '',
    payments: records,
  );
});
