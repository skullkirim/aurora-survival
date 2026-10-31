import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../core/i18n.dart';

import '../core/storage.dart';

// =====================================================================
// Generador de sonidos (WAV en memoria, sin archivos)
// =====================================================================
Uint8List _wav(List<double> samples, {int rate = 22050}) {
  final pcm = Int16List(samples.length);
  for (var i = 0; i < samples.length; i++) {
    pcm[i] = (samples[i].clamp(-1.0, 1.0) * 32767).round();
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
  u16(1);
  u16(1);
  u32(rate);
  u32(rate * 2);
  u16(2);
  u16(16);
  str('data');
  u32(data.length);
  b.add(data);
  return b.toBytes();
}

/// Tono de silbato: ~3,2 kHz con un trino (el oído humano lo percibe muy fuerte).
Uint8List whistleWav({bool sos = false}) {
  const rate = 22050;
  final out = <double>[];
  void tone(int ms) {
    final n = rate * ms ~/ 1000;
    for (var i = 0; i < n; i++) {
      final t = i / rate;
      final f = 3200 + 120 * sin(2 * pi * 28 * t); // trino
      var a = 0.95;
      if (i < 200) a *= i / 200;
      if (n - i < 200) a *= (n - i) / 200;
      out.add(sin(2 * pi * f * t) * a);
    }
  }

  void silence(int ms) => out.addAll(List.filled(rate * ms ~/ 1000, 0.0));
  if (sos) {
    for (final l in [150, 150, 150, 450, 450, 450, 150, 150, 150]) {
      tone(l);
      silence(150);
    }
    silence(900);
  } else {
    tone(1000);
  }
  return _wav(out, rate: rate);
}

/// Un "clic" seguido de silencio: al repetir en bucle marca el ritmo.
Uint8List clickWav(int bpm) {
  const rate = 22050;
  final n = rate * 60 ~/ bpm;
  final out = List<double>.filled(n, 0);
  for (var i = 0; i < 900 && i < n; i++) {
    out[i] = sin(2 * pi * 1500 * i / rate) * (1 - i / 900);
  }
  return _wav(out, rate: rate);
}

// =====================================================================
// SILBATO
// =====================================================================
class WhistleScreen extends StatefulWidget {
  const WhistleScreen({super.key});
  @override
  State<WhistleScreen> createState() => _WhistleScreenState();
}

class _WhistleScreenState extends State<WhistleScreen> {
  final _p = AudioPlayer();
  String? _mode; // null, 'continuo', 'sos'

  Future<void> _play(String mode) async {
    if (_mode == mode) {
      await _p.stop();
      setState(() => _mode = null);
      return;
    }
    await _p.stop();
    await _p.setReleaseMode(ReleaseMode.loop);
    await _p.setVolume(1);
    await _p.play(BytesSource(whistleWav(sos: mode == 'sos')));
    setState(() => _mode = mode);
  }

  @override
  void dispose() {
    _p.dispose();
    super.dispose();
  }

  Widget _btn(String mode, String label, IconData icon) {
    final on = _mode == mode;
    return SizedBox(
      height: 110,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(backgroundColor: on ? Colors.red : null),
        icon: Icon(on ? Icons.stop : icon, size: 40),
        label: Text(on ? tr('DETENER', 'STOP') : label, style: const TextStyle(fontSize: 22)),
        onPressed: () => _play(mode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Silbato de emergencia', 'Emergency whistle'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(tr('Sube el volumen al máximo. Un sonido agudo se oye más lejos que la voz y no te cansa.', 'Turn the volume all the way up. A high-pitched sound carries farther than your voice and doesn\'t tire you.'),
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          _btn('continuo', tr('SILBATO', 'WHISTLE'), Icons.campaign),
          const SizedBox(height: 12),
          _btn('sos', tr('SOS CON SONIDO', 'SOUND SOS'), Icons.sos),
          const SizedBox(height: 16),
          Text(tr('Códigos de silbato: 1 = atención / ¿dónde estás? · 2 = ven aquí · 3 = AUXILIO', 'Whistle codes: 1 = attention / where are you? · 2 = come here · 3 = HELP'),
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// =====================================================================
// METRÓNOMO DE RCP
// =====================================================================
class CprScreen extends StatefulWidget {
  const CprScreen({super.key});
  @override
  State<CprScreen> createState() => _CprScreenState();
}

class _CprScreenState extends State<CprScreen> {
  final _p = AudioPlayer();
  Timer? _t;
  int _count = 0;
  int _cycles = 0;
  bool _breaths = true;
  static const _bpm = 110;

  Future<void> _toggle() async {
    if (_t != null) {
      _t!.cancel();
      _t = null;
      await _p.stop();
      setState(() {});
      return;
    }
    _count = 0;
    _cycles = 0;
    await _p.setReleaseMode(ReleaseMode.loop);
    await _p.play(BytesSource(clickWav(_bpm)));
    _t = Timer.periodic(const Duration(milliseconds: 60000 ~/ _bpm), (_) {
      setState(() {
        _count++;
        if (_breaths && _count > 30) {
          _count = 0;
          _cycles++;
        }
      });
    });
    setState(() {});
  }

  @override
  void dispose() {
    _t?.cancel();
    _p.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final running = _t != null;
    final breathTime = _breaths && running && _count >= 28;
    return Scaffold(
      appBar: AppBar(title: Text(tr('Ritmo de RCP', 'CPR rhythm'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(tr('Comprime el centro del pecho siguiendo cada clic: 110 por minuto, 5–6 cm de profundidad.', 'Press the center of the chest with each click: 110 per minute, 5–6 cm deep.'),
              style: TextStyle(fontSize: 16)),
          SwitchListTile(
            title: Text(tr('Avisar las 2 ventilaciones cada 30', 'Remind me of 2 breaths every 30')),
            value: _breaths,
            onChanged: (v) => setState(() => _breaths = v),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(running ? '$_count' : '—',
                style: TextStyle(fontSize: 120, fontWeight: FontWeight.bold, color: breathTime ? Colors.lightBlue : cs.primary)),
          ),
          Center(
            child: Text(
              breathTime ? tr('¡PREPÁRATE: 2 VENTILACIONES!', 'GET READY: 2 BREATHS!') : (running ? tr('compresiones · ciclos: $_cycles', 'compressions · cycles: $_cycles', 'compressões · ciclos: $_cycles') : ''),
              style: TextStyle(fontSize: 18, color: breathTime ? Colors.lightBlue : null, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: running ? Colors.red : null),
              icon: Icon(running ? Icons.stop : Icons.favorite, size: 36),
              label: Text(running ? tr('DETENER', 'STOP') : tr('EMPEZAR', 'START'), style: const TextStyle(fontSize: 22)),
              onPressed: _toggle,
            ),
          ),
          const SizedBox(height: 12),
          Text(tr('Cambia de persona cada 2 minutos (unos 4 ciclos).', 'Switch rescuers every 2 minutes (about 4 cycles).'), style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// =====================================================================
// PULSO Y RESPIRACIÓN
// =====================================================================
class PulseScreen extends StatefulWidget {
  const PulseScreen({super.key});
  @override
  State<PulseScreen> createState() => _PulseScreenState();
}

class _PulseScreenState extends State<PulseScreen> {
  final List<DateTime> _taps = [];

  int? get _bpm {
    if (_taps.length < 4) return null;
    final recent = _taps.length > 10 ? _taps.sublist(_taps.length - 10) : _taps;
    final ms = recent.last.difference(recent.first).inMilliseconds / (recent.length - 1);
    return ms <= 0 ? null : (60000 / ms).round();
  }

  void _tap() {
    final now = DateTime.now();
    if (_taps.isNotEmpty && now.difference(_taps.last).inSeconds > 3) _taps.clear();
    setState(() => _taps.add(now));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bpm = _bpm;
    return Scaffold(
      appBar: AppBar(title: Text(tr('Pulso y respiración', 'Pulse and breathing'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
              tr('Pon dos dedos en el cuello (al lado de la tráquea) o en la muñeca (lado del pulgar). ', 'Place two fingers on the neck (beside the windpipe) or on the wrist (thumb side). ') +
              tr('Toca el botón en cada latido. Para la respiración, toca cada vez que el pecho sube.', 'Tap the button on each beat. For breathing, tap each time the chest rises.'),
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Center(
            child: Text(bpm == null ? '—' : '$bpm',
                style: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: cs.primary)),
          ),
          Center(child: Text(tr('por minuto', 'per minute'))),
          const SizedBox(height: 16),
          GestureDetector(
            onTapDown: (_) => _tap(),
            child: Container(
              height: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.favorite, color: Colors.red, size: 56),
                Text(tr('TOCA EN CADA LATIDO', 'TAP ON EACH BEAT'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
          TextButton(onPressed: () => setState(_taps.clear), child: Text(tr('Reiniciar', 'Reset'))),
          const Divider(),
          Text(tr('Valores normales en reposo', 'Normal values at rest'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          for (final (who, pulse, breath) in [
            (tr('Adulto', 'Adult'), '60–100', '12–20'),
            (tr('Niño (1–10 años)', 'Child (1–10 years)'), '70–130', '18–30'),
            (tr('Bebé (< 1 año)', 'Baby (< 1 year)'), '100–160', '30–60'),
          ])
            ListTile(dense: true, title: Text(who), subtitle: Text(tr('Pulso $pulse · Respiración $breath', 'Pulse $pulse · Breathing $breath', 'Pulso $pulse · Respiração $breath'))),
          Text(
            tr('Pulso muy rápido y débil con piel fría y sudorosa puede ser SHOCK: acuesta a la persona, abrígala y eleva las piernas.', 'A very fast, weak pulse with cold, sweaty skin may be SHOCK: lay the person down, keep them warm and raise their legs.'),
            style: TextStyle(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SOL Y LUNA (cálculo astronómico sin internet)
// =====================================================================
double _rad(double d) => d * pi / 180;
double _deg(double r) => r * 180 / pi;

/// Hora (UTC, en horas decimales) de salida o puesta del sol. null si no ocurre.
double? sunTimeUtc(DateTime date, double lat, double lon, bool rise) {
  final n = date.difference(DateTime.utc(date.year, 1, 1)).inDays + 1;
  final lngHour = lon / 15;
  final t = n + ((rise ? 6 : 18) - lngHour) / 24;
  final m = 0.9856 * t - 3.289;
  var l = m + 1.916 * sin(_rad(m)) + 0.020 * sin(_rad(2 * m)) + 282.634;
  l = (l % 360 + 360) % 360;
  var ra = _deg(atan(0.91764 * tan(_rad(l))));
  ra = (ra % 360 + 360) % 360;
  ra += (l / 90).floor() * 90 - (ra / 90).floor() * 90;
  ra /= 15;
  final sinDec = 0.39782 * sin(_rad(l));
  final cosDec = cos(asin(sinDec));
  final cosH = (cos(_rad(90.833)) - sinDec * sin(_rad(lat))) / (cosDec * cos(_rad(lat)));
  if (cosH > 1 || cosH < -1) return null;
  final h = (rise ? 360 - _deg(acos(cosH)) : _deg(acos(cosH))) / 15;
  final localT = h + ra - 0.06571 * t - 6.622;
  return ((localT - lngHour) % 24 + 24) % 24;
}

/// Edad de la luna en días (0 = luna nueva, ~14,8 = llena).
double moonAge(DateTime now) {
  final ref = DateTime.utc(2000, 1, 6, 18, 14);
  const synodic = 29.530588853;
  final days = now.toUtc().difference(ref).inMinutes / 1440.0;
  return (days % synodic + synodic) % synodic;
}

class SunMoonScreen extends StatefulWidget {
  const SunMoonScreen({super.key});
  @override
  State<SunMoonScreen> createState() => _SunMoonScreenState();
}

class _SunMoonScreenState extends State<SunMoonScreen> {
  double _lat = 4.71, _lon = -74.07; // Bogotá por defecto
  String _where = tr('Bogotá (por defecto)', 'Bogotá (default)');

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final p = await Geolocator.getLastKnownPosition();
      if (p != null && mounted) {
        setState(() {
          _lat = p.latitude;
          _lon = p.longitude;
          _where = tr('Tu última posición GPS', 'Your last GPS position');
        });
      }
    } catch (_) {}
  }

  String _fmt(double? utcH) {
    if (utcH == null) return '—';
    final d = DateTime.now();
    final utc = DateTime.utc(d.year, d.month, d.day).add(Duration(minutes: (utcH * 60).round()));
    final l = utc.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final today = DateTime.utc(now.year, now.month, now.day);
    final rise = sunTimeUtc(today, _lat, _lon, true);
    final set = sunTimeUtc(today, _lat, _lon, false);
    double? leftH;
    if (set != null) {
      final setLocal = today.add(Duration(minutes: (set * 60).round())).toLocal();
      leftH = setLocal.difference(now).inMinutes / 60;
    }
    final age = moonAge(now);
    final illum = (1 - cos(2 * pi * age / 29.530588853)) / 2;
    final phase = switch (age) {
      < 1.85 => (tr('Luna nueva', 'New moon'), '🌑', tr('Noche muy oscura: buena para no ser visto, mala para moverse.', 'Very dark night: good for not being seen, bad for moving.')),
      < 5.54 => (tr('Creciente', 'Waxing crescent'), '🌒', tr('Poca luz al anochecer.', 'Little light at dusk.')),
      < 9.23 => (tr('Cuarto creciente', 'First quarter'), '🌓', tr('Luz la primera mitad de la noche.', 'Light during the first half of the night.')),
      < 12.92 => (tr('Gibosa creciente', 'Waxing gibbous'), '🌔', tr('Bastante luz casi toda la noche.', 'Good light most of the night.')),
      < 16.61 => (tr('Luna llena', 'Full moon'), '🌕', tr('Noche clara: se puede caminar sin linterna, pero también te ven.', 'Bright night: you can walk without a flashlight, but you can also be seen.')),
      < 20.30 => (tr('Gibosa menguante', 'Waning gibbous'), '🌖', tr('Sale tarde; luz en la madrugada.', 'Rises late; light before dawn.')),
      < 23.99 => (tr('Cuarto menguante', 'Last quarter'), '🌗', tr('Luz en la segunda mitad de la noche.', 'Light during the second half of the night.')),
      < 27.68 => (tr('Menguante', 'Waning crescent'), '🌘', tr('Poca luz antes del amanecer.', 'Little light before sunrise.')),
      _ => (tr('Luna nueva', 'New moon'), '🌑', tr('Noche muy oscura.', 'Very dark night.')),
    };
    return Scaffold(
      appBar: AppBar(title: Text(tr('Sol y luna', 'Sun and moon'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(tr('Ubicación: $_where', 'Location: $_where', 'Localização: $_where'), style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  Column(children: [
                    const Icon(Icons.wb_twilight, color: Colors.orange, size: 40),
                    Text(tr('Amanece', 'Sunrise')),
                    Text(_fmt(rise), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  ]),
                  Column(children: [
                    const Icon(Icons.nights_stay, color: Colors.deepPurpleAccent, size: 40),
                    Text(tr('Anochece', 'Sunset')),
                    Text(_fmt(set), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  ]),
                ]),
                const SizedBox(height: 12),
                if (leftH != null)
                  Text(
                    leftH > 0
                        ? tr('Quedan ${leftH.floor()} h ${((leftH % 1) * 60).round()} min de luz', '${leftH.floor()} h ${((leftH % 1) * 60).round()} min of daylight left', 'Restam ${leftH.floor()} h ${((leftH % 1) * 60).round()} min de luz')
                        : tr('Ya es de noche', 'It is already night'),
                    style: TextStyle(fontSize: 18, color: cs.primary, fontWeight: FontWeight.bold),
                  ),
                Text(tr('Planea el refugio, el agua y el fuego antes de que oscurezca.', 'Plan shelter, water and fire before it gets dark.'),
                    style: TextStyle(color: Colors.grey)),
              ]),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Text(phase.$2, style: const TextStyle(fontSize: 56)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(phase.$1, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(tr('Iluminada ${(illum * 100).round()} % · día ${age.toStringAsFixed(0)} de 29', '${(illum * 100).round()} % lit · day ${age.toStringAsFixed(0)} of 29', 'Iluminada ${(illum * 100).round()} % · dia ${age.toStringAsFixed(0)} de 29')),
                    const SizedBox(height: 4),
                    Text(phase.$3),
                  ]),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 8),
          Text(tr('Sin reloj: estira el brazo, cada dedo entre el sol y el horizonte ≈ 15 minutos de luz.', 'No watch: stretch out your arm; each finger between the sun and the horizon ≈ 15 minutes of light.'),
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// =====================================================================
// FICHA MÉDICA
// =====================================================================
class MedicalCardScreen extends StatefulWidget {
  const MedicalCardScreen({super.key});
  @override
  State<MedicalCardScreen> createState() => _MedicalCardScreenState();
}

class _MedicalCardScreenState extends State<MedicalCardScreen> {
  static List<(String, String, IconData)> get _fields => [
    ('name', tr('Nombre completo', 'Full name'), Icons.person),
    ('blood', tr('Tipo de sangre', 'Blood type'), Icons.bloodtype),
    ('allergies', tr('Alergias (medicinas, comida, picaduras)', 'Allergies (medicines, food, stings)'), Icons.warning_amber),
    ('conditions', tr('Enfermedades (diabetes, asma, corazón...)', 'Conditions (diabetes, asthma, heart...)'), Icons.monitor_heart),
    ('meds', tr('Medicamentos que toma y dosis', 'Medications and doses'), Icons.medication),
    ('contact', tr('Contacto de emergencia (nombre y teléfono)', 'Emergency contact (name and phone)'), Icons.phone),
    ('notes', tr('Otras notas', 'Other notes'), Icons.notes),
  ];
  final List<Map<String, dynamic>> _people = Store.jsonList('medical');
  int _sel = 0;
  final Map<String, TextEditingController> _c = {for (final f in _fields) f.$1: TextEditingController()};

  @override
  void initState() {
    super.initState();
    if (_people.isEmpty) _people.add({'name': ''});
    _load();
  }

  void _load() {
    for (final f in _fields) {
      _c[f.$1]!.text = (_people[_sel][f.$1] ?? '') as String;
    }
  }

  Future<void> _save() async {
    for (final f in _fields) {
      _people[_sel][f.$1] = _c[f.$1]!.text.trim();
    }
    await Store.setJsonList('medical', _people);
    if (mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('Ficha guardada en el teléfono', 'Card saved on the phone'))));
    }
  }

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Ficha médica', 'Medical card')), actions: [
        IconButton(icon: const Icon(Icons.save), onPressed: _save),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
              tr('Lo que un rescatista o médico necesita saber si alguien no puede hablar. Se guarda solo en este teléfono.', 'What a rescuer or doctor needs to know if someone can\'t speak. Stored only on this phone.'),
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: [
            for (var i = 0; i < _people.length; i++)
              ChoiceChip(
                label: Text(((_people[i]['name'] ?? '') as String).isEmpty ? tr('Persona ${i + 1}', 'Person ${i + 1}', 'Pessoa ${i + 1}') : _people[i]['name']),
                selected: _sel == i,
                onSelected: (_) {
                  setState(() => _sel = i);
                  _load();
                },
              ),
            ActionChip(
              avatar: const Icon(Icons.add, size: 16),
              label: Text(tr('Agregar persona', 'Add person')),
              onPressed: () {
                setState(() {
                  _people.add({'name': ''});
                  _sel = _people.length - 1;
                });
                _load();
              },
            ),
          ]),
          const SizedBox(height: 12),
          for (final (key, label, icon) in _fields)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _c[key],
                maxLines: key == 'notes' || key == 'meds' ? 3 : 1,
                decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
              ),
            ),
          SizedBox(
            height: 52,
            child: FilledButton.icon(icon: const Icon(Icons.save), label: Text(tr('Guardar', 'Save')), onPressed: _save),
          ),
        ],
      ),
    );
  }
}
