import 'package:flutter/material.dart';

import '../data/species.dart';
import '../screens/atlas_screen.dart' show SpeciesCard;

/// Renderiza el marcado sencillo de los artículos sin dependencias externas.
class Markup extends StatelessWidget {
  final String text;
  final double scale;
  const Markup(this.text, {super.key, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = TextStyle(fontSize: 16 * scale, height: 1.45, color: cs.onSurface);
    final children = <Widget>[];

    for (final raw in text.trim().split('\n')) {
      final line = raw.trimRight();
      if (line.trim().isEmpty) {
        children.add(SizedBox(height: 8 * scale));
      } else if (line.startsWith('@ ')) {
        // Fila de tarjetas con foto: "@ mango, guayaba, papaya"
        final items = line
            .substring(2)
            .split(',')
            .map((e) => speciesById[e.trim()])
            .whereType<Species>()
            .toList();
        if (items.isNotEmpty) {
          children.add(SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [for (final s in items) SpeciesCard(s, width: 150)],
            ),
          ));
        }
      } else if (line.startsWith('## ')) {
        children.add(Padding(
          padding: EdgeInsets.only(top: 10 * scale, bottom: 4 * scale),
          child: Text(line.substring(3),
              style: base.copyWith(
                  fontSize: 19 * scale,
                  fontWeight: FontWeight.bold,
                  color: cs.primary)),
        ));
      } else if (line.startsWith('- ')) {
        children.add(Padding(
          padding: EdgeInsets.only(left: 4 * scale, bottom: 3 * scale),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('•  ', style: base.copyWith(color: cs.primary)),
            Expanded(child: Text(line.substring(2), style: base)),
          ]),
        ));
      } else if (line.startsWith('! ') || line.startsWith('* ')) {
        final warn = line.startsWith('!');
        final color = warn ? const Color(0xFFE53935) : const Color(0xFF43A047);
        children.add(Container(
          margin: EdgeInsets.symmetric(vertical: 4 * scale),
          padding: EdgeInsets.all(10 * scale),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: color, width: 4)),
            color: color.withValues(alpha: 0.08),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(warn ? Icons.warning_amber : Icons.lightbulb_outline,
                color: color, size: 20 * scale),
            const SizedBox(width: 8),
            Expanded(child: Text(line.substring(2), style: base)),
          ]),
        ));
      } else {
        children.add(Text(line, style: base));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }
}
