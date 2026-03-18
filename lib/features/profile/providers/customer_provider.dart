// lib/features/profile/providers/customer_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firestore_service.dart';
import '../../login/providers/auth_provider.dart';
import '../models/customer_model.dart';

/// Provides the logged-in customer's data from Firestore.
final customerProvider = FutureProvider<CustomerModel?>((ref) async {
  final authState = ref.watch(authProvider);
  final phone = authState.loggedInPhone;
  if (phone == null) return null;

  final service = FirestoreService();
  final data = await service.getCustomerByPhone(phone);
  if (data == null) return null;

  return CustomerModel.fromFirestore(data);
});
