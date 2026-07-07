import 'package:flutter/material.dart';

/// Paleta pensada para transmitir seriedade e acolhimento — o oposto da
/// estética de casas de aposta (amarelo/dourado, verde neon, vermelho vivo).
/// Tons de azul profundo, contraste suave, nada "gritante".
class AppColors {
  // Fundo geral do app: azul acinzentado, não é branco nem preto puro.
  static const Color background = Color(0xFF1E2D3D);

  // Superfície de cards: um pouco mais clara que o fundo, pra dar profundidade
  // sem precisar de bordas ou sombras fortes.
  static const Color surface = Color(0xFF28394A);
  static const Color surfaceElevated = Color(0xFF31465C);

  // Azul profundo: usado no botão de crise e em ações de destaque "sérias".
  static const Color deepBlue = Color(0xFF16232E);

  // Accent mais claro, para ícones e detalhes pontuais (não usar em áreas grandes).
  static const Color accent = Color(0xFF4CB5AE);

  // Texto: nunca branco puro. Contraste suave, confortável de ler à noite.
  static const Color textPrimary = Color(0xFFD7E1E8);
  static const Color textSecondary = Color(0xFF8FA3B3);

  // Estados: versões dessaturadas, sem neon.
  static const Color danger = Color(0xFFB3564F);
  static const Color success = Color(0xFF5FA88F);

  // Botão de crise: única cor do app que foge da paleta calma de propósito.
  // Precisa ser reconhecido instantaneamente em um momento de urgência.
  static const Color crisisAction = Color(0xFFE53E45);
  static const Color crisisActionText = Color(0xFFFFF5F5);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.deepBlue,
        brightness: Brightness.dark,
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        background: AppColors.background,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepBlue,
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.surfaceElevated),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
