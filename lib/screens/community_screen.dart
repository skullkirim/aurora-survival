import 'dart:async';

import 'package:flutter/material.dart';

import '../core/community.dart';
import '../core/i18n.dart';
import '../core/storage.dart';
import '../data/library.dart' show norm;
import 'inventory_screen.dart' show catLabel, statusColor, statusLabel, InventoryScreen;

/// Modo comunidad: inventario y personas compartidos entre teléfonos cercanos sin internet.
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<String> _ips = [];
  String? _msg;
  bool _busy = false;
  Timer? _auto;
  final _name = TextEditingController(text: Community.myName);
  final _pin = TextEditingController(text: Community.pin);

  @override
  void initState() {
    super.initState();
    Community.changes.addListener(_changed);
    _start();
  }

  Future<void> _start() async {
    final e = await Community.start();
    _ips = await Community.myIps();
    if (mounted) setState(() => _msg = e);
    // Sincronización automática solo mientras esta pantalla está abierta.
    _auto = Timer.periodic(const Duration(seconds: 30), (_) => Community.syncAll());
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _auto?.cancel();
    Community.changes.removeListener(_changed);
    Community.stop();
    super.dispose();
  }

  Future<void> _syncNow() async {
    setState(() {
      _busy = true;
      _msg = null;
    });
    _ips = await Community.myIps();
    final n = await Community.syncAll();
    if (mounted) {
      setState(() {
        _busy = false;
        _msg = n == 0
            ? tr('No se encontró ningún teléfono. Revisa que estén en la misma red Wi-Fi con esta pantalla abierta.',
                'No phone found. Check they are on the same Wi-Fi with this screen open.',
                'Nenhum telefone encontrado. Verifique se estão na mesma rede Wi-Fi com esta tela aberta.')
            : tr('Sincronizado con $n teléfono(s).', 'Synced with $n phone(s).', 'Sincronizado com $n telefone(s).');
      });
    }
  }

  Future<void> _manual() async {
    final c = TextEditingController();
    final ip = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text(tr('Conectar por IP', 'Connect by IP', 'Conectar por IP')),
        content: TextField(
          controller: c,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              hintText: '192.168.43.1',
              helperText: tr('La IP aparece en la pantalla del otro teléfono', 'The IP is shown on the other phone\'s screen',
                  'O IP aparece na tela do outro telefone')),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(tr('Cancelar', 'Cancel'))),
          FilledButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: Text(tr('Conectar', 'Connect', 'Conectar'))),
        ],
      ),
    );
    if (ip == null || ip.isEmpty) return;
    setState(() => _busy = true);
    final e = await Community.syncWith(ip);
    if (mounted) {
      setState(() {
        _busy = false;
        _msg = e ?? tr('Sincronizado con $ip', 'Synced with $ip', 'Sincronizado com $ip');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('Modo comunidad', 'Community mode', 'Modo comunidade')),
          bottom: TabBar(tabs: [
            Tab(icon: const Icon(Icons.wifi_tethering), text: tr('Conexión', 'Connection', 'Conexão')),
            Tab(icon: const Icon(Icons.inventory_2_outlined), text: tr('Provisiones', 'Supplies')),
            Tab(icon: const Icon(Icons.groups_outlined), text: tr('Personas', 'People', 'Pessoas')),
          ]),
        ),
        body: TabBarView(children: [
          _connection(),
          _GroupSupplies(),
          _GroupPeople(),
        ]),
      ),
    );
  }

  Widget _connection() {
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now().millisecondsSinceEpoch;
    final received = Community.received;
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(tr('Cómo conectarse sin internet', 'How to connect without internet', 'Como conectar sem internet'),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: cs.primary)),
              const SizedBox(height: 6),
              for (final (n, t) in [
                ('1', tr('Un teléfono activa la ZONA Wi-Fi (hotspot) en Ajustes. No necesita internet ni saldo.',
                    'One phone turns on its Wi-Fi HOTSPOT in Settings. It needs no internet or credit.',
                    'Um telefone ativa o ROTEADOR Wi-Fi (hotspot) em Configurações. Não precisa de internet nem crédito.')),
                ('2', tr('Los demás se conectan a esa red Wi-Fi (o todos a un mismo router).', 'The others join that Wi-Fi network (or all join the same router).',
                    'Os outros se conectam a essa rede Wi-Fi (ou todos ao mesmo roteador).')),
                ('3', tr('Todos abren esta pantalla con el MISMO PIN de grupo.', 'Everyone opens this screen with the SAME group PIN.',
                    'Todos abrem esta tela com o MESMO PIN de grupo.')),
                ('4', tr('Los teléfonos se encuentran solos y comparten provisiones y personas.', 'Phones find each other and share supplies and people.',
                    'Os telefones se encontram sozinhos e compartilham provisões e pessoas.')),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    CircleAvatar(radius: 11, backgroundColor: cs.primary, child: Text(n, style: const TextStyle(fontSize: 12, color: Colors.black))),
                    const SizedBox(width: 8),
                    Expanded(child: Text(t)),
                  ]),
                ),
            ]),
          ),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: TextField(
              controller: _name,
              decoration: InputDecoration(labelText: tr('Tu nombre en el grupo', 'Your name in the group', 'Seu nome no grupo')),
              onChanged: Community.setMyName,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: TextField(
              controller: _pin,
              keyboardType: TextInputType.number,
              obscureText: false,
              decoration: InputDecoration(labelText: tr('PIN de grupo', 'Group PIN', 'PIN do grupo')),
              onChanged: Community.setPin,
            ),
          ),
        ]),
        const SizedBox(height: 10),
        Text(
          Community.running
              ? tr('● Activo. Este teléfono: ${_ips.isEmpty ? 'sin red Wi-Fi' : _ips.join(', ')}',
                  '● Active. This phone: ${_ips.isEmpty ? 'no Wi-Fi network' : _ips.join(', ')}',
                  '● Ativo. Este telefone: ${_ips.isEmpty ? 'sem rede Wi-Fi' : _ips.join(', ')}')
              : tr('Detenido', 'Stopped', 'Parado'),
          style: TextStyle(color: Community.running ? Colors.green : Colors.grey),
        ),
        if (_msg != null) Text(_msg!, style: const TextStyle(color: Colors.orange)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: _busy ? null : _syncNow,
              icon: _busy
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.sync),
              label: Text(tr('Sincronizar ahora', 'Sync now', 'Sincronizar agora')),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(onPressed: _busy ? null : _manual, child: Text(tr('Por IP', 'By IP', 'Por IP'))),
        ]),
        const SizedBox(height: 14),
        Text(tr('Teléfonos del grupo', 'Group phones', 'Telefones do grupo'), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        if (received.isEmpty)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(tr('Aún no hay datos de otros teléfonos.', 'No data from other phones yet.', 'Ainda não há dados de outros telefones.'),
                style: const TextStyle(color: Colors.grey)),
          ),
        for (final e in received.entries)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.smartphone,
                color: Community.peers.containsKey(e.key) && now - Community.peers[e.key]!.$3 < 30000 ? Colors.green : Colors.grey),
            title: Text('${e.value['name']}'),
            subtitle: Text(tr(
                '${(e.value['inventory'] as List).length} provisiones · ${(e.value['people'] as List).length} personas · hace ${_ago(e.value['got'])}',
                '${(e.value['inventory'] as List).length} supplies · ${(e.value['people'] as List).length} people · ${_ago(e.value['got'])} ago',
                '${(e.value['inventory'] as List).length} provisões · ${(e.value['people'] as List).length} pessoas · há ${_ago(e.value['got'])}')),
            trailing: IconButton(
              tooltip: tr('Olvidar', 'Forget', 'Esquecer'),
              icon: const Icon(Icons.close),
              onPressed: () => Community.forget(e.key),
            ),
          ),
        const SizedBox(height: 10),
        if (Community.log.isNotEmpty) ...[
          Text(tr('Actividad', 'Activity', 'Atividade'), style: const TextStyle(color: Colors.grey)),
          for (final l in Community.log.take(8)) Text(l, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
        const SizedBox(height: 10),
        Text(
            tr('Solo se comparte con quien tenga el mismo PIN y esté en tu misma red. La app escucha únicamente mientras esta pantalla está abierta.',
                'Data is only shared with phones on your network using the same PIN. The app only listens while this screen is open.',
                'Só é compartilhado com quem tiver o mesmo PIN e estiver na sua rede. O app só escuta enquanto esta tela está aberta.'),
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

String _ago(Object? ms) {
  if (ms is! int) return '?';
  final d = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(ms));
  if (d.inMinutes < 1) return tr('un momento', 'a moment', 'um momento');
  if (d.inHours < 1) return '${d.inMinutes} min';
  if (d.inDays < 1) return '${d.inHours} h';
  return tr('${d.inDays} días', '${d.inDays} days', '${d.inDays} dias');
}

/// (nombre del teléfono, lista) para mí y cada teléfono recibido.
List<(String, List<Map<String, dynamic>>)> _sources(String key) => [
      (tr('Yo', 'Me', 'Eu'), Store.jsonList(key)),
      for (final r in Community.received.values)
        ('${r['name']}', [for (final e in (r[key] as List? ?? const [])) if (e is Map) Map<String, dynamic>.from(e)]),
    ];

class _GroupSupplies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Suma por nombre (sin tildes ni mayúsculas) y unidad.
    final total = <String, (String, String, String, num, Map<String, num>)>{};
    for (final (who, list) in _sources('inventory')) {
      for (final it in list) {
        final name = '${it['name'] ?? ''}'.trim();
        if (name.isEmpty) continue;
        final unit = '${it['unit'] ?? ''}';
        final k = '${norm(name)}|${norm(unit)}';
        final q = it['qty'] is num ? it['qty'] as num : 0;
        final prev = total[k];
        final by = {...?prev?.$5};
        by[who] = (by[who] ?? 0) + q;
        total[k] = (name, unit, '${it['cat'] ?? 'Otro'}', (prev?.$4 ?? 0) + q, by);
      }
    }
    final rows = total.values.toList()..sort((a, b) => a.$3 == b.$3 ? a.$1.compareTo(b.$1) : a.$3.compareTo(b.$3));
    if (rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(tr('Sin provisiones todavía.', 'No supplies yet.', 'Sem provisões ainda.'), textAlign: TextAlign.center),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InventoryScreen())),
              child: Text(tr('Agregar las mías', 'Add mine', 'Adicionar as minhas')),
            ),
          ]),
        ),
      );
    }
    String fmt(num q) => q % 1 == 0 ? '${q.toInt()}' : q.toStringAsFixed(1);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(tr('Todo lo que tiene el grupo, sumado.', 'Everything the group has, added up.', 'Tudo o que o grupo tem, somado.'),
              style: const TextStyle(color: Colors.grey)),
        ),
        for (final (name, unit, cat, q, by) in rows)
          ListTile(
            dense: true,
            title: Text(name, style: const TextStyle(fontSize: 15)),
            subtitle: Text('${catLabel(cat)} · ${by.entries.map((e) => '${e.key}: ${fmt(e.value)}').join(' · ')}'),
            trailing: Text('${fmt(q)} $unit', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}

class _GroupPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Una persona puede estar en varios teléfonos: se queda la versión más reciente.
    final byUid = <String, (String, Map<String, dynamic>)>{};
    for (final (who, list) in _sources('people')) {
      for (final p in list) {
        final uid = '${p['uid'] ?? '$who|${p['name']}'}';
        final prev = byUid[uid];
        final upd = p['upd'] is int ? p['upd'] as int : 0;
        if (prev == null || upd > (prev.$2['upd'] is int ? prev.$2['upd'] as int : 0)) byUid[uid] = (who, p);
      }
    }
    final rows = byUid.values.toList()
      ..sort((a, b) {
        int rank(Map<String, dynamic> p) => switch ('${p['status']}') { 'Herido' => 0, 'Desaparecido' => 1, 'Enfermo' => 2, _ => 3 };
        final r = rank(a.$2).compareTo(rank(b.$2));
        return r != 0 ? r : '${a.$2['name']}'.compareTo('${b.$2['name']}');
      });
    if (rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(tr('Nadie en la lista. Agrega personas en Provisiones > Personas.', 'Nobody listed. Add people in Supplies > People.',
              'Ninguém na lista. Adicione pessoas em Provisões > Pessoas.'), textAlign: TextAlign.center),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(tr('${rows.length} personas en el grupo', '${rows.length} people in the group', '${rows.length} pessoas no grupo'),
              style: const TextStyle(color: Colors.grey)),
        ),
        for (final (who, p) in rows)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: statusColor('${p['status']}').withValues(alpha: 0.3),
              child: Text('${p['name']}'.isEmpty ? '?' : '${p['name']}'.substring(0, 1).toUpperCase()),
            ),
            title: Text('${p['name']}${'${p['age'] ?? ''}'.isEmpty ? '' : ' (${p['age']})'}'),
            subtitle: Text([
              statusLabel('${p['status'] ?? 'Bien'}'),
              if ('${p['blood'] ?? ''}'.isNotEmpty) '🩸 ${p['blood']}',
              if ('${p['skills'] ?? ''}'.isNotEmpty) '${p['skills']}',
              if ('${p['health'] ?? ''}'.isNotEmpty) '⚕ ${p['health']}',
              if ('${p['notes'] ?? ''}'.isNotEmpty) '${p['notes']}',
              tr('anotado por $who', 'listed by $who', 'anotado por $who'),
            ].join(' · ')),
          ),
      ],
    );
  }
}
