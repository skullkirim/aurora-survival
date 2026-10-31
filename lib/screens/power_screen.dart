import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

import '../core/i18n.dart';

import '../core/power.dart';
import '../core/storage.dart';
import '../main.dart' show redMode;

/// Ahorro de energía: todo lo que la app puede hacer para gastar menos.
class PowerScreen extends StatefulWidget {
  const PowerScreen({super.key});
  @override
  State<PowerScreen> createState() => _PowerScreenState();
}

class _PowerScreenState extends State<PowerScreen> {
  int? _level;
  bool? _saver;

  @override
  void initState() {
    super.initState();
    final b = Battery();
    b.batteryLevel.then((v) {
      if (mounted) setState(() => _level = v);
    }).catchError((_) {});
    b.isInBatterySaveMode.then((v) {
      if (mounted) setState(() => _saver = v);
    }).catchError((_) {});
  }

  Future<void> _extreme() async {
    await Power.setLowRefresh(true);
    await Power.setBrightness(15);
    await Power.setDimAfter(30);
    redMode.value = true;
    await Store.setRedMode(true);
    if (mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr('Ahorro extremo activado: 60 Hz, brillo 15 %, atenuar a los 30 s, modo rojo', 'Extreme saving on: 60 Hz, brightness 15 %, dim after 30 s, red mode'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bright = Power.brightness;
    final dim = Power.dimAfter;
    final lvl = _level;
    return Scaffold(
      appBar: AppBar(title: Text(tr('Ahorro de batería', 'Battery saver'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (lvl != null)
            Row(children: [
              Icon(Icons.battery_std, size: 40, color: lvl > 30 ? Colors.green : Colors.red),
              const SizedBox(width: 8),
              Text('$lvl %', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const Spacer(),
              if (_saver == true)
                Chip(label: Text(tr('Ahorro del sistema: ON', 'System saver: ON')))
              else if (_saver == false)
                Chip(label: Text(tr('Ahorro del sistema: OFF', 'System saver: OFF'))),
            ]),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: FilledButton.icon(
              icon: const Icon(Icons.energy_savings_leaf, size: 28),
              label: Text(tr('ACTIVAR AHORRO EXTREMO', 'TURN ON EXTREME SAVING'), style: TextStyle(fontSize: 18)),
              onPressed: _extreme,
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            secondary: const Icon(Icons.speed),
            title: Text(tr('Pantalla a 60 Hz', 'Screen at 60 Hz')),
            subtitle: Text(
                tr('Tu pantalla puede ir a 120 Hz: eso gasta mucho más. Recomendado: activado.', 'Your screen can run at 120 Hz: that uses much more power. Recommended: on.')),
            value: Power.lowRefresh,
            onChanged: (v) async {
              await Power.setLowRefresh(v);
              setState(() {});
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(tr('Brillo dentro de la app', 'In-app brightness')),
            subtitle: Text(bright == 0 ? tr('Igual que el sistema', 'Same as system') : '$bright %'),
          ),
          Slider(
            min: 0,
            max: 100,
            divisions: 20,
            value: bright.toDouble(),
            label: bright == 0 ? tr('Sistema', 'System') : '$bright %',
            onChanged: (v) async {
              await Power.setBrightness(v.round());
              setState(() {});
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: Text(tr('Atenuar la pantalla si no la tocas', 'Dim the screen when idle')),
            subtitle: Text(tr('Se oscurece casi por completo; vuelve al tocarla.', 'It goes almost dark; touch to restore.')),
          ),
          Wrap(spacing: 8, children: [
            for (final s in [0, 15, 30, 60])
              ChoiceChip(
                label: Text(s == 0 ? tr('Nunca', 'Never') : '$s s'),
                selected: dim == s,
                onSelected: (_) async {
                  await Power.setDimAfter(s);
                  setState(() {});
                },
              ),
          ]),
          const Divider(),
          SwitchListTile(
            secondary: const Icon(Icons.nightlight),
            title: Text(tr('Modo rojo nocturno', 'Red night mode')),
            subtitle: Text(tr('Protege tu visión de noche y se nota menos desde lejos.', 'Protects your night vision and is less visible from afar.')),
            value: redMode.value,
            onChanged: (v) async {
              redMode.value = v;
              await Store.setRedMode(v);
              setState(() {});
            },
          ),
          const SizedBox(height: 16),
          Text(tr('Qué gasta más batería', 'What drains the battery most'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)),
          const SizedBox(height: 8),
          for (final (icon, t) in [
            (Icons.light_mode, tr('La pantalla encendida (brillo y 120 Hz). Esta app usa fondo negro: en tu pantalla AMOLED el negro no gasta.', 'The screen being on (brightness and 120 Hz). This app uses a black background: black pixels use no power on AMOLED screens.')),
            (Icons.signal_cellular_alt, tr('Buscar señal cuando no hay: pon MODO AVIÓN. El GPS sigue funcionando en modo avión.', 'Searching for signal when there is none: use AIRPLANE MODE. GPS still works in airplane mode.')),
            (Icons.gps_fixed, tr('El GPS: la app solo lo usa cuando lo pides o mientras grabas ruta.', 'GPS: the app only uses it when you ask or while recording a route.')),
            (Icons.flashlight_on, tr('La linterna y el sonido del silbato: úsalos a ratos.', 'The flashlight and whistle sound: use them in bursts.')),
            (Icons.ac_unit, tr('El frío descarga la batería: lleva el teléfono pegado al cuerpo.', 'Cold drains the battery: keep the phone close to your body.')),
            (Icons.power_settings_new, tr('Si no lo vas a usar en horas, apágalo por completo.', 'If you won\'t use it for hours, turn it off completely.')),
          ])
            ListTile(dense: true, leading: Icon(icon, color: cs.primary), title: Text(t)),
          const SizedBox(height: 8),
          Text(
            tr('Referencia: con la pantalla encendida un teléfono gasta normalmente entre 8 y 15 % por hora. ', 'Reference: with the screen on, a phone normally uses 8–15 % per hour. ') +
            tr('Con 60 Hz, brillo bajo y modo avión puedes bajar a la mitad.', 'With 60 Hz, low brightness and airplane mode you can halve that.'),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
