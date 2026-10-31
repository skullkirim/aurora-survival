import 'package:flutter/material.dart';

import '../core/i18n.dart';

import '../core/storage.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('Mis provisiones', 'My supplies')),
          bottom: TabBar(isScrollable: true, tabAlignment: TabAlignment.start, tabs: [
            Tab(icon: Icon(Icons.inventory_2_outlined), text: tr('Suministros', 'Supplies')),
            Tab(icon: Icon(Icons.edit_note), text: tr('Diario', 'Journal')),
            Tab(icon: Icon(Icons.backpack_outlined), text: tr('Mochila', 'Backpack')),
            Tab(icon: const Icon(Icons.groups_outlined), text: tr('Personas', 'People', 'Pessoas')),
          ]),
        ),
        body: const TabBarView(children: [
          _Supplies(),
          _Diary(),
          _Checklist(),
          PeopleTab(),
        ]),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Suministros
// ---------------------------------------------------------------------
const supplyCats = ['Agua', 'Comida', 'Medicina', 'Herramienta', 'Energía', 'Ropa', 'Otro'];

/// Nombre visible de una categoría (los datos se guardan siempre en español).
String catLabel(String c) => switch (c) {
      'Todo' => tr('Todo', 'All', 'Tudo'),
      'Agua' => tr('Agua', 'Water', 'Água'),
      'Comida' => tr('Comida', 'Food', 'Comida'),
      'Medicina' => tr('Medicina', 'Medicine', 'Remédio'),
      'Herramienta' => tr('Herramienta', 'Tool', 'Ferramenta'),
      'Energía' => tr('Energía', 'Energy', 'Energia'),
      'Ropa' => tr('Ropa', 'Clothing', 'Roupa'),
      'Otro' => tr('Otro', 'Other', 'Outro'),
      _ => c,
    };

class _Supplies extends StatefulWidget {
  const _Supplies();
  @override
  State<_Supplies> createState() => _SuppliesState();
}

class _SuppliesState extends State<_Supplies> {
  final List<Map<String, dynamic>> _items = Store.jsonList('inventory');
  String _filter = 'Todo';

  void _save() {
    Store.setJsonList('inventory', _items);
    setState(() {});
  }

  int? _daysLeft(Map<String, dynamic> it) {
    final e = it['exp'] as String?;
    if (e == null || e.isEmpty) return null;
    final d = DateTime.tryParse(e);
    if (d == null) return null;
    return d.difference(DateTime.now()).inDays;
  }

