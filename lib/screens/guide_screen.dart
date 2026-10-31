import 'package:flutter/material.dart';

import '../core/i18n.dart';

import '../data/guides.dart';
import '../data/ill_map.dart';
import '../data/library.dart';
import '../data/species.dart';
import '../widgets/ill.dart';
import 'alarms_screen.dart';
import 'atlas_screen.dart';
import 'library_screen.dart' show openArticle;
import 'tools_screen.dart';

void openGuide(BuildContext context, Guide g) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => GuideScreen(g)));

/// Herramienta asociada a una guía.
(IconData, String, Widget Function())? guideTool(String? id) => switch (id) {
      'sos' => (Icons.sos, tr('Enviar SOS con la linterna', 'Send SOS with the flashlight'), () => const MorseFlashScreen(initial: 'SOS')),
      'brujula' => (Icons.explore, tr('Abrir la brújula', 'Open the compass'), () => const CompassScreen()),
      'radiacion' => (Icons.warning_amber_rounded, tr('Calcular radiación', 'Calculate radiation'), () => const RadiationScreen()),
      'torniquete' => (Icons.alarm, tr('Alarma de torniquete', 'Tourniquet alarm', 'Alarme de torniquete'), () => const AlarmsScreen()),
      'atlas' => (Icons.photo_library, tr('Abrir la Guía visual', 'Open the visual guide'), () => const AtlasScreen()),
      _ => null,
    };

/// Una situación, un paso por pantalla, letra grande.
class GuideScreen extends StatefulWidget {
  final Guide guide;
  const GuideScreen(this.guide, {super.key});
  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final g = widget.guide;
    final cs = Theme.of(context).colorScheme;
    final last = _i >= g.steps.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(g.title),
        actions: [
          TextButton(
            onPressed: () => setState(() => _i = g.steps.length),
            child: Text(tr('Ver todo', 'See all')),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          // Barra de progreso por pasos
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(children: [
              for (var k = 0; k < g.steps.length; k++)
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _i = k),
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: k <= _i ? g.color : const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
            ]),
          ),
          Expanded(child: last ? _summary(context, g) : _step(context, g, g.steps[_i])),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              if (_i > 0)
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: Text(tr('Atrás', 'Back'), style: TextStyle(fontSize: 18)),
                      onPressed: () => setState(() => _i--),
                    ),
                  ),
                ),
              if (_i > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 60,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: last ? cs.primary : g.color),
                    icon: Icon(last ? Icons.check : Icons.arrow_forward),
                    label: Text(
                        last ? tr('Terminar', 'Finish') : (_i == g.steps.length - 1 ? tr('Resumen', 'Summary') : tr('Siguiente paso', 'Next step')),
                        style: const TextStyle(fontSize: 18, color: Colors.black)),
                    onPressed: () => last ? Navigator.pop(context) : setState(() => _i++),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _step(BuildContext context, Guide g, GuideStep s) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(tr('PASO ${_i + 1} DE ${g.steps.length}', 'STEP ${_i + 1} OF ${g.steps.length}', 'PASSO ${_i + 1} DE ${g.steps.length}'),
            style: TextStyle(color: g.color, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 8),
        Row(children: [
          if (s.warn) const Icon(Icons.warning_amber, color: Colors.red, size: 32),
          if (s.warn) const SizedBox(width: 8),
          Expanded(
            child: Text(s.title,
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: s.warn ? Colors.red : null)),
          ),
        ]),
        if (guideIll[g.id]?[_i] != null) ...[
          const SizedBox(height: 12),
          Ill(guideIll[g.id]![_i]!),
        ],
        const SizedBox(height: 16),
        Text(s.text, style: const TextStyle(fontSize: 22, height: 1.4)),
        if (s.species.isNotEmpty) ...[
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final id in s.species)
                  if (speciesById[id] != null) SpeciesCard(speciesById[id]!, width: 150),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _summary(BuildContext context, Guide g) {
    final tool = guideTool(g.tool);
    final art = g.article == null ? null : articleIndex[g.article];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(tr('Resumen', 'Summary'), style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (var k = 0; k < g.steps.length; k++)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: g.steps[k].warn ? Colors.red : g.color,
              child: Text('${k + 1}', style: const TextStyle(color: Colors.black)),
            ),
            title: Text(g.steps[k].title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(g.steps[k].text),
            onTap: () => setState(() => _i = k),
          ),
        const SizedBox(height: 12),
        if (tool != null)
          SizedBox(
            height: 56,
            child: FilledButton.icon(
              icon: Icon(tool.$1),
              label: Text(tool.$2),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => tool.$3())),
            ),
          ),
        const SizedBox(height: 8),
        if (art != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.menu_book),
            label: Text(tr('Aprender más: ${art.$2.title}', 'Learn more: ${art.$2.title}', 'Aprender mais: ${art.$2.title}')),
            onPressed: () => openArticle(context, art.$1, art.$2),
          ),
      ],
    );
  }
}
