import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'services/preferences_service.dart';
import 'services/native_bridge.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/crisis_screen.dart';

/// Chave global de navegação: permite abrir uma tela (como a de Crise)
/// a partir de qualquer lugar do app, inclusive de um callback nativo
/// que não está "dentro" da árvore de widgets no momento em que dispara.
final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ControlApp());
}

class ControlApp extends StatefulWidget {
  const ControlApp({super.key});

  @override
  State<ControlApp> createState() => _ControlAppState();
}

class _ControlAppState extends State<ControlApp> {
  @override
  void initState() {
    super.initState();
    // Assim que o serviço nativo de acessibilidade detectar um app
    // bloqueado, ele chama esse callback e abrimos a tela de Crise,
    // não importa em que tela o usuário estava.
    NativeBridge.listenForCrisisTrigger(() {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => const CrisisScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Control',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const _StartupRouter(),
    );
  }
}

/// Decide, ao abrir o app, se mostra o onboarding (primeira vez) ou vai
/// direto para a Home (usuário que já passou por essa etapa antes).
class _StartupRouter extends StatelessWidget {
  const _StartupRouter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: PreferencesService().isOnboardingDone(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return snapshot.data! ? const HomeScreen() : const OnboardingScreen();
      },
    );
  }
}
