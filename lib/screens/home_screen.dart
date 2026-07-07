import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/streak_model.dart';
import '../services/preferences_service.dart';
import 'crisis_screen.dart';
import 'journal_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO: substituir por dado persistido (streak real do usuário)
  late StreakModel _streak;
  final _prefsService = PreferencesService();
  String? _userName;

  @override
  void initState() {
    super.initState();
    _streak = StreakModel(startDate: DateTime.now().subtract(const Duration(days: 4)));
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await _prefsService.getUserName();
    if (mounted) setState(() => _userName = name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_userName != null) _buildGreeting(),
              if (_userName != null) const SizedBox(height: 16),
              _buildStreakCard(),
              const SizedBox(height: 20),
              _buildCrisisButton(context),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildQuickAction(
                    context,
                    icon: Icons.book_outlined,
                    label: 'Diário',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const JournalScreen()),
                    ),
                  )),
                  const SizedBox(width: 16),
                  Expanded(child: _buildQuickAction(
                    context,
                    icon: Icons.menu_book_outlined,
                    label: 'Conteúdo',
                    onTap: () {
                      // TODO: navegar para tela de conteúdo/leitura
                    },
                  )),
                ],
              ),
              const SizedBox(height: 16),
              _buildQuickAction(
                context,
                icon: Icons.bar_chart_outlined,
                label: 'Meu progresso',
                onTap: () {
                  // TODO: navegar para tela de progresso/gráficos
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    final hour = DateTime.now().hour;
    final saudacao = hour < 12
        ? 'Bom dia'
        : hour < 18
            ? 'Boa tarde'
            : 'Boa noite';
    return Text(
      '$saudacao, $_userName',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildStreakCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Text(
              'Você está há',
              style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              '${_streak.currentStreakDays}',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
                height: 1,
              ),
            ),
            const Text(
              'dias no controle',
              style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrisisButton(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.crisisAction,
          foregroundColor: AppColors.crisisActionText,
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CrisisScreen()),
        ),
        icon: const Icon(Icons.self_improvement),
        label: const Text(
          'Estou com vontade agora',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Column(
            children: [
              Icon(icon, color: AppColors.accent, size: 28),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}