  Future<void> _edit([Map<String, dynamic>? item]) async {
    final name = TextEditingController(text: item?['name'] ?? '');
    final qty = TextEditingController(text: '${item?['qty'] ?? 1}');
    final unit = TextEditingController(text: item?['unit'] ?? 'und');
    String cat = item?['cat'] ?? 'Comida';
    String? exp = item?['exp'];

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          backgroundColor: const Color(0xFF111111),
          title: Text(item == null ? tr('Nuevo suministro', 'New supply') : tr('Editar', 'Edit')),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(controller: name, decoration: InputDecoration(labelText: tr('Nombre', 'Name'))),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: TextField(
                      controller: qty,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: tr('Cantidad', 'Quantity'))),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: TextField(
                        controller: unit, decoration: InputDecoration(labelText: tr('Unidad', 'Unit')))),
              ]),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final c in supplyCats)
                  ChoiceChip(
                    label: Text(catLabel(c)),
                    selected: cat == c,
                    onSelected: (_) => setD(() => cat = c),
                  ),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: Text(exp == null ? tr('Sin vencimiento', 'No expiry') : tr('Vence: $exp', 'Expires: $exp', 'Vence: $exp'))),
                TextButton(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: ctx,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDate: DateTime.tryParse(exp ?? '') ?? DateTime.now(),
                    );
                    if (d != null) setD(() => exp = d.toIso8601String().substring(0, 10));
                  },
                  child: Text(tr('Fecha', 'Date')),
                ),
                if (exp != null)
                  IconButton(icon: const Icon(Icons.clear), onPressed: () => setD(() => exp = null)),
              ]),
            ]),
          ),
          actions: [
            if (item != null)
              TextButton(
                onPressed: () {
                  _items.remove(item);
                  Navigator.pop(ctx, true);
                },
                child: Text(tr('Eliminar', 'Delete'), style: TextStyle(color: Colors.red)),
              ),
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(tr('Cancelar', 'Cancel'))),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(tr('Guardar', 'Save'))),
          ],
        ),
      ),
    );
    if (ok != true) return;
    if (name.text.trim().isNotEmpty && (item == null || _items.contains(item))) {
      final data = {
        'name': name.text.trim(),
        'qty': num.tryParse(qty.text.replaceAll(',', '.')) ?? 0,
        'unit': unit.text.trim(),
        'cat': cat,
        'exp': exp,
      };
      if (item == null) {
        _items.add(data);
      } else {
        item.addAll(data);
      }
    }
    _save();
  }

  @override
  Widget build(BuildContext context) {
    final shown = _filter == 'Todo' ? _items : _items.where((e) => e['cat'] == _filter).toList();
    shown.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
    final alerts = _items.where((e) {
      final d = _daysLeft(e);
      return d != null && d <= 30;
    }).length;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => _edit(), child: const Icon(Icons.add)),
      body: Column(children: [
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              for (final c in ['Todo', ...supplyCats])
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ChoiceChip(
                    label: Text(catLabel(c)),
                    selected: _filter == c,
                    onSelected: (_) => setState(() => _filter = c),
                  ),
                ),
            ],
          ),
        ),
        if (alerts > 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(tr('⚠ $alerts artículo(s) vencidos o por vencer en 30 días', '⚠ $alerts item(s) expired or expiring within 30 days', '⚠ $alerts item(ns) vencido(s) ou vencendo em 30 dias'),
                style: const TextStyle(color: Colors.orange)),
          ),
        Expanded(
          child: shown.isEmpty
              ? Center(child: Text(tr('Sin suministros. Toca + para agregar.', 'No supplies. Tap + to add.')))
              : ListView.builder(
                  itemCount: shown.length,
                  itemBuilder: (_, i) {
                    final it = shown[i];
                    final d = _daysLeft(it);
                    final q = it['qty'] as num;
                    return ListTile(
                      title: Text(it['name']),
                      subtitle: Text([
                        catLabel('${it['cat']}'),
                        if (d != null)
                          d < 0 ? tr('VENCIDO', 'EXPIRED') : tr('vence en $d días', 'expires in $d days', 'vence em $d dias'),
                      ].join(' · '),
                          style: TextStyle(
                              color: d != null && d <= 30 ? Colors.orange : null)),
                      onTap: () => _edit(it),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: q <= 0
                                ? null
                                : () {
                                    it['qty'] = q - 1 < 0 ? 0 : q - 1;
                                    _save();
                                  }),
                        Text('${q % 1 == 0 ? q.toInt() : q} ${it['unit']}'),
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              it['qty'] = q + 1;
                              _save();
                            }),
                      ]),
                    );
                  },
                ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------
// Diario
// ---------------------------------------------------------------------
class _Diary extends StatefulWidget {
  const _Diary();
  @override
  State<_Diary> createState() => _DiaryState();
}

class _DiaryState extends State<_Diary> {
  final List<Map<String, dynamic>> _notes = Store.jsonList('notes');

  Future<void> _write([Map<String, dynamic>? note]) async {
    final ctrl = TextEditingController(text: note?['text'] ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text(note == null ? tr('Nueva entrada', 'New entry') : tr('Editar entrada', 'Edit entry')),
        content: TextField(
          controller: ctrl,
          maxLines: 8,
          autofocus: true,
          decoration: InputDecoration(
              hintText: tr('Qué pasó hoy, recursos encontrados, personas, clima...', 'What happened today, resources found, people, weather...')),
        ),
        actions: [
          if (note != null)
            TextButton(
              onPressed: () {
                _notes.remove(note);
                Navigator.pop(ctx, true);
              },
              child: Text(tr('Eliminar', 'Delete'), style: TextStyle(color: Colors.red)),
            ),
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(tr('Cancelar', 'Cancel'))),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(tr('Guardar', 'Save'))),
        ],
      ),
    );
    if (ok != true) return;
    final t = ctrl.text.trim();
    if (t.isNotEmpty) {
      if (note == null) {
        _notes.insert(0, {'date': DateTime.now().toIso8601String(), 'text': t});
      } else if (_notes.contains(note)) {
        note['text'] = t;
      }
    }
    await Store.setJsonList('notes', _notes);
    setState(() {});
  }

  String _fmt(String iso) {
    final d = DateTime.tryParse(iso);
    if (d == null) return iso;
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}  ${two(d.hour)}:${two(d.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => _write(), child: const Icon(Icons.edit)),
      body: _notes.isEmpty
          ? Center(
              child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                  tr('Lleva un diario: fechas, decisiones, lugares, personas. La memoria falla bajo estrés.', 'Keep a journal: dates, decisions, places, people. Memory fails under stress.'),
                  textAlign: TextAlign.center),
            ))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (_, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  title: Text(_fmt(_notes[i]['date']),
                      style: TextStyle(
                          fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                  subtitle: Text(_notes[i]['text'], style: const TextStyle(fontSize: 15)),
                  onTap: () => _write(_notes[i]),
                ),
              ),
            ),
    );
  }
}

