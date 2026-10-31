import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/i18n.dart';

import '../data/library.dart' show norm;
import '../data/species.dart';
import '../widgets/markup.dart';

/// Foto de la especie (`assets/img/<id>.jpg`). Si no existe, muestra un dibujo de reserva.
class SpeciesImage extends StatelessWidget {
  final Species s;
  final double? height;
  final int cacheWidth;
  const SpeciesImage(this.s, {super.key, this.height, this.cacheWidth = 360});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      s.image,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      cacheWidth: cacheWidth, // decodifica pequeño: menos RAM y batería
      gaplessPlayback: true,
      errorBuilder: (_, __, ___) => Container(
        height: height,
        color: s.kind.color.withValues(alpha: 0.12),
        alignment: Alignment.center,
        child: Icon(s.kind.icon, size: 48, color: s.kind.color),
      ),
    );
  }
}

class KindBadge extends StatelessWidget {
  final Kind kind;
  const KindBadge(this.kind, {super.key});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: kind.color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kind.color),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(kind.icon, size: 14, color: kind.color),
          const SizedBox(width: 4),
          Text(kind.label, style: TextStyle(fontSize: 12, color: kind.color)),
        ]),
      );
}

void openSpecies(BuildContext context, Species s) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => SpeciesScreen(s)));

/// Tarjeta compacta (se usa en la cuadrícula y dentro de artículos con `@ id`).
class SpeciesCard extends StatelessWidget {
  final Species s;
  final double width;
  const SpeciesCard(this.s, {super.key, this.width = 160});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () => openSpecies(context, s),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AspectRatio(aspectRatio: 1.2, child: SpeciesImage(s)),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(s.sci,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Row(children: [
                  Icon(s.kind.icon, size: 14, color: s.kind.color),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(s.kind.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: s.kind.color)),
                  ),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class AtlasScreen extends StatefulWidget {
  final Kind? initial;

  /// true: sin barra superior (dentro de la pestaña Biblioteca).
  final bool embedded;
  const AtlasScreen({super.key, this.initial, this.embedded = false});
  @override
  State<AtlasScreen> createState() => _AtlasScreenState();
}

class _AtlasScreenState extends State<AtlasScreen> {
  late Kind? _kind = widget.initial;
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final n = norm(_q.trim());
    final list = species.where((s) {
      if (_kind != null && s.kind != _kind) return false;
      if (n.isEmpty) return true;
      return norm('${s.name} ${s.sci} ${s.ident} ${s.info}').contains(n);
    }).toList();

    return Scaffold(
      appBar: widget.embedded ? null : AppBar(
        title: Text(tr('Guía visual', 'Visual guide')),
        actions: [
          IconButton(
            tooltip: tr('Créditos de imágenes', 'Image credits'),
            icon: const Icon(Icons.copyright),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const CreditsScreen())),
          ),
        ],
      ),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: tr('Buscar especie o rasgo...', 'Search species or feature...')),
              onChanged: (v) => setState(() => _q = v),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ChoiceChip(
                    label: Text(tr('Todas (${species.length})', 'All (${species.length})', 'Todas (${species.length})')),
                    selected: _kind == null,
                    onSelected: (_) => setState(() => _kind = null),
                  ),
                ),
                for (final k in Kind.values)
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: ChoiceChip(
                      avatar: Icon(k.icon, size: 16, color: k.color),
                      label: Text(k.label),
                      selected: _kind == k,
                      onSelected: (_) => setState(() => _kind = k),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.embedded)
          SliverToBoxAdapter(
            child: Row(children: [
              const SizedBox(width: 16),
              Expanded(
                  child: Text(tr('${list.length} especies · toca una para ver cómo reconocerla', '${list.length} species · tap one to learn how to recognize it', '${list.length} espécies · toque uma para ver como reconhecê-la'),
                      style: const TextStyle(color: Colors.grey, fontSize: 12))),
              TextButton.icon(
                icon: const Icon(Icons.copyright, size: 16),
                label: Text(tr('Créditos', 'Credits')),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const CreditsScreen())),
              ),
            ]),
          ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.78,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, i) => SpeciesCard(list[i], width: double.infinity),
              childCount: list.length,
            ),
          ),
        ),
      ]),
    );
  }
}

class SpeciesScreen extends StatelessWidget {
  final Species s;
  const SpeciesScreen(this.s, {super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(s.name)),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Scaffold(
                          backgroundColor: Colors.black,
                          appBar: AppBar(),
                          body: InteractiveViewer(
                            maxScale: 5,
                            child: Center(
                              child: Image.asset(s.image,
                                  errorBuilder: (_, __, ___) => const SizedBox()),
                            ),
                          ),
                        ))),
            child: SpeciesImage(s, height: 280, cacheWidth: 900),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text(s.sci,
                  style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 8),
              KindBadge(s.kind),
              const SizedBox(height: 12),
              Text(tr('Cómo reconocerla', 'How to recognize it'),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: cs.primary)),
              const SizedBox(height: 4),
              Markup(s.ident),
              const SizedBox(height: 8),
              Text(
                  switch (s.kind) {
                    Kind.venenosa || Kind.peligro => tr('Peligro y qué hacer', 'Danger and what to do'),
                    _ => tr('Usos y precauciones', 'Uses and precautions'),
                  },
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: cs.primary)),
              const SizedBox(height: 4),
              Markup(s.info),
              const SizedBox(height: 16),
              if (s.kind == Kind.fruta || s.kind == Kind.comestible || s.kind == Kind.medicinal)
                Text(
                  tr('⚠ Confirma siempre varios rasgos antes de comer o usar una planta. Si dudas, no la comas.', '⚠ Always confirm several features before eating or using a plant. If in doubt, don\'t eat it.'),
                  style: TextStyle(color: Colors.orange),
                ),
              const SizedBox(height: 8),
              Text(tr('Toca la foto para ampliarla.', 'Tap the photo to enlarge it.'),
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
        ],
      ),
    );
  }
}

/// Créditos de las fotos (licencias libres de Wikimedia Commons).
class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  Future<List<Map<String, dynamic>>> _load() async {
    try {
      var raw = await rootBundle.loadString('assets/img/credits.json');
      if (raw.startsWith('﻿')) raw = raw.substring(1);
      final data = jsonDecode(raw);
      final list = data is List ? data : [data];
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('Créditos de imágenes', 'Image credits'))),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _load(),
        builder: (_, snap) {
          final list = snap.data ?? [];
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (list.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(tr('Aún no hay fotos descargadas.\nEjecuta tool\\imagenes.ps1 en el PC.', 'No photos downloaded yet.\nRun tool\\imagenes.ps1 on the PC.'),
                    textAlign: TextAlign.center),
              ),
            );
          }
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                    tr('Fotografías de Wikimedia Commons bajo licencias libres. Gracias a sus autores.', 'Photos from Wikimedia Commons under free licenses. Thanks to their authors.')),
              ),
              for (final c in list)
                ListTile(
                  dense: true,
                  title: Text(speciesById[c['id']]?.name ?? '${c['id']}'),
                  subtitle: Text('${c['author'] ?? tr('Autor desconocido', 'Unknown author')} · ${c['license'] ?? ''}\n${c['file'] ?? ''}'),
                ),
            ],
          );
        },
      ),
    );
  }
}
