import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Almacenamiento local simple (todo offline). Se carga una sola vez al inicio.
class Store {
  Store._();
  static late SharedPreferences _p;

  static Future<void> init() async {
    _p = await SharedPreferences.getInstance();
  }

  // ---------- Genéricos ----------
  static List<String> strings(String k) => _p.getStringList(k) ?? <String>[];
  static Future<void> setStrings(String k, List<String> v) =>
      _p.setStringList(k, v);

  static String? getString(String k) => _p.getString(k);
  static Future<void> setString(String k, String v) => _p.setString(k, v);

  static int getInt(String k, [int def = 0]) => _p.getInt(k) ?? def;
  static Future<void> setInt(String k, int v) => _p.setInt(k, v);

  static bool getBool(String k, [bool def = false]) => _p.getBool(k) ?? def;
  static Future<void> setBool(String k, bool v) => _p.setBool(k, v);

  static List<Map<String, dynamic>> jsonList(String k) {
    final raw = _p.getString(k);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List;
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> setJsonList(String k, List<Map<String, dynamic>> v) =>
      _p.setString(k, jsonEncode(v));

  // ---------- Biblioteca ----------
  static Set<String> get favs => strings('favs').toSet();
  static Future<void> toggleFav(String id) {
    final s = favs;
    s.contains(id) ? s.remove(id) : s.add(id);
    return setStrings('favs', s.toList());
  }

  static Set<String> get read => strings('read').toSet();
  static Future<void> markRead(String id) {
    final s = read;
    if (s.add(id)) return setStrings('read', s.toList());
    return Future.value();
  }

  static int quizBest(String cat) => getInt('quiz_$cat', -1);
  static Future<void> saveQuiz(String cat, int score) async {
    if (score > quizBest(cat)) await setInt('quiz_$cat', score);
  }

  // ---------- Ajustes ----------
  static bool get redMode => getBool('red_mode');
  static Future<void> setRedMode(bool v) => setBool('red_mode', v);
}
