import 'dart:math';
import 'dart:typed_data';

const Map<String, String> morseTable = {
  'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.',
  'G': '--.', 'H': '....', 'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..',
  'M': '--', 'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.',
  'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-',
  'Y': '-.--', 'Z': '--..',
  '0': '-----', '1': '.----', '2': '..---', '3': '...--', '4': '....-',
  '5': '.....', '6': '-....', '7': '--...', '8': '---..', '9': '----.',
  '.': '.-.-.-', ',': '--..--', '?': '..--..', '/': '-..-.', '@': '.--.-.',
  '!': '-.-.--', '=': '-...-',
};

final Map<String, String> _reverse = {for (final e in morseTable.entries) e.value: e.key};

String _clean(String s) {
  const from = 'ÁÉÍÓÚÜÑ';
  const to = 'AEIOUUN';
  final up = s.toUpperCase();
  final b = StringBuffer();
  for (final ch in up.split('')) {
    final i = from.indexOf(ch);
    b.write(i >= 0 ? to[i] : ch);
  }
  return b.toString();
}

/// Código de una letra en formato visual (· —).
String prettyCode(String code) => code.replaceAll('.', '·').replaceAll('-', '—');

/// Texto -> morse visual: letras separadas por espacio, palabras por " / ".
String toMorse(String text) => prettyCode(toMorseRaw(text));

/// Texto -> morse con . y -
String toMorseRaw(String text) => _clean(text)
    .trim()
    .split(RegExp(r'\s+'))
    .map((w) => w.split('').map((c) => morseTable[c] ?? '').where((e) => e.isNotEmpty).join(' '))
    .where((w) => w.isNotEmpty)
    .join(' / ');

/// Morse (con . - o · —, letras separadas por espacio, palabras por /) -> texto.
String fromMorse(String code) {
  final norm = code
      .replaceAll('·', '.')
      .replaceAll('—', '-')
      .replaceAll('_', '-')
      .replaceAll('−', '-');
  return norm
      .trim()
      .split(RegExp(r'\s*/\s*|\s{3,}'))
      .map((w) => w
          .trim()
          .split(RegExp(r'\s+'))
          .where((l) => l.isNotEmpty)
          .map((l) => _reverse[l] ?? '¿')
          .join())
      .where((w) => w.isNotEmpty)
      .join(' ');
}

/// Secuencia de (encendido?, unidades). Punto=1, raya=3, intra=1, letra=3, palabra=7.
List<(bool, int)> morseTimeline(String text) {
  final out = <(bool, int)>[];
  final words = _clean(text).trim().split(RegExp(r'\s+'));
  for (var w = 0; w < words.length; w++) {
    final letters = words[w].split('').where(morseTable.containsKey).toList();
    for (var l = 0; l < letters.length; l++) {
      final code = morseTable[letters[l]]!;
      for (var s = 0; s < code.length; s++) {
        out.add((true, code[s] == '.' ? 1 : 3));
        if (s < code.length - 1) out.add((false, 1));
      }
      if (l < letters.length - 1) out.add((false, 3));
    }
    if (w < words.length - 1) out.add((false, 7));
  }
  return out;
}

/// Genera un WAV (PCM 16 bits mono) con el mensaje en tonos de [freq] Hz.
/// Se crea en memoria: no necesita archivos de audio.
Uint8List morseWav(List<(bool, int)> timeline, {int unitMs = 100, double freq = 700}) {
  const rate = 8000;
  final unit = rate * unitMs ~/ 1000;
  final total = timeline.fold<int>(0, (a, e) => a + e.$2) * unit + unit * 2;
  final pcm = Int16List(total);
  var pos = unit; // pequeño silencio inicial
  const ramp = 40; // 5 ms de rampa para evitar "clics"
  for (final (on, units) in timeline) {
    final n = units * unit;
    if (on) {
      for (var i = 0; i < n && pos + i < total; i++) {
        var amp = 0.6;
        if (i < ramp) amp *= i / ramp;
        if (n - i < ramp) amp *= (n - i) / ramp;
        pcm[pos + i] = (sin(2 * pi * freq * i / rate) * amp * 32767).round();
      }
    }
    pos += n;
  }
  final data = pcm.buffer.asUint8List();
  final b = BytesBuilder();
  void str(String s) => b.add(s.codeUnits);
  void u32(int v) => b.add(Uint8List(4)..buffer.asByteData().setUint32(0, v, Endian.little));
  void u16(int v) => b.add(Uint8List(2)..buffer.asByteData().setUint16(0, v, Endian.little));
  str('RIFF');
  u32(36 + data.length);
  str('WAVE');
  str('fmt ');
  u32(16);
  u16(1); // PCM
  u16(1); // mono
  u32(rate);
  u32(rate * 2);
  u16(2);
  u16(16);
  str('data');
  u32(data.length);
  b.add(data);
  return b.toBytes();
}
