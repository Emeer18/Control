import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/native_bridge.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? _ignoringBatteryOptimizations;

  @override
  void initState() {
    super.initState();
    _checkBatteryStatus();
  }

  Future<void> _checkBatteryStatus() async {
    final result = await NativeBridge.isIgnoringBatteryOptimizations();
    if (mounted) setState(() => _ignoringBatteryOptimizations = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCard(
                icon: Icons.shield_outlined,
                title: 'Bloqueio automático',
                description:
                    'Para o Control conseguir interromper o acesso a apps '
                    'de apostas, você precisa ativar a permissão de '
                    'acessibilidade manualmente nas configurações do '
                    'Android.',
                buttonLabel: 'Ativar permissão de acessibilidade',
                onPressed: () => NativeBridge.openAccessibilitySettings(),
              ),
              const SizedBox(height: 16),
              _buildCard(
                icon: Icons.battery_charging_full_outlined,
                title: 'Manter proteção sempre ativa',
                description:
                    'Alguns celulares (especialmente Xiaomi/MIUI) podem '
                    'encerrar o Control em segundo plano para economizar '
                    'bateria. Ativar esta opção evita que isso aconteça, '
                    'mantendo o bloqueio funcionando o tempo todo.',
                buttonLabel: _ignoringBatteryOptimizations == true
                    ? 'Já ativado ✓'
                    : 'Manter sempre ativo',
                onPressed: _ignoringBatteryOptimizations == true
                    ? null
                    : () async {
                        await NativeBridge.requestIgnoreBatteryOptimizations();
                        await Future.delayed(const Duration(milliseconds: 500));
                        _checkBatteryStatus();
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonLabel,
    required VoidCallback? onPressed,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.accent),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}