// lib/features/payments/providers/payment_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/payment_model.dart';

final paymentProvider = Provider<PaymentModel>((ref) {
  return const PaymentModel(
    outstandingBalance: 134.526,
    dueDays: 5,
    userId: '#123456-A',
    userName: 'Vankam da, Leo',
    avatarUrl:
        'https://i.pravatar.cc/150?img=12',
  );
});