// ---------------------------------------------------------------------
// Lista de mochila de 72 h
// ---------------------------------------------------------------------
List<String> get _defaultChecklist => [
  tr('Agua 3 L por persona', 'Water 3 L per person'),
  tr('Purificador / tabletas / cloro', 'Purifier / tablets / bleach'),
  tr('Comida para 3 días', 'Food for 3 days'),
  tr('Linterna + pilas', 'Flashlight + batteries'),
  tr('Encendedor y fósforos en bolsa', 'Lighter and matches in a bag'),
  tr('Ferrocerio', 'Ferro rod'),
  tr('Navaja multiuso', 'Multi-tool'),
  tr('Botiquín', 'First-aid kit'),
  tr('Medicamentos personales', 'Personal medications'),
  tr('Manta térmica', 'Emergency blanket'),
  tr('Poncho o lona', 'Poncho or tarp'),
  tr('Cuerda 15 m', 'Rope 15 m'),
  tr('Muda de ropa y medias', 'Change of clothes and socks'),
  tr('Silbato', 'Whistle'),
  tr('Documentos en bolsa plástica', 'Documents in a plastic bag'),
  tr('Efectivo en billetes pequeños', 'Cash in small bills'),
  tr('Batería externa cargada', 'Charged power bank'),
  tr('Radio de pilas o dinamo', 'Battery or crank radio'),
  tr('Mapa en papel y libreta', 'Paper map and notebook'),
  tr('Jabón y artículos de higiene', 'Soap and hygiene items'),
  tr('Tapabocas', 'Face masks'),
  tr('Cinta adhesiva', 'Duct tape'),
];

