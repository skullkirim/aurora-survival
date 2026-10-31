import 'dart:async';
import 'dart:math';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

import '../core/i18n.dart';

import '../core/torch.dart';
import 'alarms_screen.dart';
import 'community_screen.dart';
import 'extra_tools.dart';
import 'inventory_screen.dart';
import 'power_screen.dart';
import 'recipes_screen.dart';
import 'morse_screen.dart';

export 'extra_tools.dart' show WhistleScreen;
export 'morse_screen.dart' show MorseFlashScreen;

class ToolItem {
  final IconData icon;
  final String label;
  final String help;
  final Widget Function() page;
  const ToolItem(this.icon, this.label, this.help, this.page);
}

/// Grupos de herramientas para que sea fácil encontrarlas.
List<(String, List<ToolItem>)> get toolGroups => [
  (tr('Pedir ayuda y señales', 'Call for help and signals'), [
    ToolItem(Icons.sos, tr('SOS rápido', 'Quick SOS'), tr('Pide auxilio con la linterna en un toque', 'Call for help with the flashlight in one tap'),
        () => const MorseFlashScreen(initial: 'SOS')),
    ToolItem(Icons.campaign, tr('Silbato', 'Whistle'), tr('Sonido agudo muy fuerte o SOS sonoro', 'Very loud high-pitched sound or sound SOS'), () => const WhistleScreen()),
    ToolItem(Icons.graphic_eq, tr('Código Morse', 'Morse code'), tr('Escribe una palabra y envíala con luz o sonido', 'Type a word and send it with light or sound'),
        () => const MorseFlashScreen(initial: '')),
    ToolItem(Icons.light_mode_outlined, tr('Pantalla señal', 'Signal screen'), tr('La pantalla brilla de colores para que te vean', 'The screen glows in colors so you can be seen'),
        () => const SignalScreen()),
    ToolItem(Icons.flare, tr('Estroboscópica', 'Strobe'), tr('Destellos para ser encontrado de noche', 'Flashes to be found at night'), () => const StrobeScreen()),
  ]),
  (tr('Salud', 'Health'), [
    ToolItem(Icons.favorite, tr('Ritmo de RCP', 'CPR rhythm'), tr('Metrónomo de 110 por minuto con aviso de ventilaciones', '110-per-minute metronome with breath reminders'),
        () => const CprScreen()),
    ToolItem(Icons.monitor_heart, tr('Pulso y respiración', 'Pulse and breathing'), tr('Mide latidos tocando la pantalla', 'Measure heartbeats by tapping the screen'), () => const PulseScreen()),
    ToolItem(Icons.badge, tr('Ficha médica', 'Medical card'), tr('Sangre, alergias y medicinas de tu familia', 'Blood type, allergies and medicines for your family'), () => const MedicalCardScreen()),
    ToolItem(Icons.alarm, tr('Alarmas', 'Alarms', 'Alarmes'),
        tr('Medicinas, torniquete y turnos de guardia', 'Medicines, tourniquet and guard shifts', 'Remédios, torniquete e turnos de guarda'), () => const AlarmsScreen()),
  ]),
  (tr('Orientarse', 'Navigation'), [
    ToolItem(Icons.explore_outlined, tr('Brújula', 'Compass'), tr('Saber dónde está el norte', 'Find north'), () => const CompassScreen()),
    ToolItem(Icons.wb_twilight, tr('Sol y luna', 'Sun and moon'), tr('Horas de luz que quedan y fase de la luna', 'Daylight left and moon phase'), () => const SunMoonScreen()),
    ToolItem(Icons.flashlight_on_outlined, tr('Linterna', 'Flashlight'), tr('Enciende el flash del teléfono', 'Turn on the phone\'s flash'), () => const FlashlightScreen()),
  ]),
  (tr('Provisiones y cálculos', 'Supplies and calculators'), [
    ToolItem(Icons.inventory_2_outlined, tr('Provisiones', 'Supplies'), tr('Tu comida, agua, diario y mochila', 'Your food, water, journal and backpack'), () => const InventoryScreen()),
    ToolItem(Icons.restaurant_menu, tr('Recetas', 'Recipes', 'Receitas'),
        tr('Qué cocinar con lo que tienes en la despensa', 'What to cook with what is in your pantry', 'O que cozinhar com o que tem na despensa'), () => const RecipesScreen()),
    ToolItem(Icons.wifi_tethering, tr('Modo comunidad', 'Community mode', 'Modo comunidade'),
        tr('Comparte provisiones y personas con teléfonos cercanos sin internet', 'Share supplies and people with nearby phones, no internet',
            'Compartilhe provisões e pessoas com telefones próximos sem internet'), () => const CommunityScreen()),
    ToolItem(Icons.calculate_outlined, tr('Raciones', 'Rations'), tr('Cuánta agua y comida necesitan', 'How much water and food you need'), () => const RationScreen()),
    ToolItem(Icons.warning_amber_rounded, tr('Radiación', 'Radiation'), tr('Cuánto esperar en el refugio tras una bomba', 'How long to shelter after a bomb'),
        () => const RadiationScreen()),
  ]),
  (tr('Batería', 'Battery'), [
    ToolItem(Icons.energy_savings_leaf, tr('Ahorro de batería', 'Battery saver'), tr('60 Hz, brillo, atenuado y ahorro extremo', '60 Hz, brightness, dimming and extreme saving'),
        () => const PowerScreen()),
    ToolItem(Icons.battery_charging_full, tr('Estado de la batería', 'Battery status'), tr('Nivel y trucos para que dure más', 'Level and tips to make it last'),
        () => const BatteryScreen()),
  ]),
];

