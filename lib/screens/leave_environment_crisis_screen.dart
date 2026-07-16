import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/crisis_decision_buttons.dart';

/// Método de intervenção baseado em técnica de terapia comportamental:
/// afastar-se fisicamente do ambiente/estímulo e ocupar a mente com
/// outra atividade por um tempo, deixando o impulso "esfriar" sozinho.
class LeaveEnvironmentCrisisScreen extends StatefulWidget {
  const LeaveEnvironmentCrisisScreen({super.key});

  @override
  State<LeaveEnvironmentCrisisScreen> createState() =>
      _LeaveEnvironmentCrisisScreenState();
}

class _LeaveEnvironmentCrisisScreenState
    extends State<LeaveEnvironmentCrisisScreen> {
  static const int _totalSeconds = 15 * 60; // 15 minutos
  int _secondsLeft = _totalSeconds;
  Timer? _timer;

  bool get _timerFinished => _secondsLeft <= 0;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceElevated,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Saia daqui um pouco',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.directions_walk_outlined,
                        size: 64,
                        color: AppColors.accent.withOpacity(0.8),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _timerFinished ? '🙂' : _formattedTime,
                        style: TextStyle(
                          fontSize: _timerFinished ? 42 : 48,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          _timerFinished
                              ? 'Como você está se sentindo agora?'
                              : 'Levante, saia do ambiente e faça outra '
                                    'coisa. Volte aqui quando o tempo acabar.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_timerFinished) const CrisisDecisionButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
