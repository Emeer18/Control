import 'package:flutter/services.dart';

/// Ponte de comunicação com o código nativo Android (MainActivity.kt).
class NativeBridge {
  static const _channel = MethodChannel('com.example.control/accessibility');

  static Future<void> openAccessibilitySettings() async {
    await _channel.invokeMethod('openAccessibilitySettings');
  }

  /// Pede para o Android excluir o Control das otimizações de bateria.
  static Future<void> requestIgnoreBatteryOptimizations() async {
    await _channel.invokeMethod('requestIgnoreBatteryOptimizations');
  }

  /// Confirma se a exceção de bateria já está concedida.
  static Future<bool> isIgnoringBatteryOptimizations() async {
    final result = await _channel.invokeMethod<bool>('isIgnoringBatteryOptimizations');
    return result ?? false;
  }

  static void listenForCrisisTrigger(void Function() onCrisisTriggered) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'openCrisisScreen') {
        onCrisisTriggered();
      }
    });
  }
}