List<ToolItem> get allTools => [for (final g in toolGroups) ...g.$2];

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(tr('Herramientas', 'Tools'),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cs.primary)),
        Text(tr('Toca una herramienta para usarla. Todas funcionan sin internet.', 'Tap a tool to use it. All of them work offline.')),
        const SizedBox(height: 12),
        for (final (group, items) in toolGroups) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
            child: Text(group, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.25,
            children: [
              for (final t in items)
                Card(
                  margin: EdgeInsets.zero,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => t.page())),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: cs.primary.withValues(alpha: 0.15),
                          child: Icon(t.icon, color: cs.primary, size: 26),
                        ),
                        const Spacer(),
                        Text(t.label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(t.help,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ]),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------
// Linterna
// ---------------------------------------------------------------------
class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({super.key});
  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool _on = false;
  String? _error;

  Future<void> _toggle() async {
    final ok = await setTorch(!_on);
    setState(() {
      if (ok) {
        _on = !_on;
        _error = null;
      } else {
        _error = tr('No se pudo usar el flash. Usa "Pantalla señal".', 'Could not use the flash. Use "Signal screen".');
      }
    });
  }

  @override
  void dispose() {
    if (_on) setTorch(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Linterna', 'Flashlight'))),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: _toggle,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _on ? Colors.amber : const Color(0xFF333333), width: 6),
              ),
              child: Icon(Icons.power_settings_new,
                  size: 100, color: _on ? Colors.amber : const Color(0xFF555555)),
            ),
          ),
          const SizedBox(height: 16),
          Text(_on ? tr('ENCENDIDA', 'ON') : tr('APAGADA  (toca el botón)', 'OFF  (tap the button)'), style: const TextStyle(fontSize: 20)),
          if (_error != null)
            Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_error!, style: const TextStyle(color: Colors.red))),
          Padding(
            padding: EdgeInsets.all(24),
            child: Text(tr('La linterna gasta batería. Úsala a ratos y se apaga sola al salir.', 'The flashlight uses battery. Use it in bursts; it turns off when you leave.'),
                textAlign: TextAlign.center),
          ),
        ]),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Estroboscópica
// ---------------------------------------------------------------------
class StrobeScreen extends StatefulWidget {
  const StrobeScreen({super.key});
  @override
  State<StrobeScreen> createState() => _StrobeScreenState();
}

class _StrobeScreenState extends State<StrobeScreen> {
  Timer? _timer;
  bool _on = false;
  double _hz = 2;

