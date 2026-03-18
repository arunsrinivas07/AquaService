// lib/features/payments/models/payment_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentRecord {
  final String docId;
  final DateTime dateTime;
  final double emi;
  final String phoneNumber;
  final double totalAmount;

  const PaymentRecord({
    required this.docId,
    required this.dateTime,
    required this.emi,
    required this.phoneNumber,
    required this.totalAmount,
  });

  factory PaymentRecord.fromFirestore(Map<String, dynamic> data) {
    DateTime dt = DateTime.now();
    if (data['Date&Time'] is Timestamp) {
      dt = (data['Date&Time'] as Timestamp).toDate();
    }

    return PaymentRecord(
      docId: data['docId'] ?? '',
      dateTime: dt,
      emi: (data['EMI'] as num?)?.toDouble() ?? 0,
      phoneNumber: data['PhoneNumber']?.toString() ?? '',
      totalAmount: (data['TotalAmount'] as num?)?.toDouble() ?? 0,
    );
  }
}

class PaymentSummary {
  final double totalAmount;
  final double totalPaid;
  final double outstandingBalance;
  final int dueDays;
  final String userName;
  final String userId;
  final String avatarUrl;
  final List<PaymentRecord> payments;

  const PaymentSummary({
    required this.totalAmount,
    required this.totalPaid,
    required this.outstandingBalance,
    required this.dueDays,
    required this.userName,
    required this.userId,
    required this.avatarUrl,
    required this.payments,
  });
}
