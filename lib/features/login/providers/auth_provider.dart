// lib/features/login/providers/auth_provider.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/auth_service.dart';

@immutable
class AuthState {
  final String? loggedInPhone;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.loggedInPhone,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isLoggedIn => loggedInPhone != null;

  AuthState copyWith({
    String? loggedInPhone,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    bool clearPhone = false,
  }) {
    return AuthState(
      loggedInPhone: clearPhone ? null : (loggedInPhone ?? this.loggedInPhone),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService = AuthService();

  AuthNotifier() : super(const AuthState());

  Future<bool> login(String phone, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _authService.login(phone, password);

    if (result.success) {
      // ── Persist Login ───────────────────────────
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInPhone', phone);
      // ──────────────────────────────────────────────

      state = AuthState(loggedInPhone: phone, isLoading: false);
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      );
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInPhone');
    state = const AuthState();
  }

  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('loggedInPhone');

    if (phone != null && phone.isNotEmpty) {
      state = AuthState(loggedInPhone: phone, isLoading: false);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
