import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../core/i18n.dart';

import '../core/morse.dart';
import '../core/torch.dart';

/// Morse completo: escribir → morse, morse → texto, practicar y tabla.
/// (Se mantiene el nombre MorseFlashScreen por compatibilidad.)
class MorseFlashScreen extends StatelessWidget {
  final String initial;
  final int initialTab;
  const MorseFlashScreen({super.key, this.initial = 'SOS', this.initialTab = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: initialTab,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('Código Morse', 'Morse code')),
          bottom: TabBar(isScrollable: true, tabs: [
            Tab(icon: Icon(Icons.edit), text: tr('Escribir', 'Write')),
            Tab(icon: Icon(Icons.hearing), text: tr('Descifrar', 'Decode')),
            Tab(icon: Icon(Icons.school), text: tr('Practicar', 'Practice')),
            Tab(icon: Icon(Icons.grid_on), text: tr('Tabla', 'Chart')),
          ]),
        ),
        body: TabBarView(children: [
          _WriteTab(initial: initial),
          const _ReadTab(),
          const _PracticeTab(),
          const _TableTab(),
        ]),
      ),
    );
  }
}

/// Reproduce un sonido morse breve (para tabla y práctica).
class _Beeper {
  final AudioPlayer _p = AudioPlayer();
  Future<void> play(String text, {int unitMs = 90}) async {
    try {
      await _p.stop();
      await _p.play(BytesSource(morseWav(morseTimeline(text), unitMs: unitMs)));
    } catch (_) {}
  }

  Future<void> stop() async {
    try {
      await _p.stop();
    } catch (_) {}
  }

  void dispose() => _p.dispose();
}

// ---------------------------------------------------------------------
// 1. ESCRIBIR: texto -> morse y transmitir
// ---------------------------------------------------------------------
class _WriteTab extends StatefulWidget {
  final String initial;
  const _WriteTab({required this.initial});
  @override
  State<_WriteTab> createState() => _WriteTabState();
}

class _WriteTabState extends State<_WriteTab> {
  late final TextEditingController _txt = TextEditingController(text: widget.initial);
  final AudioPlayer _player = AudioPlayer();
  bool _sound = true, _flash = false, _screen = false, _loop = false;
  bool _running = false, _lit = false;
  int _unitMs = 150;