  void _toggle() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      setTorch(false);
      setState(() {});
      return;
    }
    _timer = Timer.periodic(Duration(milliseconds: (500 / _hz).round()), (_) {
      _on = !_on;
      setTorch(_on);
    });
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    setTorch(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Estroboscópica', 'Strobe'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text(tr('Destellos visibles a gran distancia. Útil para que te encuentren de noche.', 'Flashes visible from far away. Useful to be found at night.')),
          const SizedBox(height: 16),
          Text(tr('${_hz.toStringAsFixed(1)} destellos por segundo', '${_hz.toStringAsFixed(1)} flashes per second', '${_hz.toStringAsFixed(1)} flashes por segundo')),
          Slider(
            min: 0.5,
            max: 8,
            divisions: 15,
            value: _hz,
            onChanged: _timer != null ? null : (v) => setState(() => _hz = v),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 64,
            child: FilledButton(
              onPressed: _toggle,
              child: Text(_timer != null ? tr('DETENER', 'STOP') : tr('INICIAR', 'START'), style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
              tr('⚠ Las luces intermitentes rápidas pueden provocar convulsiones en personas con epilepsia fotosensible.', '⚠ Fast flashing lights can trigger seizures in people with photosensitive epilepsy.'),
              style: TextStyle(color: Colors.orange)),
        ]),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Pantalla de señal
// ---------------------------------------------------------------------
class SignalScreen extends StatefulWidget {
  const SignalScreen({super.key});
  @override
  State<SignalScreen> createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  static const _colors = [Colors.white, Colors.red, Colors.green, Colors.orange, Colors.blue];
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _i = (_i + 1) % _colors.length),
      onLongPress: () => Navigator.pop(context),
      child: Container(
        color: _colors[_i],
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(32),
        child: Text(
          tr('Toca: cambiar color · Mantén presionado: salir\nSube el brillo al máximo para ser visto', 'Tap: change color · Long-press: exit\nTurn brightness all the way up to be seen'),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 14, decoration: TextDecoration.none),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Brújula (el sensor solo se usa mientras esta pantalla está abierta)
// ---------------------------------------------------------------------
String cardinal(double deg) {
  final names = isEn
      ? const ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
      : isPt
          ? const ['N', 'NE', 'L', 'SE', 'S', 'SO', 'O', 'NO']
          : const ['N', 'NE', 'E', 'SE', 'S', 'SO', 'O', 'NO']; // pt: L = leste
  return names[((deg % 360) / 45).round() % 8];
}

class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = FlutterCompass.events;
    return Scaffold(
      appBar: AppBar(title: Text(tr('Brújula', 'Compass'))),
      body: stream == null
          ? Center(child: Text(tr('Este teléfono no tiene magnetómetro.', 'This phone has no magnetometer.')))
          : StreamBuilder<CompassEvent>(
              stream: stream,
              builder: (context, snap) {
                final h = snap.data?.heading;
                if (h == null) {
                  return Center(
                      child: Text(tr('Esperando sensor...\nMueve el teléfono en forma de 8 para calibrar.', 'Waiting for sensor...\nMove the phone in a figure 8 to calibrate.'),
                          textAlign: TextAlign.center));
                }
                final deg = (h + 360) % 360;
                return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('${deg.round()}° ${cardinal(deg)}',
                      style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CustomPaint(painter: CompassPainter(deg, Theme.of(context).colorScheme.primary)),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                        tr('La N roja apunta al norte. Mantén el teléfono plano, lejos de metales e imanes.', 'The red N points north. Keep the phone flat, away from metal and magnets.'),
                        textAlign: TextAlign.center),
                  ),
                ]);
              },
            ),
    );
  }
}

class CompassPainter extends CustomPainter {
  final double heading;
  final Color accent;

