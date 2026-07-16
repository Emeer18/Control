import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CrisisDecisionButtons extends StatelessWidget {
  const CrisisDecisionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepBlue,
              foregroundColor: AppColors.textPrimary,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Consegui, vou continuar meu dia'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: BorderSide(color: AppColors.textPrimary.withOpacity(0.4)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Quero falar com alguém'),
          ),
        ),
      ],
    );
  }
}
