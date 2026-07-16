import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/crisis_decision_buttons.dart';

/// Tela de intervenção no momento de crise/vontade — método de respiração.
class BreathingCrisisScreen extends StatefulWidget {
  const BreathingCrisisScreen({super.key});

  @override
  State<BreathingCrisisScreen> createState() => _BreathingCrisisScreenState();
}

class _BreathingCrisisScreenState extends State<BreathingCrisisScreen>
    with SingleTickerProviderStateMixin {
  static const int _totalSeconds = 30;
  int _secondsLeft = _totalSeconds;
  Timer? _timer;
  late AnimationController _breathController;

  bool get _timerFinished => _secondsLeft <= 0;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceElevated,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Respire comigo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _buildBreathingCircle(constraints.maxWidth),
                    ),
                  ),
                  Text(
                    _timerFinished
                        ? 'Como você está se sentindo agora?'
                        : 'Fique aqui por mais alguns segundos...',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_timerFinished) const CrisisDecisionButtons(),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBreathingCircle(double availableWidth) {
    final baseSize = (availableWidth * 0.5).clamp(140.0, 200.0);

    return AnimatedBuilder(
      animation: _breathController,
      builder: (context, child) {
        final scale = 0.8 + (_breathController.value * 0.4);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: baseSize,
            height: baseSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withOpacity(0.15),
              border: Border.all(
                color: AppColors.accent.withOpacity(0.5),
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              _timerFinished ? '🙂' : '$_secondsLeft',
              style: TextStyle(
                fontSize: baseSize * 0.23,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