  /// Si [target] no es null, dibuja una flecha hacia ese rumbo (grados).
  final double? target;
  CompassPainter(this.heading, this.accent, {this.target});

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 - 4;
    final ring = Paint()
      ..color = const Color(0xFF444444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(c, r, ring);

    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(-heading * pi / 180);
    final tick = Paint()..color = const Color(0xFF888888);
    for (var d = 0; d < 360; d += 15) {
      final a = d * pi / 180;
      final long = d % 90 == 0;
      tick.strokeWidth = long ? 3 : 1;
      final p1 = Offset(sin(a) * r, -cos(a) * r);
      final p2 = Offset(sin(a) * (r - (long ? 20 : 10)), -cos(a) * (r - (long ? 20 : 10)));
      canvas.drawLine(p1, p2, tick);
    }
    final labels = {'N': 0, (isPt ? 'L' : 'E'): 90, 'S': 180, (isEn ? 'W' : 'O'): 270};
    labels.forEach((t, d) {
      final a = d * pi / 180;
      final tp = TextPainter(
        text: TextSpan(
            text: t,
            style: TextStyle(
                color: t == 'N' ? Colors.red : Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
      )..layout();
      final pos = Offset(sin(a) * (r - 40), -cos(a) * (r - 40));
      tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
    });
    if (target != null) {
      final a = target! * pi / 180;
      final tip = Offset(sin(a) * (r - 55), -cos(a) * (r - 55));
      final arrow = Paint()
        ..color = accent
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset.zero, tip, arrow);
      canvas.drawCircle(tip, 10, Paint()..color = accent);
    }
    canvas.restore();

    final path = Path()
      ..moveTo(c.dx, c.dy - r - 2)
      ..lineTo(c.dx - 10, c.dy - r + 18)
      ..lineTo(c.dx + 10, c.dy - r + 18)
      ..close();
    canvas.drawPath(path, Paint()..color = accent);
  }

  @override
  bool shouldRepaint(CompassPainter old) =>
      old.heading != heading || old.target != target || old.accent != accent;
}

// ---------------------------------------------------------------------
// Batería
// ---------------------------------------------------------------------
class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});
  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  final _battery = Battery();
  int? _level;
  BatteryState? _state;
  bool? _saver;
  StreamSubscription<BatteryState>? _sub;

  @override
  void initState() {
    super.initState();
    _read();
    _sub = _battery.onBatteryStateChanged.listen((s) {
      _state = s;
      _read();
    });
  }

  Future<void> _read() async {
    try {
      final l = await _battery.batteryLevel;
      final s = await _battery.isInBatterySaveMode;
      if (mounted) {
        setState(() {
          _level = l;
          _saver = s;
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lvl = _level ?? 0;
    final color = lvl > 50 ? Colors.green : lvl > 20 ? Colors.orange : Colors.red;
    final stateText = switch (_state) {
      BatteryState.charging => tr('Cargando', 'Charging'),
      BatteryState.full => tr('Llena', 'Full'),
      BatteryState.discharging => tr('Descargando', 'Discharging'),
      _ => '—',
    };
    return Scaffold(
      appBar: AppBar(title: Text(tr('Batería', 'Battery'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(_level == null ? '...' : '$lvl %',
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: color)),
          ),
          Center(child: Text(stateText)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: lvl / 100, color: color, minHeight: 12),
          const SizedBox(height: 8),
          if (_saver == false)
            Text(tr('⚠ El ahorro de batería del sistema está APAGADO. Actívalo en Ajustes.', '⚠ The system battery saver is OFF. Turn it on in Settings.'),
                style: TextStyle(color: Colors.orange)),
          if (_saver == true) Text(tr('✔ Ahorro de batería activo.', '✔ Battery saver on.'), style: TextStyle(color: Colors.green)),
          const SizedBox(height: 16),
          Text(tr('Cómo estirar la batería', 'How to stretch the battery'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (final t in [
            tr('Modo avión cuando no esperes señal: buscar antena es lo que más gasta.', 'Airplane mode when you expect no signal: searching for a tower drains the most.'),
            tr('Brillo al mínimo. Esta app usa negro puro: en pantallas AMOLED los píxeles negros no gastan.', 'Minimum brightness. This app uses pure black: black pixels use no power on AMOLED screens.'),
            tr('Apaga Bluetooth, Wi-Fi, datos y GPS cuando no los uses.', 'Turn off Bluetooth, Wi-Fi, data and GPS when not in use.'),
            tr('El GPS de esta app solo se enciende cuando lo pides o grabas una ruta.', 'This app\'s GPS only turns on when you ask or record a route.'),
            tr('Mantén el celular entre 20 % y 80 %; el frío y el calor extremos dañan la batería.', 'Keep the phone between 20 % and 80 %; extreme cold and heat damage the battery.'),
            tr('Guarda el teléfono cerca del cuerpo en clima frío.', 'Keep the phone close to your body in cold weather.'),
            tr('Carga con panel solar o batería externa durante el día.', 'Charge with a solar panel or power bank during the day.'),
            tr('Apaga el teléfono por completo si no lo necesitarás en horas.', 'Turn the phone off completely if you won\'t need it for hours.'),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('•  '),
                Expanded(child: Text(t)),
              ]),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Calculadora de raciones
// ---------------------------------------------------------------------
class RationScreen extends StatefulWidget {
  const RationScreen({super.key});
  @override
  State<RationScreen> createState() => _RationScreenState();
}

class _RationScreenState extends State<RationScreen> {
  int _people = 2;
  int _days = 14;
  bool _hot = true;
  bool _work = false;

  @override
  Widget build(BuildContext context) {
    final water = (_hot ? 5.0 : 4.0) * _people * _days;
    final kcal = (_work ? 2800 : 2000) * _people * _days;
    final rice = kcal * 0.45 / 3600;
    final beans = kcal * 0.25 / 3400;
    final oil = kcal * 0.15 / 8800;
    final panela = kcal * 0.15 / 3500;
    final salt = 0.01 * _people * _days;
    Widget row(String a, String b) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(children: [
            Expanded(child: Text(a, style: const TextStyle(fontSize: 16))),
            Text(b, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ]),
        );
    return Scaffold(
      appBar: AppBar(title: Text(tr('Calculadora de raciones', 'Ration calculator'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(tr('Personas: $_people', 'People: $_people', 'Pessoas: $_people')),
          Slider(min: 1, max: 30, divisions: 29, value: _people.toDouble(),
              onChanged: (v) => setState(() => _people = v.round())),
          Text(tr('Días: $_days', 'Days: $_days', 'Dias: $_days')),
          Slider(min: 1, max: 180, divisions: 179, value: _days.toDouble(),
              onChanged: (v) => setState(() => _days = v.round())),
          SwitchListTile(title: Text(tr('Clima cálido', 'Hot climate')), value: _hot, onChanged: (v) => setState(() => _hot = v)),
          SwitchListTile(
              title: Text(tr('Trabajo físico pesado', 'Heavy physical work')), value: _work, onChanged: (v) => setState(() => _work = v)),
          const Divider(),
          row(tr('Agua (beber, cocinar, higiene)', 'Water (drinking, cooking, hygiene)'), '${water.round()} L'),
          row(tr('Energía total', 'Total energy'), tr('${(kcal / 1000).round()} mil kcal', '${(kcal / 1000).round()} thousand kcal', '${(kcal / 1000).round()} mil kcal')),
          const SizedBox(height: 8),
          Text(tr('Despensa aproximada:', 'Approximate pantry:'), style: TextStyle(fontWeight: FontWeight.bold)),
          row(tr('Arroz / avena / maíz', 'Rice / oats / corn'), '${rice.toStringAsFixed(1)} kg'),
          row(tr('Fríjol / lenteja', 'Beans / lentils'), '${beans.toStringAsFixed(1)} kg'),
          row(tr('Aceite', 'Oil'), '${oil.toStringAsFixed(1)} L'),
          row(tr('Panela / azúcar / miel', 'Raw sugar / sugar / honey'), '${panela.toStringAsFixed(1)} kg'),
          row(tr('Sal', 'Salt'), '${salt.toStringAsFixed(1)} kg'),
          const SizedBox(height: 12),
          Text(
              tr('Valores orientativos. Añade frutas, verduras o multivitamínicos para evitar carencias en estancias largas.', 'Rough values. Add fruit, vegetables or multivitamins to avoid deficiencies over long periods.'),
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Radiación: regla 7-10 (decaimiento de la lluvia radiactiva)
// ---------------------------------------------------------------------
class RadiationScreen extends StatefulWidget {
  const RadiationScreen({super.key});
  @override
  State<RadiationScreen> createState() => _RadiationScreenState();
}

class _RadiationScreenState extends State<RadiationScreen> {
  double _hours = 1; // horas desde la explosión
  double _pf = 10; // factor de protección del refugio

  /// Fracción de la radiación de la hora 1 que queda en la hora t (ley t^-1.2).
  double _frac(double t) => pow(t, -1.2).toDouble();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final now = _frac(_hours) * 100;
    final shelters = <(String, double)>[
      (tr('Carro o casa de madera', 'Car or wooden house'), 2),
      (tr('Casa de ladrillo, primer piso', 'Brick house, ground floor'), 10),
      (tr('Centro de un edificio grande', 'Center of a large building'), 40),
      (tr('Sótano o subterráneo', 'Basement or underground'), 100),
    ];
    String fmtH(double h) => h < 48 ? '${h.round()} h' : tr('${(h / 24).toStringAsFixed(1)} días', '${(h / 24).toStringAsFixed(1)} days', '${(h / 24).toStringAsFixed(1)} dias');
    return Scaffold(
      appBar: AppBar(title: Text(tr('Radiación: cuánto esperar', 'Radiation: how long to wait'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            tr('Tras una explosión nuclear, el polvo radiactivo (lluvia radiactiva) pierde fuerza muy rápido. ', 'After a nuclear explosion, radioactive dust (fallout) loses strength very quickly. ') +
            tr('Regla 7-10: cada vez que el tiempo se multiplica por 7, la radiación baja 10 veces.', '7-10 rule: every time the elapsed time is multiplied by 7, radiation drops 10 times.'),
          ),
          const SizedBox(height: 16),
          Text(tr('Tiempo desde la explosión: ${fmtH(_hours)}', 'Time since the blast: ${fmtH(_hours)}', 'Tempo desde a explosão: ${fmtH(_hours)}'),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            min: 1,
            max: 336,
            value: _hours,
            onChanged: (v) => setState(() => _hours = v),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Text('${now < 1 ? now.toStringAsFixed(2) : now.toStringAsFixed(0)} %',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: cs.primary)),
                Text(tr('de la radiación que había 1 hora después de la explosión', 'of the radiation present 1 hour after the blast')),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          Text(tr('Regla 7-10', '7-10 rule'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          for (final (h, label) in [(1.0, tr('1 hora', '1 hour')), (7.0, tr('7 horas', '7 hours')), (49.0, tr('2 días', '2 days')), (343.0, tr('2 semanas', '2 weeks'))])
            ListTile(
              dense: true,
              title: Text(label),
              trailing: Text('${(_frac(h) * 100).toStringAsFixed(h > 40 ? 1 : 0)} %'),
            ),
          const Divider(),
          Text(tr('Tu refugio', 'Your shelter'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          for (final (name, pf) in shelters)
            ListTile(
              dense: true,
              leading: Icon(_pf == pf ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: _pf == pf ? cs.primary : null),
              title: Text(name),
              subtitle: Text(tr('Recibes ~${(100 / pf).round()} % de la radiación de afuera', 'You get ~${(100 / pf).round()} % of the outside radiation', 'Você recebe ~${(100 / pf).round()} % da radiação de fora')),
              onTap: () => setState(() => _pf = pf),
            ),
          const SizedBox(height: 8),
          Text(
              tr('Dentro de tu refugio recibes ahora ~${(now / _pf).toStringAsFixed(now / _pf < 1 ? 2 : 1)} % ', 'Inside your shelter you now get ~${(now / _pf).toStringAsFixed(now / _pf < 1 ? 2 : 1)} % ', 'Dentro do seu abrigo você recebe agora ~${(now / _pf).toStringAsFixed(now / _pf < 1 ? 2 : 1)} % ') +
              tr('de lo que habría afuera en la hora 1.', 'of what there was outside at hour 1.')),
          const SizedBox(height: 8),
          Text(
            _hours < 24
                ? tr('➜ Quédate dentro. Las primeras 24 horas son las más peligrosas.', '➜ Stay inside. The first 24 hours are the most dangerous.')
                : _hours < 72
                    ? tr('➜ Sal solo para emergencias cortas (agua, ayuda médica), cubierto y lavándote al volver.', '➜ Go out only for short emergencies (water, medical help), covered up, and wash when you return.')
                    : tr('➜ La radiación ya bajó mucho. Sigue las indicaciones de las autoridades; limita el tiempo afuera.', '➜ Radiation has dropped a lot. Follow the authorities; limit time outside.'),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: cs.primary),
          ),
          const SizedBox(height: 12),
          Text(
            tr('Estimación educativa. Un medidor (dosímetro) y las autoridades dan la información real.', 'Educational estimate. A meter (dosimeter) and the authorities give the real information.'),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
