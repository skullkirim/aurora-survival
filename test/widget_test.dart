import 'dart:io';

import 'package:apoca/core/morse.dart';

import 'package:apoca/core/alarms.dart';
import 'package:apoca/core/i18n.dart';
import 'package:apoca/core/tile_store.dart';
import 'package:apoca/core/vector_map.dart';
import 'package:apoca/data/pt/content_pt.dart';
import 'package:apoca/data/recipes.dart';
import 'package:apoca/screens/map_screen.dart' show buildGpx, polygonArea, pathLength;
import 'package:latlong2/latlong.dart';
import 'package:apoca/data/guides.dart';
import 'package:apoca/data/ill_map.dart';
import 'package:apoca/data/library.dart';
import 'package:apoca/data/species.dart';
import 'package:apoca/data/en/guides_en.dart';
import 'package:apoca/data/en/species_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SOS en morse', () {
    expect(toMorse('sos'), '··· ——— ···');
    expect(morseTimeline('E').length, 1);
    expect(fromMorse('... --- ...'), 'SOS');
    expect(fromMorse('.- -.-- ..- -.. .- / -.-- .-'), 'AYUDA YA');
    expect(fromMorse(toMorse('Agua 2')), 'AGUA 2');
    expect(morseWav(morseTimeline('E')).length, greaterThan(44));
  });

  test('Biblioteca consistente', () {
    final ids = <String>{};
    for (final c in library) {
      expect(c.articles, isNotEmpty);
      for (final a in c.articles) {
        expect(ids.add(a.id), isTrue, reason: 'id duplicado ${a.id}');
      }
      for (final q in c.quiz) {
        expect(q.answer, lessThan(q.options.length));
      }
    }
    expect(searchArticles('agua'), isNotEmpty);
  });

  test('Guía visual: ids únicos y referencias válidas', () {
    expect(speciesById.length, species.length);
    for (final c in library) {
      for (final a in c.articles) {
        for (final line in a.body.split('\n').where((l) => l.startsWith('@ '))) {
          for (final id in line.substring(2).split(',')) {
            expect(speciesById.containsKey(id.trim()), isTrue, reason: '${a.id} -> $id');
          }
        }
      }
    }
  });

  test('Guías: especies y artículos existen', () {
    for (final g in guides) {
      if (g.article != null) expect(articleIndex.containsKey(g.article), isTrue, reason: g.id);
      for (final st in g.steps) {
        for (final id in st.species) {
          expect(speciesById.containsKey(id), isTrue, reason: '${g.id} -> $id');
        }
      }
    }
  });

  test('Ilustraciones: todos los archivos existen', () {
    final names = <String>{
      for (final c in library) coverFor(c.id),
      for (final l in articleIll.values) for (final (n, _) in l) n,
      for (final m in guideIll.values) ...m.values,
    };
    for (final n in names) {
      expect(File('assets/ill/$n.svg').existsSync(), isTrue, reason: n);
    }
  });

  test('Mosaicos de mapa', () {
    expect(TileStore.lonToX(0, 1), 1);
    expect(TileStore.latToY(0, 1), 1);
    final t = TileStore.tilesFor(4.71, -74.07, 5, 6, 15);
    expect(t.length, greaterThan(50));
    expect(t.length, lessThan(400));
  });

  test('Inglés: mismo contenido que español', () {
    final es = {for (final c in libraryEs) for (final a in c.articles) a.id};
    final en = {for (final c in libraryEn) for (final a in c.articles) a.id};
    expect(en, es);
    expect([for (final c in libraryEn) c.id], [for (final c in libraryEs) c.id]);
    for (final s in speciesEs) {
      expect(speciesEnText.containsKey(s.id), isTrue, reason: s.id);
    }
    for (final g in guidesEs) {
      expect(guidesEnText[g.id]?.$3.length, g.steps.length, reason: g.id);
    }
    for (final c in libraryEn) {
      for (final q in c.quiz) {
        expect(q.answer, lessThan(q.options.length));
      }
      for (final a in c.articles) {
        for (final line in a.body.split('\n').where((l) => l.startsWith('@ '))) {
          for (final id in line.substring(2).split(',')) {
            expect(speciesEnText.containsKey(id.trim()), isTrue, reason: '${a.id} -> $id');
          }
        }
      }
    }
  });

  test('Portugués: guías y temas completos', () {
    for (final g in guidesEs) {
      expect(guidesPtText[g.id]?.$3.length, g.steps.length, reason: g.id);
    }
    for (final c in libraryEs) {
      expect(catPt.containsKey(c.id), isTrue, reason: c.id);
    }
    lang.value = 'pt';
    expect(tr('Inicio', 'Home'), 'Início');
    expect(tr('xyz', 'xyz-en'), 'xyz');
    expect(tr('a', 'b', 'c'), 'c');
    expect(guides.first.title, guidesPtText[guidesEs.first.id]!.$1);
    lang.value = 'es';
  });

  test('PMTiles: id de mosaico (curva de Hilbert)', () {
    expect(PmTiles.tileId(0, 0, 0), 0);
    expect(PmTiles.tileId(1, 0, 0), 1);
    expect(PmTiles.tileId(1, 0, 1), 2);
    expect(PmTiles.tileId(1, 1, 1), 3);
    expect(PmTiles.tileId(1, 1, 0), 4);
    expect(PmTiles.tileId(2, 0, 0), 5);
    expect(PmTiles.tileId(14, 4823, 7790), 139338518);
  });

  test('PMTiles: leer archivo y decodificar mosaico vectorial', () async {
    final pm = await PmTiles.open('test/fixtures/mini.pmtiles');
    expect(pm.isVector, isTrue);
    expect(pm.maxZoom, 2);
    for (final (z, x, y) in [(0, 0, 0), (1, 1, 0), (2, 3, 1), (2, 0, 3)]) {
      final raw = await pm.rawTile(z, x, y);
      expect(raw, isNotNull, reason: '$z/$x/$y');
      final layers = decodeTile(raw!, pm.tileCompression);
      expect(layers.keys.toSet(), {'earth', 'roads', 'places'});
      final place = layers['places']!.features.single;
      expect(place.props['name'], 'Pueblo');
      expect(place.props['name:en'], 'Town');
      expect(place.kind, 'locality');
      expect(geometryParts(place).first.first, (2048, 2048));
      final road = layers['roads']!.features.single;
      expect(road.type, 2);
      expect(geometryParts(road).first.length, 2);
      expect(geometryParts(layers['earth']!.features.single).first.length, greaterThanOrEqualTo(4));
    }
    expect(await pm.rawTile(3, 0, 0), isNull);
    await pm.close();
  });

  test('Medir y exportar', () {
    // Cuadrado de ~111 m x ~111 m en el ecuador ≈ 1,23 ha
    final sq = [const LatLng(0, 0), const LatLng(0, 0.001), const LatLng(0.001, 0.001), const LatLng(0.001, 0)];
    expect(polygonArea(sq), closeTo(12364, 300));
    expect(pathLength(sq), closeTo(333, 5));
    final gpx = buildGpx([
      {'name': 'Agua <río>', 'type': 'Agua', 'lat': 4.7, 'lon': -74.1}
    ], [
      {'lat': 4.7, 'lon': -74.1, 't': 0},
      {'lat': 4.71, 'lon': -74.1, 't': 60000},
    ]);
    expect(gpx, contains('<wpt lat="4.7" lon="-74.1"><name>Agua &lt;río&gt;</name>'));
    expect(gpx, contains('<trkpt'));
    expect(gpx.trim(), endsWith('</gpx>'));
  });

  test('Recetas: ingredientes válidos y despensa', () {
    for (final r in recipes) {
      for (final g in [...r.needs, ...r.optional]) {
        for (final id in g.split('|')) {
          expect(ingredients.containsKey(id), isTrue, reason: '${r.id} -> $id');
        }
      }
    }
    final pantry = <Map<String, dynamic>>[
      {'name': 'Arroz Diana', 'qty': 2, 'cat': 'Comida'},
      {'name': 'Lentejas', 'qty': 1, 'cat': 'Comida'},
      {'name': 'Agua', 'qty': 10, 'cat': 'Agua'},
      {'name': 'Salsa de tomate', 'qty': 1, 'cat': 'Comida'},
      {'name': 'Harina', 'qty': 0, 'cat': 'Comida'},
    ];
    expect(hasIngredient('arroz', pantry), isTrue);
    expect(hasIngredient('lenteja', pantry), isTrue);
    expect(hasIngredient('sal', pantry), isFalse); // "salsa" no es sal
    expect(hasIngredient('harina', pantry), isFalse); // cantidad 0
    final ranked = rankRecipes(pantry);
    expect(ranked.first.$3, isEmpty);
    expect(ranked.first.$1.id, anyOf('arroz_grano', 'sopa_lenteja'));
  });

  test('Alarmas: avisos de torniquete y guardia', () {
    final t = Alarms.occurrences({'type': 'torniquete', 'title': '', 'start': 0});
    expect(t.first.$1, 60 * 60000);
    final g = Alarms.occurrences({'type': 'guardia', 'title': '', 'start': 0, 'every': 120, 'names': ['Ana', 'Luis']});
    expect(g.length, 24);
    expect(g.first.$3, contains('Luis'));
    final m = Alarms.occurrences({'type': 'medicina', 'title': 'X', 'start': 0, 'every': 480, 'count': 3});
    expect(m.map((e) => e.$1).toList(), [0, 480 * 60000, 960 * 60000]);
  });
}
