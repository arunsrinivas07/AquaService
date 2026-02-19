// lib/features/payments/models/payment_model.dart

class PaymentModel {
  final double outstandingBalance;
  final int dueDays;
  final String userId;
  final String userName;
  final String avatarUrl;

  const PaymentModel({
    required this.outstandingBalance,
    required this.dueDays,
    required this.userId,
    required this.userName,
    required this.avatarUrl,
  });
}
