import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../core/i18n.dart';
import '../core/morse.dart';
import '../core/power.dart';
import '../core/torch.dart';

/// Baliza SOS automática: repite SOS con la linterna (y sonido) cada cierto tiempo.
/// La pantalla queda negra al mínimo de brillo para gastar lo menos posible.
class BeaconScreen extends StatefulWidget {
  const BeaconScreen({super.key});
  @override
  State<BeaconScreen> createState() => _BeaconScreenState();
}

class _BeaconScreenState extends State<BeaconScreen> {
  int _everySec = 60;
  bool _sound = true;
  bool _running = false;
  bool _sending = false;
  int _count = 0;
  DateTime? _next;
  Timer? _timer;
  Timer? _tick;
  final _player = AudioPlayer();

  static const _unit = 200; // ms por unidad Morse (lento = se ve mejor de lejos)

  Future<void> _sendOnce() async {
    if (_sending) return;
    _sending = true;
    final tl = morseTimeline('SOS');
    if (_sound) {
      try {
        await _player.play(BytesSource(morseWav(tl, unitMs: _unit)));
      } catch (_) {}
    }
    for (final (on, units) in tl) {
      if (!_running) break;
      if (on) await setTorch(true);
      await Future.delayed(Duration(milliseconds: units * _unit));
      if (on) await setTorch(false);
    }
    await setTorch(false);
    _sending = false;
    if (mounted) setState(() => _count++);
  }

  Future<void> _start() async {
    setState(() {
      _running = true;
      _count = 0;
    });
    await Power.keepScreenOn(true);
    await Power.rawBrightness(1);
    _sendOnce();
    _next = DateTime.now().add(Duration(seconds: _everySec));
    _timer = Timer.periodic(Duration(seconds: _everySec), (_) {
      _next = DateTime.now().add(Duration(seconds: _everySec));
      _sendOnce();
    });
    _tick = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _tick?.cancel();
    _timer = null;
    _running = false;
    await setTorch(false);
    await _player.stop();
    await Power.keepScreenOn(false);
    await Power.rawBrightness(Power.brightness);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tick?.cancel();
    _running = false;
    setTorch(false);
    _player.dispose();
    Power.keepScreenOn(false);
    Power.rawBrightness(Power.brightness);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_running) {
      final left = _next == null ? 0 : _next!.difference(DateTime.now()).inSeconds.clamp(0, 99999);
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: GestureDetector(
            onLongPress: _stop,
            child: SizedBox.expand(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('SOS', style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(0xFF7F0000))),
                Text(tr('Enviados: $_count · próximo en $left s', 'Sent: $_count · next in $left s', 'Enviados: $_count · próximo em $left s'),
                    style: const TextStyle(color: Color(0xFF555555))),
                const SizedBox(height: 40),
                Text(tr('Mantén presionado para detener', 'Long-press to stop', 'Pressione e segure para parar'),
                    style: const TextStyle(color: Color(0xFF444444))),
              ]),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(tr('Baliza SOS automática', 'Automatic SOS beacon', 'Baliza SOS automática'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(tr(
              'Deja el teléfono en un lugar alto y visible: repetirá SOS con la linterna (y sonido) solo. La pantalla queda negra al mínimo para ahorrar batería.',
              'Leave the phone somewhere high and visible: it will repeat SOS with the flashlight (and sound) by itself. The screen stays black at minimum to save battery.',
              'Deixe o telefone num lugar alto e visível: ele repetirá SOS com a lanterna (e som) sozinho. A tela fica preta no mínimo para economizar bateria.')),
          const SizedBox(height: 16),
          Text(tr('Repetir cada', 'Repeat every', 'Repetir a cada'), style: const TextStyle(fontWeight: FontWeight.bold)),
          Wrap(spacing: 8, children: [
            for (final s in [30, 60, 120, 300, 600])
              ChoiceChip(
                label: Text(s < 60 ? '$s s' : '${s ~/ 60} min'),
                selected: _everySec == s,
                onSelected: (_) => setState(() => _everySec = s),
              ),
          ]),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(tr('También con sonido', 'Also with sound', 'Também com som')),
            value: _sound,
            onChanged: (v) => setState(() => _sound = v),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 64,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB71C1C), foregroundColor: Colors.white),
              icon: const Icon(Icons.sos, size: 30),
              label: Text(tr('INICIAR BALIZA', 'START BEACON', 'INICIAR BALIZA'), style: const TextStyle(fontSize: 18)),
              onPressed: _start,
            ),
          ),
          const SizedBox(height: 16),
          Text(
              tr('Cada 1 minuto gasta poco: la linterna se enciende unos 6 segundos. Cada 5–10 minutos dura toda la noche.',
                  'Every minute uses little: the flashlight is on for about 6 seconds. Every 5–10 minutes lasts all night.',
                  'A cada 1 minuto gasta pouco: a lanterna fica acesa uns 6 segundos. A cada 5–10 minutos dura a noite toda.'),
              style: const TextStyle(color: Colors.grey)),
          Text(
              tr('No apagues la pantalla con el botón: si se bloquea, la baliza se detiene.', 'Don\'t lock the screen with the button: if it locks, the beacon stops.',
                  'Não bloqueie a tela pelo botão: se bloquear, a baliza para.'),
              style: const TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }
}
