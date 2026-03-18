// lib/core/services/auth_service.dart

import 'firestore_service.dart';

class AuthResult {
  final bool success;
  final String? errorMessage;

  const AuthResult({required this.success, this.errorMessage});
}

class AuthService {
  final FirestoreService _firestoreService = FirestoreService();

  /// Validates credentials against the LoginAuth collection.
  /// Returns [AuthResult] with success/failure.
  Future<AuthResult> login(String phone, String password) async {
    try {
      final authDoc = await _firestoreService.getLoginAuth(phone);
      if (authDoc == null) {
        return const AuthResult(
          success: false,
          errorMessage: 'Phone number not registered',
        );
      }

      final storedPassword = authDoc['Password'] as String?;
      if (storedPassword == null || storedPassword != password) {
        return const AuthResult(
          success: false,
          errorMessage: 'Incorrect password',
        );
      }

      return const AuthResult(success: true);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Connection error: ${e.toString()}',
      );
    }
  }
}
