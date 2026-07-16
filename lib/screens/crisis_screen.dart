import 'dart:math';
import 'package:flutter/material.dart';
import 'breathing_crisis_screen.dart';
import 'leave_environment_crisis_screen.dart';

/// Ponto de entrada da intervenção no momento de crise/vontade.
/// Sorteia aleatoriamente um dos métodos disponíveis a cada vez.
class CrisisScreen extends StatelessWidget {
  const CrisisScreen({super.key});

  static final List<WidgetBuilder> _methods = [
    (context) => const BreathingCrisisScreen(),
    (context) => const LeaveEnvironmentCrisisScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final chosenMethod = _methods[Random().nextInt(_methods.length)];
    return chosenMethod(context);
  }
}
