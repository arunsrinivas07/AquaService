// lib/features/customer_dashboard/model/dashboard_state.dart

import 'package:flutter/foundation.dart';

@immutable
class DashboardState {
  final String userName;
  final String machineName;
  final String modelNumber;
  final double tdsValue;
  final bool isHealthy;
  final double outstandingBalance;
  final DateTime nextServiceDate;
  final String serviceCountdown;
  final int currentNavIndex;

  const DashboardState({
    required this.userName,
    required this.machineName,
    required this.modelNumber,
    required this.tdsValue,
    required this.isHealthy,
    required this.outstandingBalance,
    required this.nextServiceDate,
    required this.serviceCountdown,
    required this.currentNavIndex,
  });

  DashboardState copyWith({
    String? userName,
    String? machineName,
    String? modelNumber,
    double? tdsValue,
    bool? isHealthy,
    double? outstandingBalance,
    DateTime? nextServiceDate,
    String? serviceCountdown,
    int? currentNavIndex,
  }) {
    return DashboardState(
      userName: userName ?? this.userName,
      machineName: machineName ?? this.machineName,
      modelNumber: modelNumber ?? this.modelNumber,
      tdsValue: tdsValue ?? this.tdsValue,
      isHealthy: isHealthy ?? this.isHealthy,
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      serviceCountdown: serviceCountdown ?? this.serviceCountdown,
      currentNavIndex: currentNavIndex ?? this.currentNavIndex,
    );
  }
}