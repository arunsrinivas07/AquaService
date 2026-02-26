// lib/features/service/widgets/estimate_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../providers/service_provider.dart';

class EstimateRow extends ConsumerWidget {
  const EstimateRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cost = ref.watch(serviceProvider.select((s) => s.estimateCost));
    final models = ref.watch(machineModelsProvider);
    final selected = ref.watch(serviceProvider.select((s) => s.machineModel));

    return Row(
      children: [
        // Estimate cost card
        Expanded(
          flex: 4,
          child: AppCard(
            isGlassy: true,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: 7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Estimate Cost',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '₹${cost.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Machine model dropdown card
        Expanded(
          flex: 6,
          child: _MachineModelDropdown(models: models, selected: selected),
        ),
      ],
    );
  }
}

class _MachineModelDropdown extends ConsumerWidget {
  final List<String> models;
  final String? selected;
  const _MachineModelDropdown({required this.models, required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      isGlassy: true,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: 7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Machine Model',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selected,
              isDense: true,
              hint: const Text(
                'Select Model',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
              isExpanded: true,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              items: models
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  ref.read(serviceProvider.notifier).selectMachineModel(v);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
