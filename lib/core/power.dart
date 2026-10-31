import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'storage.dart';

/// Ahorro de energía: 60 Hz, brillo propio de la app y atenuado automático.
class Power {
  Power._();
  static const _ch = MethodChannel('apoca/power');

  static bool get lowRefresh => Store.getBool('pw_60hz', true);

  /// Brillo de la app en % (0 = usar el del sistema).
  static int get brightness => Store.getInt('pw_bright', 0);

  /// Segundos sin tocar antes de atenuar (0 = nunca).
  static int get dimAfter => Store.getInt('pw_dim', 0);

  static bool _dimmed = false;
  static Timer? _timer;

  static Future<void> applyAll() async {
    await setLowRefresh(lowRefresh);
    await _setNativeBrightness(brightness);
    resetIdle();
  }

  static Future<void> keepScreenOn(bool on) async {
    try {
      await _ch.invokeMethod('keepScreenOn', {'on': on});
    } catch (_) {}
  }

  /// ¿El sistema deja a la app sin restricciones de batería? (necesario para alarmas en MIUI).
  static Future<bool> isIgnoringBattery() async {
    try {
      return await _ch.invokeMethod<bool>('isIgnoringBattery') ?? true;
    } catch (_) {
      return true;
    }
  }

  static Future<void> openBatterySettings() async {
    try {
      await _ch.invokeMethod('openBatterySettings');
    } catch (_) {}
  }

  static Future<void> openAutostart() async {
    try {
      await _ch.invokeMethod('openAutostart');
    } catch (_) {}
  }

  /// Brillo nativo directo (0–100) sin guardarlo como preferencia.
  static Future<void> rawBrightness(int percent) => _setNativeBrightness(percent);

  static Future<void> setLowRefresh(bool on) async {
    await Store.setBool('pw_60hz', on);
    try {
      await _ch.invokeMethod('setLowRefresh', {'on': on});
    } catch (_) {}
  }

  static Future<void> setBrightness(int percent) async {
    await Store.setInt('pw_bright', percent);
    await _setNativeBrightness(percent);
  }

  static Future<void> setDimAfter(int seconds) async {
    await Store.setInt('pw_dim', seconds);
    resetIdle();
  }

  static Future<void> _setNativeBrightness(int percent) async {
    try {
      await _ch.invokeMethod('setBrightness', {'value': percent <= 0 ? -1.0 : percent / 100.0});
    } catch (_) {}
  }

  /// Se llama en cada toque: reinicia el temporizador y quita el atenuado.
  static void resetIdle() {
    _timer?.cancel();
    if (_dimmed) {
      _dimmed = false;
      _setNativeBrightness(brightness);
    }
    final s = dimAfter;
    if (s > 0) {
      _timer = Timer(Duration(seconds: s), () {
        _dimmed = true;
        _setNativeBrightness(3);
      });
    }
  }
}

/// Envuelve la app y detecta toques para el atenuado automático (sin redibujar nada).
class IdleDimmer extends StatelessWidget {
  final Widget child;
  const IdleDimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) => Power.resetIdle(),
        child: child,
      );
}
