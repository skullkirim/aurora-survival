import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'i18n.dart';
import 'storage.dart';

/// Alarmas: medicinas, torniquete, turnos de guardia y temporizador.
/// Suenan aunque la app esté cerrada (notificaciones programadas de Android).
/// Cada alarma se guarda como mapa en Store 'alarms'.
class Alarms {
  Alarms._();
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _ready = false;

  static const types = ['medicina', 'torniquete', 'guardia', 'temporizador'];

  static String typeLabel(String t) => switch (t) {
        'medicina' => tr('Medicina', 'Medicine', 'Remédio'),
        'torniquete' => tr('Torniquete', 'Tourniquet', 'Torniquete'),
        'guardia' => tr('Turnos de guardia', 'Guard shifts', 'Turnos de guarda'),
        _ => tr('Temporizador', 'Timer', 'Temporizador'),
      };

  static Future<void> init() async {
    if (_ready) return;
    try {
      tzdata.initializeTimeZones();
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );
      _ready = true;
    } catch (_) {}
  }

  static AndroidFlutterLocalNotificationsPlugin? get _android =>
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  /// Pide permiso de notificaciones (Android 13+) y de alarmas exactas.
  static Future<bool> askPermission() async {
    await init();
    final a = _android;
    if (a == null) return false;
    final ok = await a.requestNotificationsPermission() ?? true;
    try {
      if (await a.canScheduleExactNotifications() == false) await a.requestExactAlarmsPermission();
    } catch (_) {}
    return ok;
  }

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'aurora_alarmas',
      'Alarmas AURORA',
      channelDescription: 'Medicinas, torniquete y turnos de guardia',
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.alarm,
      playSound: true,
      enableVibration: true,
      ticker: 'AURORA',
    ),
  );

  static List<Map<String, dynamic>> get all => Store.jsonList('alarms');
  static Future<void> _saveAll(List<Map<String, dynamic>> l) => Store.setJsonList('alarms', l);

  /// Momentos en que suena (ms) y el texto de cada aviso.
  static List<(int, String, String)> occurrences(Map<String, dynamic> a) {
    final start = a['start'] as int;
    final title = '${a['title']}';
    final out = <(int, String, String)>[];
    switch (a['type']) {
      case 'torniquete':
        // Aviso a 1 h, 1 h 30, 2 h y luego cada 30 min hasta 6 h.
        for (final m in [60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360]) {
          out.add((
            start + m * 60000,
            tr('Torniquete: ${m ~/ 60} h ${m % 60} min', 'Tourniquet: ${m ~/ 60} h ${m % 60} min', 'Torniquete: ${m ~/ 60} h ${m % 60} min'),
            m >= 120
                ? tr('MÁS DE 2 HORAS. No lo aflojes: evacúa a un médico YA. $title',
                    'OVER 2 HOURS. Do not loosen it: get to a doctor NOW. $title',
                    'MAIS DE 2 HORAS. Não afrouxe: leve a um médico JÁ. $title')
                : tr('Revisa que siga sin sangrar y que la hora esté anotada. $title',
                    'Check it is still not bleeding and the time is written down. $title',
                    'Verifique se continua sem sangrar e se a hora está anotada. $title'),
          ));
        }
      case 'guardia':
        final names = (a['names'] as List?)?.map((e) => '$e').where((e) => e.isNotEmpty).toList() ?? [];
        final every = (a['every'] as int?) ?? 120;
        final n = names.isEmpty ? 1 : names.length;
        for (var k = 1; k <= 48 && k * every <= 48 * 60; k++) {
          final who = names.isEmpty ? '' : names[k % n];
          out.add((
            start + k * every * 60000,
            tr('Cambio de guardia', 'Guard change', 'Troca de guarda'),
            who.isEmpty ? title : tr('Le toca a: $who', 'Now on watch: $who', 'Agora é a vez de: $who'),
          ));
        }
      case 'medicina':
        final every = (a['every'] as int?) ?? 480;
        final count = (a['count'] as int?) ?? 10;
        for (var k = 0; k < count && k < 60; k++) {
          out.add((
            start + k * every * 60000,
            tr('Medicina: $title', 'Medicine: $title', 'Remédio: $title'),
            tr('Dosis ${k + 1} de $count. ${a['note'] ?? ''}', 'Dose ${k + 1} of $count. ${a['note'] ?? ''}',
                'Dose ${k + 1} de $count. ${a['note'] ?? ''}'),
          ));
        }
      default:
        out.add((start + ((a['every'] as int?) ?? 10) * 60000, tr('Temporizador', 'Timer', 'Temporizador'), title));
    }
    return out;
  }

  static int? nextTime(Map<String, dynamic> a) {
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final o in occurrences(a)) {
      if (o.$1 > now) return o.$1;
    }
    return null;
  }

  static Future<void> _schedule(Map<String, dynamic> a) async {
    await init();
    final id = a['id'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;
    var k = 0;
    for (final (at0, title, body) in occurrences(a)) {
      final nid = id * 100 + k++;
      if (at0 <= now + 1000) continue;
      final at = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.UTC, at0);
      try {
        await _plugin.zonedSchedule(
          id: nid,
          scheduledDate: at,
          notificationDetails: _details,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          title: title,
          body: body,
        );
      } catch (_) {
        // Sin permiso de alarma exacta: aproximada (puede tardar unos minutos).
        try {
          await _plugin.zonedSchedule(
            id: nid,
            scheduledDate: at,
            notificationDetails: _details,
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            title: title,
            body: body,
          );
        } catch (_) {}
      }
    }
  }

  static Future<void> _cancel(Map<String, dynamic> a) async {
    await init();
    final id = a['id'] as int;
    final n = occurrences(a).length;
    for (var k = 0; k < n && k < 100; k++) {
      try {
        await _plugin.cancel(id: id * 100 + k);
      } catch (_) {}
    }
  }

  static Future<Map<String, dynamic>> add(Map<String, dynamic> a) async {
    final list = all;
    final used = list.map((e) => e['id'] as int).toSet();
    var id = DateTime.now().millisecondsSinceEpoch % 20000 + 1;
    while (used.contains(id)) {
      id = id % 20000 + 1;
    }
    a['id'] = id;
    list.add(a);
    await _saveAll(list);
    await _schedule(a);
    return a;
  }

  static Future<void> remove(int id) async {
    final list = all;
    for (final a in list.where((e) => e['id'] == id).toList()) {
      await _cancel(a);
      list.remove(a);
    }
    await _saveAll(list);
  }

  /// Aviso inmediato (por ejemplo, para probar el sonido).
  static Future<void> test() async {
    await init();
    try {
      await _plugin.show(
        id: 1,
        title: 'AURORA',
        body: tr('Así sonarán tus alarmas.', 'This is how your alarms will sound.', 'Assim vão soar seus alarmes.'),
        notificationDetails: _details,
      );
    } catch (_) {}
  }
}