  Future<void> _transmit() async {
    if (_running) {
      _running = false;
      await _player.stop();
      await setTorch(false);
      setState(() => _lit = false);
      return;
    }
    final tl = morseTimeline(_txt.text);
    if (tl.isEmpty) return;
    setState(() => _running = true);
    final wav = morseWav(tl, unitMs: _unitMs);
    do {
      if (_sound) {
        try {
          await _player.play(BytesSource(wav));
        } catch (_) {}
      }
      // El WAV tiene 1 unidad de silencio al inicio: lo respetamos.
      await Future.delayed(Duration(milliseconds: _unitMs));
      for (final (on, units) in tl) {
        if (!_running || !mounted) break;
        if (_flash) await setTorch(on);
        if (_screen && mounted) setState(() => _lit = on);
        await Future.delayed(Duration(milliseconds: units * _unitMs));
      }
      if (_flash) await setTorch(false);
      if (mounted) setState(() => _lit = false);
      if (_running) await Future.delayed(Duration(milliseconds: 7 * _unitMs));
    } while (_loop && _running && mounted);
    _running = false;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _running = false;
    _player.dispose();
    setTorch(false);
    _txt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_running && _screen) {
      return GestureDetector(
        onTap: _transmit,
        child: Container(
          color: _lit ? Colors.white : Colors.black,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(32),
          child: Text(tr('Toca para detener', 'Tap to stop'), style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    final code = toMorse(_txt.text);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(tr('1. Escribe una palabra o frase', '1. Type a word or phrase'), style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: _txt,
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(fontSize: 22),
          decoration: InputDecoration(
            hintText: tr('Ej: AYUDA', 'E.g.: HELP'),
            suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() => _txt.clear())),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 6, runSpacing: 6, children: [
          for (final p in ['SOS', tr('AYUDA', 'HELP'), tr('HERIDO', 'INJURED'), tr('AGUA', 'WATER'), tr('ESTOY BIEN', 'I AM OK'), tr('VEN AQUI', 'COME HERE')])
            ActionChip(label: Text(p), onPressed: () => setState(() => _txt.text = p)),
        ]),
        const SizedBox(height: 16),
        Text(tr('2. Así se ve en Morse', '2. This is how it looks in Morse'), style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              border: Border.all(color: cs.primary.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(10)),
          child: SelectableText(code.isEmpty ? '—' : code,
              style: TextStyle(fontSize: 26, letterSpacing: 2, color: cs.primary)),
        ),
        const SizedBox(height: 6),
        // Desglose letra por letra
        Wrap(spacing: 10, runSpacing: 6, children: [
          for (final ch in _txt.text.toUpperCase().split(''))
            if (morseTable.containsKey(ch))
              Column(children: [
                Text(ch, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(prettyCode(morseTable[ch]!), style: const TextStyle(color: Colors.grey)),
              ]),
        ]),
        const SizedBox(height: 16),
        Text(tr('3. Elige cómo transmitir', '3. Choose how to transmit'), style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: [
          FilterChip(
              avatar: const Icon(Icons.volume_up, size: 18),
              label: Text(tr('Sonido', 'Sound')),
              selected: _sound,
              onSelected: _running ? null : (v) => setState(() => _sound = v)),
          FilterChip(
              avatar: const Icon(Icons.flashlight_on, size: 18),
              label: Text(tr('Linterna', 'Flashlight')),
              selected: _flash,
              onSelected: _running ? null : (v) => setState(() => _flash = v)),
          FilterChip(
              avatar: const Icon(Icons.smartphone, size: 18),
              label: Text(tr('Pantalla', 'Screen')),
              selected: _screen,
              onSelected: _running ? null : (v) => setState(() => _screen = v)),
          FilterChip(
              avatar: const Icon(Icons.repeat, size: 18),
              label: Text(tr('Repetir', 'Repeat')),
              selected: _loop,
              onSelected: (v) => setState(() => _loop = v)),
        ]),
        Row(children: [
          Text(tr('Velocidad', 'Speed')),
          Expanded(
            child: Slider(
              min: 60,
              max: 400,
              divisions: 17,
              value: _unitMs.toDouble(),
              label: _unitMs < 120 ? tr('Rápida', 'Fast') : _unitMs < 250 ? tr('Normal', 'Normal') : tr('Lenta', 'Slow'),
              onChanged: _running ? null : (v) => setState(() => _unitMs = v.round()),
            ),
          ),
        ]),
        SizedBox(
          height: 64,
          child: FilledButton.icon(
            icon: Icon(_running ? Icons.stop : Icons.play_arrow, size: 32),
            label: Text(_running ? tr('DETENER', 'STOP') : tr('TRANSMITIR', 'TRANSMIT'), style: const TextStyle(fontSize: 20)),
            onPressed: (_sound || _flash || _screen) ? _transmit : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr('Consejo: la linterna se ve a kilómetros de noche; el sonido sirve con silbato o golpes; la pantalla, si el flash no funciona.', 'Tip: a flashlight can be seen for kilometers at night; sound works with a whistle or knocks; use the screen if the flash doesn\'t work.'),
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// 2. DESCIFRAR: morse -> texto (teclas o manipulador)
// ---------------------------------------------------------------------
class _ReadTab extends StatefulWidget {
  const _ReadTab();
  @override
  State<_ReadTab> createState() => _ReadTabState();
}

class _ReadTabState extends State<_ReadTab> {
  String _code = '';
  DateTime? _down;
  Timer? _gap;
  final _beep = _Beeper();

  void _add(String s) {
    setState(() => _code += s);
  }

  void _pressStart() {
    _gap?.cancel();
    _down = DateTime.now();
  }

  void _pressEnd() {
    if (_down == null) return;
    final ms = DateTime.now().difference(_down!).inMilliseconds;
    _down = null;
    _add(ms < 250 ? '.' : '-');
    // Pausa corta = fin de letra; pausa larga = fin de palabra.
    _gap = Timer(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      _add(' ');
      _gap = Timer(const Duration(milliseconds: 1400), () {
        if (mounted && _code.isNotEmpty) _add('/ ');
      });
    });
  }

  @override
  void dispose() {
    _gap?.cancel();
    _beep.dispose();
    super.dispose();
  }

  Widget _key(String label, VoidCallback onTap, {Color? color}) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 60,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: color),
              onPressed: onTap,
              child: Text(label, style: const TextStyle(fontSize: 20)),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = fromMorse(_code);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
            tr('Escucha o mira señales Morse y márcalas aquí. La app las convierte en letras.', 'Listen to or watch Morse signals and tap them here. The app turns them into letters.'),
            style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 12),
        Text(tr('Mensaje', 'Message'), style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(top: 6, bottom: 8),
          decoration: BoxDecoration(
              border: Border.all(color: cs.primary), borderRadius: BorderRadius.circular(10)),
          child: Text(text.isEmpty ? '...' : text,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cs.primary)),
        ),
        Text(prettyCode(_code), style: const TextStyle(fontSize: 18, color: Colors.grey)),
        const SizedBox(height: 12),
        Row(children: [
          _key(tr('·  punto', '·  dot'), () => _add('.')),
          _key(tr('—  raya', '—  dash'), () => _add('-')),
        ]),
        Row(children: [
          _key(tr('Fin letra', 'End letter'), () => _add(' ')),
          _key(tr('Fin palabra', 'End word'), () => _add(' / ')),
        ]),
        Row(children: [
          _key('⌫', () {
            if (_code.isNotEmpty) setState(() => _code = _code.substring(0, _code.length - 1));
          }),
          _key(tr('Borrar todo', 'Clear all'), () => setState(() => _code = ''), color: Colors.red),
          _key('🔊', () => _beep.play(text)),
        ]),
        const SizedBox(height: 16),
        Text(tr('O usa el manipulador:', 'Or use the key:'), style: TextStyle(fontWeight: FontWeight.bold)),
        Text(tr('Toque corto = punto · Toque largo = raya · Espera = siguiente letra', 'Short tap = dot · Long press = dash · Pause = next letter'),
            style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        GestureDetector(
          onTapDown: (_) => _pressStart(),
          onTapUp: (_) => _pressEnd(),
          onTapCancel: _pressEnd,
          child: Container(
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.primary, width: 2),
            ),
            child: Text(tr('MANTÉN PRESIONADO', 'PRESS AND HOLD'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: cs.primary)),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// 3. PRACTICAR
// ---------------------------------------------------------------------
class _PracticeTab extends StatefulWidget {
  const _PracticeTab();
  @override
  State<_PracticeTab> createState() => _PracticeTabState();
}

class _PracticeTabState extends State<_PracticeTab> {
  final _rnd = Random();
  final _beep = _Beeper();
  // Orden de aprendizaje clásico: de las más fáciles a las difíciles.
  static const _levels = ['ETIANMS', 'ETIANMSOHRDKU', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'];
  int _level = 0;
  bool _listen = false; // false: ver letra y teclear; true: escuchar y elegir
  late String _target;
  List<String> _options = [];
  String _input = '';
  String? _result;
  int _ok = 0, _total = 0;

  @override
  void initState() {
    super.initState();
    _next(init: true);
  }

  @override
  void dispose() {
    _beep.dispose();
    super.dispose();
  }

  void _next({bool init = false}) {
    final pool = _levels[_level];
    _target = pool[_rnd.nextInt(pool.length)];
    final opts = {_target};
    while (opts.length < 4 && opts.length < pool.length) {
      opts.add(pool[_rnd.nextInt(pool.length)]);
    }
    _options = opts.toList()..shuffle(_rnd);
    _input = '';
    _result = null;
    if (_listen) _beep.play(_target, unitMs: 110);
    if (!init) setState(() {});
  }

  void _answer(bool correct) {
    _total++;
    if (correct) _ok++;
    setState(() => _result = correct
        ? tr('✔ ¡Correcto!', '✔ Correct!')
        : tr('✘ Era $_target = ${prettyCode(morseTable[_target]!)}', '✘ It was $_target = ${prettyCode(morseTable[_target]!)}', '✘ Era $_target = ${prettyCode(morseTable[_target]!)}'));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SegmentedButton<bool>(
          segments: [
            ButtonSegment(value: false, icon: Icon(Icons.visibility), label: Text(tr('Ver y marcar', 'See and tap'))),
            ButtonSegment(value: true, icon: Icon(Icons.hearing), label: Text(tr('Escuchar', 'Listen'))),
          ],
          selected: {_listen},
          onSelectionChanged: (s) {
            _listen = s.first;
            _next();
          },
        ),
        const SizedBox(height: 8),
        DropdownButton<int>(
          value: _level,
          isExpanded: true,
          items: [
            DropdownMenuItem(value: 0, child: Text(tr('Nivel 1: E T I A N M S', 'Level 1: E T I A N M S'))),
            DropdownMenuItem(value: 1, child: Text(tr('Nivel 2: + O H R D K U', 'Level 2: + O H R D K U'))),
            DropdownMenuItem(value: 2, child: Text(tr('Nivel 3: todo el abecedario', 'Level 3: whole alphabet'))),
            DropdownMenuItem(value: 3, child: Text(tr('Nivel 4: letras y números', 'Level 4: letters and numbers'))),
          ],
          onChanged: (v) {
            _level = v ?? 0;
            _next();
          },
        ),
        Text(tr('Aciertos: $_ok / $_total', 'Score: $_ok / $_total', 'Acertos: $_ok / $_total'), textAlign: TextAlign.center),
        const SizedBox(height: 12),
        if (!_listen) ...[
          Center(
            child: Text(_target,
                style: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: cs.primary)),
          ),
          Text(tr('Marca su código:', 'Tap its code:'), textAlign: TextAlign.center),
          Center(
            child: Text(_input.isEmpty ? ' ' : prettyCode(_input),
                style: const TextStyle(fontSize: 36, letterSpacing: 4)),
          ),
          Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: SizedBox(
                    height: 64,
                    child: OutlinedButton(
                        onPressed: _result == null ? () => setState(() => _input += '.') : null,
                        child: const Text('·', style: TextStyle(fontSize: 36)))),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: SizedBox(
                    height: 64,
                    child: OutlinedButton(
                        onPressed: _result == null ? () => setState(() => _input += '-') : null,
                        child: const Text('—', style: TextStyle(fontSize: 30)))),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.backspace_outlined),
                onPressed: () {
                  if (_input.isNotEmpty) setState(() => _input = _input.substring(0, _input.length - 1));
                }),
          ]),
          const SizedBox(height: 8),
          if (_result == null)
            FilledButton(
              onPressed: _input.isEmpty ? null : () => _answer(_input == morseTable[_target]),
              child: Text(tr('Comprobar', 'Check')),
            ),
        ] else ...[
          Center(
            child: IconButton.filled(
              iconSize: 64,
              icon: const Icon(Icons.volume_up),
              onPressed: () => _beep.play(_target, unitMs: 110),
            ),
          ),
          Text(tr('¿Qué letra sonó?', 'Which letter did you hear?'), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, children: [
            for (final o in _options)
              SizedBox(
                width: 72,
                height: 72,
                child: OutlinedButton(
                  onPressed: _result == null ? () => _answer(o == _target) : null,
                  child: Text(o, style: const TextStyle(fontSize: 30)),
                ),
              ),
          ]),
        ],
        if (_result != null) ...[
          const SizedBox(height: 12),
          Text(_result!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _result!.startsWith('✔') ? Colors.green : Colors.red)),
          const SizedBox(height: 8),
          FilledButton(onPressed: _next, child: Text(tr('Siguiente', 'Next'))),
        ],
        const SizedBox(height: 16),
        Text(
          tr('Truco: no memorices puntos y rayas, memoriza el SONIDO: "A" suena "di-DAH", "N" suena "DAH-di".', 'Trick: don\'t memorize dots and dashes, memorize the SOUND: "A" sounds "di-DAH", "N" sounds "DAH-di".'),
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// 4. TABLA (toca para escuchar)
// ---------------------------------------------------------------------
class _TableTab extends StatefulWidget {
  const _TableTab();
  @override
  State<_TableTab> createState() => _TableTabState();
}

class _TableTabState extends State<_TableTab> {
  final _beep = _Beeper();

  @override
  void dispose() {
    _beep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final keys = morseTable.keys.where((k) => RegExp(r'[A-Z0-9]').hasMatch(k)).toList();
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 110, childAspectRatio: 1.1),
      itemCount: keys.length,
      itemBuilder: (_, i) => Card(
        child: InkWell(
          onTap: () => _beep.play(keys[i], unitMs: 110),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(keys[i],
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: cs.primary)),
            Text(prettyCode(morseTable[keys[i]]!), style: const TextStyle(fontSize: 18)),
          ]),
        ),
      ),
    );
  }
}