class _Checklist extends StatefulWidget {
  const _Checklist();
  @override
  State<_Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<_Checklist> {
  late List<String> _items = Store.strings('check_items');
  Set<String> _done = Store.strings('check_done').toSet();

  @override
  void initState() {
    super.initState();
    if (_items.isEmpty) _items = [..._defaultChecklist];
  }

  void _save() {
    Store.setStrings('check_items', _items);
    Store.setStrings('check_done', _done.toList());
    setState(() {});
  }

  Future<void> _add() async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF111111),
        title: Text(tr('Agregar a la mochila', 'Add to backpack')),
        content: TextField(controller: ctrl, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(tr('Cancelar', 'Cancel'))),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(tr('Agregar', 'Add'))),
        ],
      ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      _items.add(ctrl.text.trim());
      _save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final done = _items.where(_done.contains).length;
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: _add, child: const Icon(Icons.add)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(tr('Mochila de 72 h: $done / ${_items.length}', '72-hour backpack: $done / ${_items.length}', 'Mochila de 72 h: $done / ${_items.length}'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              LinearProgressIndicator(value: _items.isEmpty ? 0 : done / _items.length),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _done = {};
                    _save();
                  },
                  child: Text(tr('Desmarcar todo', 'Uncheck all')),
                ),
              ),
            ]),
          ),
          for (final it in _items)
            Dismissible(
              key: ValueKey(it),
              background: Container(color: Colors.red.withValues(alpha: 0.3)),
              onDismissed: (_) {
                _items.remove(it);
                _done.remove(it);
                _save();
              },
              child: CheckboxListTile(
                title: Text(it),
                value: _done.contains(it),
                onChanged: (v) {
                  v == true ? _done.add(it) : _done.remove(it);
                  _save();
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Personas del grupo (se comparten en Modo comunidad)
// ---------------------------------------------------------------------
const personStatus = ['Bien', 'Herido', 'Enfermo', 'Desaparecido'];

String statusLabel(String s) => switch (s) {
      'Bien' => tr('Bien', 'OK', 'Bem'),
      'Herido' => tr('Herido', 'Injured', 'Ferido'),
      'Enfermo' => tr('Enfermo', 'Sick', 'Doente'),
      'Desaparecido' => tr('Desaparecido', 'Missing', 'Desaparecido'),
      _ => s,
    };

Color statusColor(String s) => switch (s) {
      'Herido' => Colors.red,
      'Enfermo' => Colors.orange,
      'Desaparecido' => Colors.purpleAccent,
      _ => Colors.green,
    };

class PeopleTab extends StatefulWidget {
  const PeopleTab({super.key});
  @override
  State<PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  final List<Map<String, dynamic>> _people = Store.jsonList('people');

  Future<void> _edit([Map<String, dynamic>? p]) async {
    final c = {
      for (final k in ['name', 'age', 'skills', 'blood', 'health', 'notes']) k: TextEditingController(text: '${p?[k] ?? ''}'),
    };
    String status = p?['status'] ?? 'Bien';
    final labels = {
      'name': tr('Nombre', 'Name'),
      'age': tr('Edad', 'Age', 'Idade'),
      'skills': tr('Sabe hacer (médico, mecánico, cocina...)', 'Skills (medic, mechanic, cooking...)', 'Sabe fazer (médico, mecânico, cozinha...)'),
      'blood': tr('Tipo de sangre', 'Blood type'),
      'health': tr('Salud: alergias, enfermedades, medicinas', 'Health: allergies, conditions, medicines', 'Saúde: alergias, doenças, remédios'),
      'notes': tr('Notas / dónde está', 'Notes / where they are', 'Notas / onde está'),
    };
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          backgroundColor: const Color(0xFF111111),
          title: Text(p == null ? tr('Nueva persona', 'New person', 'Nova pessoa') : tr('Editar', 'Edit')),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              for (final e in c.entries)
                TextField(
                  controller: e.value,
                  keyboardType: e.key == 'age' ? TextInputType.number : TextInputType.text,
                  maxLines: e.key == 'health' || e.key == 'notes' ? 3 : 1,
                  minLines: 1,
                  decoration: InputDecoration(labelText: labels[e.key]),
                ),
              const SizedBox(height: 10),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final s in personStatus)
                  ChoiceChip(
                    label: Text(statusLabel(s)),
                    selected: status == s,
                    selectedColor: statusColor(s).withValues(alpha: 0.35),
                    onSelected: (_) => setD(() => status = s),
                  ),
              ]),
            ]),
          ),
          actions: [
            if (p != null)
              TextButton(
                onPressed: () {
                  _people.remove(p);
                  Navigator.pop(ctx, true);
                },
                child: Text(tr('Eliminar', 'Delete'), style: const TextStyle(color: Colors.red)),
              ),
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(tr('Cancelar', 'Cancel'))),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(tr('Guardar', 'Save'))),
          ],
        ),
      ),
    );
    if (ok != true) return;
    if (c['name']!.text.trim().isNotEmpty && (p == null || _people.contains(p))) {
      final data = <String, dynamic>{
        for (final e in c.entries) e.key: e.value.text.trim(),
        'status': status,
        'upd': DateTime.now().millisecondsSinceEpoch,
      };
      if (p == null) {
        data['uid'] = '${DateTime.now().microsecondsSinceEpoch}';
        _people.add(data);
      } else {
        p.addAll(data);
      }
    }
    await Store.setJsonList('people', _people);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final counts = {for (final s in personStatus) s: _people.where((p) => (p['status'] ?? 'Bien') == s).length};
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => _edit(), child: const Icon(Icons.person_add)),
      body: _people.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                  tr('Anota a las personas de tu grupo: quién está, cómo está y qué sabe hacer. Con Modo comunidad la lista se comparte con los teléfonos cercanos.',
                      'Write down the people in your group: who is here, how they are and what they can do. With Community mode the list is shared with nearby phones.',
                      'Anote as pessoas do seu grupo: quem está, como está e o que sabe fazer. Com o Modo comunidade a lista é compartilhada com os telefones próximos.'),
                  textAlign: TextAlign.center),
            ))
          : ListView(
              padding: const EdgeInsets.only(bottom: 80),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(spacing: 8, runSpacing: 6, children: [
                    Chip(label: Text(tr('Total: ${_people.length}', 'Total: ${_people.length}', 'Total: ${_people.length}'))),
                    for (final s in personStatus)
                      if (counts[s]! > 0)
                        Chip(
                          avatar: CircleAvatar(backgroundColor: statusColor(s), radius: 6),
                          label: Text('${statusLabel(s)}: ${counts[s]}'),
                        ),
                  ]),
                ),
                for (final p in _people)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: statusColor('${p['status']}').withValues(alpha: 0.25),
                      child: Text('${p['name']}'.isEmpty ? '?' : '${p['name']}'.substring(0, 1).toUpperCase()),
                    ),
                    title: Text('${p['name']}${'${p['age'] ?? ''}'.isEmpty ? '' : ' (${p['age']})'}'),
                    subtitle: Text(
                      [
                        statusLabel('${p['status'] ?? 'Bien'}'),
                        if ('${p['blood'] ?? ''}'.isNotEmpty) '🩸 ${p['blood']}',
                        if ('${p['skills'] ?? ''}'.isNotEmpty) '${p['skills']}',
                        if ('${p['health'] ?? ''}'.isNotEmpty) '⚕ ${p['health']}',
                      ].join(' · '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => _edit(p),
                  ),
              ],
            ),
    );
  }
}
