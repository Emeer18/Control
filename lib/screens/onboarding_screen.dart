import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'name_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardPage> _pages = [
    _OnboardPage(
      icon: Icons.self_improvement,
      title: 'Você deu o primeiro passo',
      description:
          'Reconhecer que quer mudar já é o passo mais difícil. O Control '
          'está aqui para te apoiar nessa jornada, um dia de cada vez.',
    ),
    _OnboardPage(
      icon: Icons.shield_outlined,
      title: 'Como funciona',
      description:
          'O Control monitora quando você tenta acessar apps ou sites de '
          'apostas e interrompe o acesso com uma pausa consciente antes de '
          'você continuar. A decisão final é sempre sua.',
    ),
    _OnboardPage(
      icon: Icons.favorite_outline,
      title: 'Sua privacidade importa',
      description:
          'Nada do que você faz aqui é compartilhado. Os dados ficam no seu '
          'aparelho. Para o app funcionar, vamos pedir uma permissão de '
          'acessibilidade no próximo passo — ela é usada apenas para isso.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => _buildPage(_pages[index]),
              ),
            ),
            _buildIndicator(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  child: Text(
                    _currentPage == _pages.length - 1
                        ? 'Começar minha jornada'
                        : 'Continuar',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(page.icon, size: 56, color: AppColors.accent),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  void _handleNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO: aqui também é um bom ponto para disparar o pedido da permissão
      // de Accessibility Service nativa (Android), antes de seguir.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NameScreen()),
      );
    }
  }
}

class _OnboardPage {
  final IconData icon;
  final String title;
  final String description;

  _OnboardPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}
