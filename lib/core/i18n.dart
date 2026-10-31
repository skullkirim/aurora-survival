import 'package:flutter/foundation.dart';

import 'pt_ui.dart';
import 'storage.dart';

/// Idioma de la app: 'es' (español), 'en' (inglés) o 'pt' (portugués).
final ValueNotifier<String> lang = ValueNotifier('es');

const languages = ['es', 'en', 'pt'];

bool get isEn => lang.value == 'en';
bool get isPt => lang.value == 'pt';

/// Texto según el idioma: tr('Hola', 'Hello', 'Olá').
/// Si no se da el portugués, se busca en [ptUi] por el texto en español
/// y, si no está, se muestra en español (es el idioma más cercano).
String tr(String es, String en, [String? pt]) => switch (lang.value) {
      'en' => en,
      'pt' => pt ?? ptUi[es] ?? es,
      _ => es,
    };

void initLang() {
  final saved = Store.getString('lang');
  if (saved != null && languages.contains(saved)) {
    lang.value = saved;
  } else {
    final code = PlatformDispatcher.instance.locale.languageCode;
    lang.value = languages.contains(code) ? code : 'en';
  }
}

Future<void> setLang(String l) async {
  lang.value = l;
  await Store.setString('lang', l);
}
