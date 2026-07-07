import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Tela de intervenção no momento de crise/vontade.
/// Objetivo: inserir uma pausa consciente real antes de qualquer decisão.
class CrisisScreen extends StatefulWidget {
  const CrisisScreen({super.key});

  @override
  State<CrisisScreen> createState() => _CrisisScreenState();
}

class _CrisisScreenState extends State<CrisisScreen>
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
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Respire comigo',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              _buildBreathingCircle(),
              const Spacer(),
              Text(
                _timerFinished
                    ? 'Como você está se sentindo agora?'
                    : 'Fique aqui por mais alguns segundos...',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
              ),
              const SizedBox(height: 24),
              if (_timerFinished) ..._buildDecisionButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreathingCircle() {
    return AnimatedBuilder(
      animation: _breathController,
      builder: (context, child) {
        final scale = 0.8 + (_breathController.value * 0.4);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withOpacity(0.15),
              border: Border.all(color: AppColors.accent.withOpacity(0.5), width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              _timerFinished ? '🙂' : '$_secondsLeft',
              style: const TextStyle(
                fontSize: 42,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildDecisionButtons() {
    return [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepBlue,
            foregroundColor: AppColors.textPrimary,
          ),
          onPressed: () {
            // TODO: registrar no diário como "vontade resistida"
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
            // TODO: abrir tela de contato de apoio (familiar/psicólogo)
            Navigator.of(context).pop();
          },
          child: const Text('Quero falar com alguém'),
        ),
      ),
    ];
  }
}
