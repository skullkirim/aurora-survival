import 'dart:async';

import 'package:flutter/material.dart';

import '../core/alarms.dart';
import '../core/i18n.dart';
import '../core/power.dart';

String _hm(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

String _dur(Duration d) {
  final h = d.inHours, m = d.inMinutes % 60;
  return h > 0 ? '$h h ${m.toString().padLeft(2, '0')} min' : '$m min';
}

IconData _icon(String t) => switch (t) {
      'medicina' => Icons.medication,
      'torniquete' => Icons.bloodtype,
      'guardia' => Icons.shield,
      _ => Icons.timer,
    };

class AlarmsScreen extends StatefulWidget {
  const AlarmsScreen({super.key});
  @override
  State<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen> {
  Timer? _tick;
  bool? _allowed;
  bool _batteryOk = true;

  @override
  void initState() {
    super.initState();
    Alarms.askPermission().then((ok) {
      if (mounted) setState(() => _allowed = ok);
    });
    Power.isIgnoringBattery().then((ok) {
      if (mounted) setState(() => _batteryOk = ok);
    });
    // Refresco cada 30 s (no cada segundo: ahorra batería).
    _tick = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  Future<void> _tourniquet() async {
    final who = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text(tr('Torniquete puesto AHORA', 'Tourniquet applied NOW', 'Torniquete colocado AGORA')),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(tr(
              'Se guarda la hora y te aviso a la 1 h, 1 h 30, 2 h y luego cada 30 min. Escribe también la hora en la frente de la persona.',
              'The time is saved and you get reminders at 1 h, 1 h 30, 2 h and then every 30 min. Also write the time on the person\'s forehead.',
              'A hora fica salva e você recebe avisos em 1 h, 1 h 30, 2 h e depois a cada 30 min. Escreva também a hora na testa da pessoa.')),
          const SizedBox(height: 8),
          TextField(
              controller: who,
              decoration: InputDecoration(labelText: tr('Quién / dónde (opcional)', 'Who / where (optional)', 'Quem / onde (opcional)'))),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(tr('Cancelar', 'Cancel'))),
          FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(tr('GUARDAR HORA', 'SAVE TIME', 'SALVAR HORA'))),
        ],
      ),
    );
    if (ok != true) return;
    await Alarms.add({
      'type': 'torniquete',
      'title': who.text.trim(),
      'start': DateTime.now().millisecondsSinceEpoch,
    });
    setState(() {});
  }

  Future<void> _new(String type) async {
    final title = TextEditingController();
    final note = TextEditingController();
    final every = TextEditingController(text: switch (type) { 'medicina' => '8', 'guardia' => '2', _ => '10' });
    final count = TextEditingController(text: '10');
    final names = TextEditingController();
    var start = DateTime.now();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          backgroundColor: const Color(0xFF111111),
          title: Text(Alarms.typeLabel(type)),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              if (type == 'medicina') ...[
                TextField(
                    controller: title,
                    decoration: InputDecoration(labelText: tr('Medicina y para quién', 'Medicine and for whom', 'Remédio e para quem'))),
                TextField(
                    controller: note,
                    decoration: InputDecoration(labelText: tr('Dosis (ej.: 1 tableta con agua)', 'Dose (e.g. 1 tablet with water)', 'Dose (ex.: 1 comprimido com água)'))),
                Row(children: [
                  Expanded(
                    child: TextField(
                        controller: every,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: tr('Cada (horas)', 'Every (hours)', 'A cada (horas)'))),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                        controller: count,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: tr('N.º de dosis', 'No. of doses', 'N.º de doses'))),
                  ),
                ]),
              ],
              if (type == 'guardia') ...[
                TextField(
                    controller: names,
                    decoration: InputDecoration(
                        labelText: tr('Nombres en orden, separados por coma', 'Names in order, comma separated', 'Nomes em ordem, separados por vírgula'),
                        hintText: 'Ana, Luis, Marta')),
                TextField(
                    controller: every,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: tr('Horas por turno', 'Hours per shift', 'Horas por turno'))),
              ],
              if (type == 'temporizador') ...[
                TextField(
                    controller: title,
                    decoration: InputDecoration(labelText: tr('Para qué (ej.: agua hirviendo)', 'What for (e.g. boiling water)', 'Para quê (ex.: água fervendo)'))),
                TextField(
                    controller: every,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: tr('Minutos', 'Minutes', 'Minutos'))),
              ],
              if (type != 'temporizador')
                Row(children: [
                  Expanded(
                    child: Text(type == 'medicina'
                        ? tr('Primera dosis: ${_hm(start)}', 'First dose: ${_hm(start)}', 'Primeira dose: ${_hm(start)}')
                        : tr('Primer turno empieza: ${_hm(start)}', 'First shift starts: ${_hm(start)}', 'Primeiro turno começa: ${_hm(start)}')),
                  ),
                  TextButton(
                    onPressed: () async {
                      final t = await showTimePicker(context: ctx, initialTime: TimeOfDay.fromDateTime(start));
                      if (t == null) return;
                      var d = DateTime(start.year, start.month, start.day, t.hour, t.minute);
                      if (d.isBefore(DateTime.now().subtract(const Duration(minutes: 1)))) d = d.add(const Duration(days: 1));
                      setD(() => start = d);
                    },
                    child: Text(tr('Cambiar', 'Change', 'Mudar')),
                  ),
                ]),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(tr('Cancelar', 'Cancel'))),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(tr('Guardar', 'Save'))),
          ],
        ),
      ),
    );
    if (ok != true) return;
    final ev = double.tryParse(every.text.replaceAll(',', '.')) ?? 0;
    if (ev <= 0) return;
    final a = <String, dynamic>{
      'type': type,
      'title': title.text.trim(),
      'note': note.text.trim(),
      'start': start.millisecondsSinceEpoch,
      'every': type == 'temporizador' ? ev.round() : (ev * 60).round(),
    };
    if (type == 'medicina') {
      a['count'] = (int.tryParse(count.text) ?? 10).clamp(1, 60);
      if ((a['title'] as String).isEmpty) a['title'] = tr('Medicina', 'Medicine', 'Remédio');
    }
    if (type == 'guardia') {
      a['names'] = names.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      a['title'] = tr('Turnos de guardia', 'Guard shifts', 'Turnos de guarda');
      final l = a['names'] as List;
      if (l.isNotEmpty) a['note'] = tr('Empieza: ${l.first}', 'Starts: ${l.first}', 'Começa: ${l.first}');
    }
    await Alarms.add(a);
    setState(() {});
  }

  void _chooseType() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      builder: (ctx) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          for (final t in ['medicina', 'guardia', 'temporizador'])
            ListTile(
              leading: Icon(_icon(t)),
              title: Text(Alarms.typeLabel(t)),
              subtitle: Text(switch (t) {
                'medicina' => tr('Cada cierto número de horas', 'Every few hours', 'A cada tantas horas'),
                'guardia' => tr('Avisa quién sigue en la vigilancia', 'Tells who is next on watch', 'Avisa quem é o próximo na vigia'),
                _ => tr('Cocción, hervir agua, descanso...', 'Cooking, boiling water, rest...', 'Cozimento, ferver água, descanso...'),
              }),
              onTap: () {
                Navigator.pop(ctx);
                _new(t);
              },
            ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final list = Alarms.all..sort((a, b) => (Alarms.nextTime(a) ?? 1 << 62).compareTo(Alarms.nextTime(b) ?? 1 << 62));
    return Scaffold(
      appBar: AppBar(title: Text(tr('Alarmas', 'Alarms', 'Alarmes')), actions: [
        IconButton(
          tooltip: tr('Probar sonido', 'Test sound', 'Testar som'),
          icon: const Icon(Icons.notifications_active_outlined),
          onPressed: Alarms.test,
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _chooseType,
        icon: const Icon(Icons.add_alarm),
        label: Text(tr('Nueva', 'New', 'Novo')),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
        children: [
          SizedBox(
            height: 64,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC62828), foregroundColor: Colors.white),
              icon: const Icon(Icons.bloodtype, size: 30),
              label: Text(tr('TORNIQUETE PUESTO AHORA', 'TOURNIQUET ON NOW', 'TORNIQUETE COLOCADO AGORA'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onPressed: _tourniquet,
            ),
          ),
          if (_allowed == false)
            Card(
              color: Colors.orange.withValues(alpha: 0.15),
              child: ListTile(
                leading: const Icon(Icons.notifications_off, color: Colors.orange),
                title: Text(tr('Sin permiso de notificaciones: las alarmas no sonarán.', 'No notification permission: alarms will not ring.',
                    'Sem permissão de notificações: os alarmes não vão tocar.')),
                trailing: TextButton(
                    onPressed: () => Alarms.askPermission().then((ok) => setState(() => _allowed = ok)),
                    child: Text(tr('Permitir', 'Allow', 'Permitir'))),
              ),
            ),
          if (!_batteryOk)
            Card(
              color: Colors.orange.withValues(alpha: 0.15),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                      tr('El sistema puede apagar las alarmas para ahorrar batería (pasa mucho en Xiaomi/Redmi).',
                          'The system may kill alarms to save battery (very common on Xiaomi/Redmi).',
                          'O sistema pode desligar os alarmes para economizar bateria (comum em Xiaomi/Redmi).'),
                      style: const TextStyle(color: Colors.orange)),
                  Wrap(spacing: 8, children: [
                    TextButton(
                      onPressed: () async {
                        await Power.openBatterySettings();
                        final ok = await Power.isIgnoringBattery();
                        if (mounted) setState(() => _batteryOk = ok);
                      },
                      child: Text(tr('Sin restricciones de batería', 'No battery restrictions', 'Sem restrições de bateria')),
                    ),
                    TextButton(
                      onPressed: Power.openAutostart,
                      child: Text(tr('Permitir inicio automático', 'Allow autostart', 'Permitir início automático')),
                    ),
                  ]),
                ]),
              ),
            ),
          const SizedBox(height: 8),
          Text(
              tr('Suenan aunque cierres la app o el teléfono esté bloqueado. No uses el ahorro de batería que "cierra apps" con AURORA.',
                  'They ring even if you close the app or lock the phone. Don\'t let a battery saver "kill" AURORA.',
                  'Tocam mesmo com o app fechado ou o telefone bloqueado. Não deixe a economia de bateria "matar" o AURORA.'),
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          if (list.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                  tr('Sin alarmas. Toca "Nueva" para medicinas, turnos de guardia o un temporizador.',
                      'No alarms. Tap "New" for medicines, guard shifts or a timer.',
                      'Sem alarmes. Toque "Novo" para remédios, turnos de guarda ou um temporizador.'),
                  textAlign: TextAlign.center),
            ),
          for (final a in list) _card(a, now),
        ],
      ),
    );
  }

  Widget _card(Map<String, dynamic> a, DateTime now) {
    final type = '${a['type']}';
    final start = DateTime.fromMillisecondsSinceEpoch(a['start'] as int);
    final next = Alarms.nextTime(a);
    final isT = type == 'torniquete';
    final elapsed = now.difference(start);
    final danger = isT && elapsed.inMinutes >= 120;
    final lines = <String>[
      if (isT) tr('Puesto a las ${_hm(start)}', 'Applied at ${_hm(start)}', 'Colocado às ${_hm(start)}'),
      if ('${a['note'] ?? ''}'.isNotEmpty) '${a['note']}',
      if (type == 'guardia' && (a['names'] as List?)?.isNotEmpty == true)
        tr('Orden: ${(a['names'] as List).join(' → ')} · cada ${_dur(Duration(minutes: a['every'] as int))}',
            'Order: ${(a['names'] as List).join(' → ')} · every ${_dur(Duration(minutes: a['every'] as int))}',
            'Ordem: ${(a['names'] as List).join(' → ')} · a cada ${_dur(Duration(minutes: a['every'] as int))}'),
      if (type == 'medicina') tr('Cada ${_dur(Duration(minutes: a['every'] as int))} · ${a['count']} dosis', 'Every ${_dur(Duration(minutes: a['every'] as int))} · ${a['count']} doses',
          'A cada ${_dur(Duration(minutes: a['every'] as int))} · ${a['count']} doses'),
      next == null
          ? tr('Terminada', 'Finished', 'Terminado')
          : tr('Próximo aviso: ${_hm(DateTime.fromMillisecondsSinceEpoch(next))} (en ${_dur(DateTime.fromMillisecondsSinceEpoch(next).difference(now))})',
              'Next alert: ${_hm(DateTime.fromMillisecondsSinceEpoch(next))} (in ${_dur(DateTime.fromMillisecondsSinceEpoch(next).difference(now))})',
              'Próximo aviso: ${_hm(DateTime.fromMillisecondsSinceEpoch(next))} (em ${_dur(DateTime.fromMillisecondsSinceEpoch(next).difference(now))})'),
    ];
    return Card(
      color: danger ? const Color(0x33FF0000) : null,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(_icon(type), size: 32, color: isT ? Colors.red : Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${a['title']}'.isEmpty ? Alarms.typeLabel(type) : '${Alarms.typeLabel(type)} · ${a['title']}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              if (isT)
                Text(_dur(elapsed),
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: danger ? Colors.red : Colors.white)),
              for (final l in lines) Text(l, style: const TextStyle(color: Colors.grey)),
              if (isT)
                Text(
                    tr('No lo aflojes. Más de 2 h daña la extremidad: evacúa.', 'Do not loosen it. Over 2 h damages the limb: evacuate.',
                        'Não afrouxe. Mais de 2 h lesa o membro: evacue.'),
                    style: const TextStyle(color: Colors.orange, fontSize: 12)),
            ]),
          ),
          IconButton(
            tooltip: tr('Quitar', 'Remove', 'Remover'),
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await Alarms.remove(a['id'] as int);
              setState(() {});
            },
          ),
        ]),
      ),
    );
  }
}
