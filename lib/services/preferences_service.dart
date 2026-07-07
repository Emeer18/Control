import 'package:shared_preferences/shared_preferences.dart';

/// Camada simples de acesso ao armazenamento local para dados leves
/// (flags e texto). Para o diário/streak, no futuro, vale migrar para
/// um banco local (sqflite/hive) — aqui é só o essencial para o
/// onboarding e o nome do usuário.
class PreferencesService {
  static const _keyOnboardingDone = 'onboarding_done';
  static const _keyUserName = 'user_name';

  Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingDone) ?? false;
  }

  Future<void> setOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingDone, true);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
  }
}
