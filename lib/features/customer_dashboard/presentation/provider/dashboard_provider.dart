// lib/features/customer_dashboard/presentation/provider/dashboard_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/dashboard_state.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier()
      : super(
          DashboardState(
            userName: 'Vishnu',
            machineName: 'AquaPure Pro X',
            modelNumber: 'Selectos 212',
            tdsValue: 50,
            isHealthy: true,
            outstandingBalance: 134,
            nextServiceDate: DateTime(2025, 2, 28),
            serviceCountdown: 'In 15 days',
            currentNavIndex: 2,
          ),
        );

  void setNavIndex(int index) {
    state = state.copyWith(currentNavIndex: index);
  }

  void updateTds(double value) {
    state = state.copyWith(tdsValue: value);
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>(
  (ref) => DashboardNotifier(),
);