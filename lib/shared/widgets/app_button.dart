// lib/shared/widgets/app_button.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(204, 245, 255, 1),
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          side: BorderSide(
            color: const Color.fromARGB(255, 138, 215, 231),
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
