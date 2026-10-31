import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:path_provider/path_provider.dart';

import 'i18n.dart';
import 'storage.dart';

// =====================================================================
// MAPA SIN INTERNET DE VERDAD: archivos .pmtiles (Protomaps / OpenStreetMap)
// Lector PMTiles v3 + decodificador de mosaicos vectoriales (MVT) + dibujo.
// Todo en Dart, sin dependencias nuevas. Se dibuja solo lo que se ve.
// =====================================================================

class _Entry {
  final int tileId, offset, length, runLength;
  const _Entry(this.tileId, this.offset, this.length, this.runLength);
}

/// Lector de varint / protobuf mínimo.
class _Pbf {
  _Pbf(this.b, [this.pos = 0, int? end]) : end = end ?? b.length;
  final Uint8List b;
  int pos;
  final int end;
  bool get more => pos < end;

  int varint() {
    var result = 0;
    var shift = 0;
    while (true) {
      final byte = b[pos++];
      if (shift < 63) result |= (byte & 0x7f) << shift;
      if (byte < 0x80) return result;
      shift += 7;
    }
  }

  void skip(int wire) {
    switch (wire) {
      case 0:
        varint();
      case 1:
        pos += 8;
      case 2:
        final l = varint(); // leer primero la longitud: pos cambia al leerla
        pos += l;
      case 5:
        pos += 4;
      default:
        throw FormatException('protobuf: tipo $wire');
    }
  }

  String string() {
    final l = varint();
    final s = utf8.decode(Uint8List.sublistView(b, pos, pos + l), allowMalformed: true);
    pos += l;
    return s;
  }

  List<int> packed() {
    final l = varint();
    final e = pos + l;
    final out = <int>[];
    while (pos < e) {
      out.add(varint());
    }
    return out;
  }

  double f32() {
    final v = ByteData.sublistView(b, pos, pos + 4).getFloat32(0, Endian.little);
    pos += 4;
    return v;
  }

  double f64() {
    final v = ByteData.sublistView(b, pos, pos + 8).getFloat64(0, Endian.little);
    pos += 8;
    return v;
  }
}

Uint8List _decompress(Uint8List data, int compression) => switch (compression) {
      0 || 1 => data,
      2 => Uint8List.fromList(gzip.decode(data)),
      _ => throw UnsupportedError('Compresión $compression no soportada: usa gzip (lo normal en Protomaps)'),
    };

/// Archivo PMTiles v3 abierto.
class PmTiles {
  PmTiles._(this.path, this._raf, ByteData h) {
    int u64(int o) => h.getUint64(o, Endian.little);
    double e7(int o) => h.getInt32(o, Endian.little) / 1e7;
    rootOffset = u64(8);
    rootLength = u64(16);
    leafOffset = u64(40);
    dataOffset = u64(56);
    internalCompression = h.getUint8(97);
    tileCompression = h.getUint8(98);
    tileType = h.getUint8(99);
    minZoom = h.getUint8(100);
    maxZoom = h.getUint8(101);
    minLon = e7(102);
    minLat = e7(106);
    maxLon = e7(110);
    maxLat = e7(114);
    centerZoom = h.getUint8(118);
    centerLon = e7(119);
    centerLat = e7(123);
  }

  final String path;
  final RandomAccessFile _raf;
  late final int rootOffset, rootLength, leafOffset, dataOffset;
  late final int internalCompression, tileCompression, tileType, minZoom, maxZoom, centerZoom;
  late final double minLon, minLat, maxLon, maxLat, centerLon, centerLat;
  late final List<_Entry> _root;
  final _leaves = <int, List<_Entry>>{};
  Future<void> _lock = Future.value();

  /// 1 = vectorial (MVT); 2 png, 3 jpg, 4 webp = imágenes.
  bool get isVector => tileType == 1;

  static Future<PmTiles> open(String path) async {
    final raf = await File(path).open();
    try {
      final head = await raf.read(127);
      if (head.length < 127 || String.fromCharCodes(head.sublist(0, 7)) != 'PMTiles') {
        throw const FormatException('No es un archivo .pmtiles');
      }
      if (head[7] != 3) throw FormatException('PMTiles versión ${head[7]}: se necesita la versión 3');
      final p = PmTiles._(path, raf, ByteData.sublistView(Uint8List.fromList(head)));
      p._root = _parseDirectory(_decompress(await p._read(p.rootOffset, p.rootLength), p.internalCompression));
      return p;
    } catch (_) {
      await raf.close();
      rethrow;
    }
  }

  Future<void> close() => _raf.close();

  /// Lecturas en serie (RandomAccessFile no permite dos a la vez).
  Future<Uint8List> _read(int offset, int length) {
    final c = Completer<Uint8List>();
    _lock = _lock.then((_) async {
      try {
        await _raf.setPosition(offset);
        c.complete(await _raf.read(length));
      } catch (e, s) {
        c.completeError(e, s);
      }
    });
    return c.future;
  }

  static List<_Entry> _parseDirectory(Uint8List b) {
    final r = _Pbf(b);
    final n = r.varint();
    final ids = List<int>.filled(n, 0);
    var last = 0;
    for (var i = 0; i < n; i++) {
      last += r.varint();
      ids[i] = last;
    }
    final runs = [for (var i = 0; i < n; i++) r.varint()];
    final lens = [for (var i = 0; i < n; i++) r.varint()];
    final offs = List<int>.filled(n, 0);
    for (var i = 0; i < n; i++) {
      final v = r.varint();
      offs[i] = (v == 0 && i > 0) ? offs[i - 1] + lens[i - 1] : v - 1;
    }
    return [for (var i = 0; i < n; i++) _Entry(ids[i], offs[i], lens[i], runs[i])];
  }

  /// Número de mosaico en la curva de Hilbert (especificación PMTiles v3).
  static int tileId(int z, int x, int y) {
    var acc = 0;
    for (var i = 0; i < z; i++) {
      acc += 1 << (2 * i);
    }
    final n = 1 << z;
    var tx = x, ty = y, d = 0;
    for (var s = n >> 1; s > 0; s >>= 1) {
      final rx = (tx & s) > 0 ? 1 : 0;
      final ry = (ty & s) > 0 ? 1 : 0;
      d += s * s * ((3 * rx) ^ ry);
      if (ry == 0) {
        if (rx == 1) {
          tx = n - 1 - tx;
          ty = n - 1 - ty;
        }
        final t = tx;
        tx = ty;
        ty = t;
      }
    }
    return acc + d;
  }

  static _Entry? _find(List<_Entry> e, int id) {
    var lo = 0, hi = e.length - 1;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      final c = id - e[mid].tileId;
      if (c > 0) {
        lo = mid + 1;
      } else if (c < 0) {
        hi = mid - 1;
      } else {
        return e[mid];
      }
    }
    if (hi >= 0) {
      final x = e[hi];
      if (x.runLength == 0 || id - x.tileId < x.runLength) return x;
    }
    return null;
  }

  Future<List<_Entry>> _leaf(int offset, int length) async {
    final hit = _leaves.remove(offset);
    if (hit != null) return _leaves[offset] = hit;
    final dir = _parseDirectory(_decompress(await _read(offset, length), internalCompression));
    _leaves[offset] = dir;
    if (_leaves.length > 64) _leaves.remove(_leaves.keys.first);
    return dir;
  }

  /// Bytes del mosaico (aún comprimidos) o null si no está en el archivo.
  Future<Uint8List?> rawTile(int z, int x, int y) async {
    final id = tileId(z, x, y);
    var dir = _root;
    for (var depth = 0; depth < 4; depth++) {
      final e = _find(dir, id);
      if (e == null) return null;
      if (e.runLength > 0) return _read(dataOffset + e.offset, e.length);
      dir = await _leaf(leafOffset + e.offset, e.length);
    }
    return null;
  }
}

// ---------------------------------------------------------------------
// Mosaicos vectoriales (Mapbox Vector Tile 2.1)
// ---------------------------------------------------------------------

/// Elemento del mapa: tipo (1 punto, 2 línea, 3 polígono), propiedades y geometría codificada.
class VFeature {
  VFeature(this.type, this.props, this.geom);
  final int type;
  final Map<String, Object?> props;
  final List<int> geom;

  String get kind => (props['kind'] ?? props['pmap:kind'] ?? '').toString();
}

class VLayer {
  VLayer(this.extent, this.features);
  final int extent;
  final List<VFeature> features;
}

const _wantedLayers = {
  'earth', 'landcover', 'landuse', 'natural', 'water', 'roads', 'buildings', 'boundaries', 'places', 'pois', 'transit'
};
const _wantedProps = {
  'kind', 'pmap:kind', 'kind_detail', 'name', 'name:es', 'name:en', 'name:pt', 'min_zoom', 'population_rank'
};

/// Descomprime y decodifica un mosaico (corre en otro hilo para no trabar la pantalla).
Map<String, VLayer> decodeTile(Uint8List compressed, int compression) {
  final b = _decompress(compressed, compression);
  final r = _Pbf(b);
  final out = <String, VLayer>{};
  while (r.more) {
    final key = r.varint();
    if (key >> 3 == 3 && key & 7 == 2) {
      final len = r.varint();
      final l = _decodeLayer(_Pbf(b, r.pos, r.pos + len));
      r.pos += len;
      if (l != null) out[l.$1] = l.$2;
    } else {
      r.skip(key & 7);
    }
  }
  return out;
}

Map<String, VLayer> _decodeArgs((Uint8List, int) a) => decodeTile(a.$1, a.$2);

(String, VLayer)? _decodeLayer(_Pbf r) {
  var name = '';
  var extent = 4096;
  final keys = <String>[];
  final values = <Object?>[];
  final feats = <(int, int)>[];
  while (r.more) {
    final key = r.varint();
    final f = key >> 3;
    if (f == 1) {
      name = r.string();
      if (!_wantedLayers.contains(name)) return null;
    } else if (f == 2) {
      final len = r.varint();
      feats.add((r.pos, r.pos + len));
      r.pos += len;
    } else if (f == 3) {
      keys.add(r.string());
    } else if (f == 4) {
      final len = r.varint();
      final v = _Pbf(r.b, r.pos, r.pos + len);
      Object? val;
      while (v.more) {
        final k = v.varint();
        switch (k >> 3) {
          case 1:
            val = v.string();
          case 2:
            val = v.f32();
          case 3:
            val = v.f64();
          case 4 || 5:
            val = v.varint();
          case 6:
            final z = v.varint();
            val = (z >> 1) ^ -(z & 1);
          case 7:
            val = v.varint() != 0;
          default:
            v.skip(k & 7);
        }
      }
      values.add(val);
      r.pos += len;
    } else if (f == 5) {
      extent = r.varint();
    } else {
      r.skip(key & 7);
    }
  }
  final features = <VFeature>[];
  for (final (s, e) in feats) {
    final p = _Pbf(r.b, s, e);
    var type = 0;
    var tags = const <int>[];
    var geom = const <int>[];
    while (p.more) {
      final key = p.varint();
      switch (key >> 3) {
        case 2:
          tags = p.packed();
        case 3:
          type = p.varint();
        case 4:
          geom = p.packed();
        default:
          p.skip(key & 7);
      }
    }
    final props = <String, Object?>{};
    for (var i = 0; i + 1 < tags.length; i += 2) {
      if (tags[i] < keys.length && tags[i + 1] < values.length) {
        final k = keys[tags[i]];
        if (_wantedProps.contains(k)) props[k] = values[tags[i + 1]];
      }
    }
    features.add(VFeature(type, props, geom));
  }
  return (name, VLayer(extent, features));
}

/// Convierte la geometría a partes (anillos, líneas o puntos) en coordenadas del mosaico.
List<List<(int, int)>> geometryParts(VFeature f) {
  final g = f.geom;
  final parts = <List<(int, int)>>[];
  var x = 0, y = 0, i = 0;
  List<(int, int)>? cur;
  int zz(int v) => (v >> 1) ^ -(v & 1);
  while (i < g.length) {
    final cmd = g[i++];
    final id = cmd & 7;
    final count = cmd >> 3;
    if (id == 1) {
      for (var k = 0; k < count && i + 1 < g.length; k++) {
        x += zz(g[i++]);
        y += zz(g[i++]);
        cur = [(x, y)];
        parts.add(cur);
      }
    } else if (id == 2) {
      for (var k = 0; k < count && i + 1 < g.length; k++) {
        x += zz(g[i++]);
        y += zz(g[i++]);
        cur?.add((x, y));
      }
    } else if (id == 7) {
      // ClosePath: el Path se cierra al dibujar.
    } else {
      break;
    }
  }
  return parts;
}

// ---------------------------------------------------------------------
// Estilo oscuro (AMOLED): poco brillo = poca batería.
// ---------------------------------------------------------------------
const _bgMissing = ui.Color(0xFF0D0D0D);
const _water = ui.Color(0xFF0E2A3D);
const _waterLine = ui.Color(0xFF1F5577);
const _earth = ui.Color(0xFF161616);
const _building = ui.Color(0xFF2B2B2B);

ui.Color? _areaColor(String layer, String kind) {
  if (layer == 'water') return _water;
  if (layer == 'earth') return _earth;
  return switch (kind) {
    'forest' || 'wood' || 'nature_reserve' || 'national_park' || 'protected_area' => const ui.Color(0xFF13301E),
    'park' || 'garden' || 'grass' || 'grassland' || 'pitch' || 'playground' || 'golf_course' || 'recreation_ground' || 'village_green' =>
      const ui.Color(0xFF16321F),
    'scrub' || 'meadow' || 'heath' => const ui.Color(0xFF172A1A),
    'farmland' || 'farmyard' || 'orchard' || 'allotments' || 'vineyard' || 'plant_nursery' => const ui.Color(0xFF1D2417),
    'wetland' || 'marsh' || 'swamp' || 'bog' => const ui.Color(0xFF13292B),
    'beach' || 'sand' || 'barren' || 'bare_rock' || 'scree' => const ui.Color(0xFF2A271E),
    'glacier' => const ui.Color(0xFF2B3237),
    'hospital' || 'clinic' => const ui.Color(0xFF3A1D1D),
    'school' || 'university' || 'college' || 'kindergarten' => const ui.Color(0xFF29251A),
    'cemetery' || 'grave_yard' => const ui.Color(0xFF1C281D),
    'industrial' || 'commercial' || 'retail' || 'railway' => const ui.Color(0xFF211E24),
    'residential' || 'urban_area' => const ui.Color(0xFF1C1C1C),
    'aerodrome' || 'airfield' || 'military' => const ui.Color(0xFF222222),
    _ => null,
  };
}

const _areaOrder = ['earth', 'landcover', 'natural', 'landuse', 'water'];

/// Ancho de vía (px lógicos) y color según tipo y zoom.
(double, ui.Color)? _road(String kind, String detail, int z) {
  double lerp(int z0, double w0, int z1, double w1) =>
      z <= z0 ? w0 : (z >= z1 ? w1 : w0 + (w1 - w0) * (z - z0) / (z1 - z0));
  return switch (kind) {
    'highway' => (lerp(5, 0.8, 16, 9), const ui.Color(0xFFD08A2E)),
    'major_road' => z < 8 ? null : (lerp(8, 0.6, 17, 8), const ui.Color(0xFFB79B5C)),
    'minor_road' => z < 12 ? null : (lerp(12, 0.5, 18, 7), detail == 'service' ? const ui.Color(0xFF444444) : const ui.Color(0xFF5F5F5F)),
    'path' => z < 14 ? null : (lerp(14, 0.6, 18, 2), const ui.Color(0xFF6B6448)),
    'rail' => z < 10 ? null : (lerp(10, 0.5, 18, 2), const ui.Color(0xFF555566)),
    'ferry' => (1.0, const ui.Color(0xFF2A5C80)),
    'aeroway' => z < 12 ? null : (lerp(12, 1, 16, 10), const ui.Color(0xFF333333)),
    _ => null,
  };
}

const _roadOrder = ['ferry', 'aeroway', 'rail', 'path', 'minor_road', 'major_road', 'highway'];

String? _label(VFeature f) {
  final n = f.props['name:${lang.value}'] ?? f.props['name'];
  return n is String && n.isNotEmpty ? n : null;
}

int _int(Object? v, int def) => v is int ? v : (v is double ? v.round() : def);

/// Dibuja un mosaico. [k]/[ox]/[oy]: escala y desplazamiento de coordenadas del mosaico a píxeles.
void paintVectorTile(ui.Canvas c, Map<String, VLayer> layers, int z, double k, double ox, double oy, double size, double pr) {
  c.drawRect(ui.Rect.fromLTWH(0, 0, size, size), ui.Paint()..color = layers.containsKey('earth') ? _water : _bgMissing);
  c.clipRect(ui.Rect.fromLTWH(0, 0, size, size));

  ui.Path pathOf(VFeature f, {bool close = false}) {
    final p = ui.Path()..fillType = ui.PathFillType.evenOdd;
    for (final part in geometryParts(f)) {
      if (part.isEmpty) continue;
      p.moveTo(part.first.$1 * k + ox, part.first.$2 * k + oy);
      for (var i = 1; i < part.length; i++) {
        p.lineTo(part[i].$1 * k + ox, part[i].$2 * k + oy);
      }
      if (close) p.close();
    }
    return p;
  }

  // 1. Áreas: tierra, coberturas, usos del suelo y agua
  final fill = ui.Paint()..style = ui.PaintingStyle.fill;
  for (final name in _areaOrder) {
    final l = layers[name];
    if (l == null) continue;
    for (final f in l.features) {
      if (f.type != 3) continue;
      final col = _areaColor(name, f.kind);
      if (col == null) continue;
      c.drawPath(pathOf(f, close: true), fill..color = col);
    }
  }
  // Ríos y quebradas
  final stroke = ui.Paint()
    ..style = ui.PaintingStyle.stroke
    ..strokeCap = ui.StrokeCap.round
    ..strokeJoin = ui.StrokeJoin.round;
  for (final f in layers['water']?.features ?? const <VFeature>[]) {
    if (f.type != 2) continue;
    final w = (f.props['kind_detail'] == 'river' || f.kind == 'river') ? 2.0 : 1.0;
    c.drawPath(pathOf(f), stroke
      ..color = _waterLine
      ..strokeWidth = w * pr * (z >= 14 ? 1.6 : 1));
  }
  // 2. Edificios
  if (z >= 14) {
    for (final f in layers['buildings']?.features ?? const <VFeature>[]) {
      if (f.type == 3) c.drawPath(pathOf(f, close: true), fill..color = _building);
    }
  }
  // 3. Límites
  for (final f in layers['boundaries']?.features ?? const <VFeature>[]) {
    if (f.type != 2) continue;
    final country = f.kind == 'country';
    c.drawPath(pathOf(f), stroke
      ..color = country ? const ui.Color(0xFF8A5A8A) : const ui.Color(0xFF5A4A5A)
      ..strokeWidth = (country ? 1.6 : 0.8) * pr);
  }
  // 4. Vías, de menor a mayor
  final roads = layers['roads']?.features ?? const <VFeature>[];
  for (final kind in _roadOrder) {
    for (final f in roads) {
      if (f.type != 2 || f.kind != kind) continue;
      final st = _road(kind, (f.props['kind_detail'] ?? '').toString(), z);
      if (st == null) continue;
      c.drawPath(pathOf(f), stroke
        ..color = st.$2
        ..strokeWidth = st.$1 * pr);
    }
  }
  // 5. Nombres de lugares (sin encimarse)
  final taken = <ui.Rect>[];
  void label(String text, double x, double y, double fs, ui.Color color) {
    final size2 = fs * pr;
    ui.Paragraph para(ui.TextStyle style) {
      final b = ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: ui.TextAlign.center, maxLines: 2, ellipsis: '…'))
        ..pushStyle(style)
        ..addText(text);
      return b.build()..layout(ui.ParagraphConstraints(width: 150 * pr));
    }

    final fg = para(ui.TextStyle(color: color, fontSize: size2, fontWeight: ui.FontWeight.w600));
    final w = fg.longestLine, h = fg.height;
    final rect = ui.Rect.fromCenter(center: ui.Offset(x, y), width: w + 6 * pr, height: h + 2 * pr);
    if (rect.left < 0 || rect.top < 0 || rect.right > size || rect.bottom > size) return;
    if (taken.any((r) => r.overlaps(rect))) return;
    taken.add(rect);
    final at = ui.Offset(x - 75 * pr, y - h / 2);
    final halo = para(ui.TextStyle(
        fontSize: size2,
        fontWeight: ui.FontWeight.w600,
        foreground: ui.Paint()
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = 3 * pr
          ..color = const ui.Color(0xE6000000)));
    c.drawParagraph(halo, at);
    c.drawParagraph(fg, at);
  }

  final places = [...?layers['places']?.features]
    ..sort((a, b) => _int(b.props['population_rank'], 0).compareTo(_int(a.props['population_rank'], 0)));
  for (final f in places) {
    if (f.type != 1 || f.geom.length < 3) continue;
    if (_int(f.props['min_zoom'], 0) > z + 1) continue;
    final t = _label(f);
    if (t == null) continue;
    final (fs, col) = switch (f.kind) {
      'country' => (z <= 6 ? 14.0 : 0.0, const ui.Color(0xFFE0C8E0)),
      'region' => (z >= 5 && z <= 9 ? 12.0 : 0.0, const ui.Color(0xFFB8A8B8)),
      'locality' => (z >= 7 ? (11 + _int(f.props['population_rank'], 0) / 3).clamp(11, 16).toDouble() : 0.0, const ui.Color(0xFFFFFFFF)),
      'macrohood' || 'neighbourhood' => (z >= 13 ? 10.0 : 0.0, const ui.Color(0xFFA0A0A0)),
      _ => (0.0, const ui.Color(0xFFFFFFFF)),
    };
    if (fs == 0) continue;
    final p = geometryParts(f).first.first;
    label(t, p.$1 * k + ox, p.$2 * k + oy, fs, col);
  }
  if (z >= 15) {
    for (final f in layers['pois']?.features ?? const <VFeature>[]) {
      if (f.type != 1 || f.geom.length < 3) continue;
      final t = _label(f);
      if (t == null) continue;
      final important = const {'hospital', 'clinic', 'pharmacy', 'police', 'fire_station', 'drinking_water', 'school', 'townhall', 'place_of_worship'}
          .contains(f.kind);
      if (!important && z < 17) continue;
      final p = geometryParts(f).first.first;
      label(t, p.$1 * k + ox, p.$2 * k + oy, 9.5,
          important ? const ui.Color(0xFFFFB0A0) : const ui.Color(0xFF9E9E9E));
    }
  }
}

// ---------------------------------------------------------------------
// Fuente de mapa: archivo + caché de mosaicos ya decodificados
// ---------------------------------------------------------------------
class VectorSource {
  VectorSource(this.pm);
  final PmTiles pm;
  final _cache = <int, Future<Map<String, VLayer>?>>{};
  static const px = 512.0; // tamaño de la imagen de cada mosaico (2x para nitidez)

  Future<Map<String, VLayer>?> _decoded(int z, int x, int y) {
    final id = PmTiles.tileId(z, x, y);
    final hit = _cache.remove(id);
    if (hit != null) return _cache[id] = hit;
    final f = () async {
      final raw = await pm.rawTile(z, x, y);
      if (raw == null) return null;
      return compute(_decodeArgs, (raw, pm.tileCompression));
    }();
    _cache[id] = f;
    if (_cache.length > 24) _cache.remove(_cache.keys.first);
    return f;
  }

  Future<ui.Image> render(int z, int x, int y) async {
    if (!pm.isVector) return _raster(z, x, y);
    // Más cerca que el máximo del archivo: se dibuja una parte del mosaico "padre" (sigue nítido).
    final dz = math.max(0, z - pm.maxZoom);
    final pz = z - dz, pxi = x >> dz, pyi = y >> dz;
    Map<String, VLayer>? layers;
    if (pz >= pm.minZoom) layers = await _decoded(pz, pxi, pyi);
    final rec = ui.PictureRecorder();
    final c = ui.Canvas(rec);
    if (layers == null || layers.isEmpty) {
      c.drawRect(const ui.Rect.fromLTWH(0, 0, px, px), ui.Paint()..color = _bgMissing);
    } else {
      final extent = layers.values.first.extent;
      final scale = (1 << dz).toDouble();
      final k = px / extent * scale;
      final ox = -(x - (pxi << dz)) * px;
      final oy = -(y - (pyi << dz)) * px;
      paintVectorTile(c, layers, z, k, ox, oy, px, 2);
    }
    return rec.endRecording().toImage(px.toInt(), px.toInt());
  }

  Future<ui.Image> _raster(int z, int x, int y) async {
    final raw = await pm.rawTile(z, x, y);
    if (raw != null) {
      try {
        final codec = await ui.instantiateImageCodec(_decompress(raw, pm.tileCompression));
        return (await codec.getNextFrame()).image;
      } catch (_) {}
    }
    final rec = ui.PictureRecorder();
    ui.Canvas(rec).drawRect(const ui.Rect.fromLTWH(0, 0, 256, 256), ui.Paint()..color = _bgMissing);
    return rec.endRecording().toImage(256, 256);
  }
}

class VectorTileProvider extends TileProvider {
  VectorTileProvider(this.source);
  final VectorSource source;
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) =>
      VectorTileImage(source, coordinates.z, coordinates.x, coordinates.y, lang.value);
}

class VectorTileImage extends ImageProvider<VectorTileImage> {
  const VectorTileImage(this.source, this.z, this.x, this.y, this.lng);
  final VectorSource source;
  final int z, x, y;
  final String lng;

  @override
  Future<VectorTileImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(VectorTileImage key, ImageDecoderCallback decode) =>
      OneFrameImageStreamCompleter(source.render(z, x, y).then((img) => ImageInfo(image: img)));

  @override
  bool operator ==(Object other) =>
      other is VectorTileImage &&
      other.source.pm.path == source.pm.path &&
      other.z == z &&
      other.x == x &&
      other.y == y &&
      other.lng == lng;

  @override
  int get hashCode => Object.hash(source.pm.path, z, x, y, lng);
}

// ---------------------------------------------------------------------
// Dónde vive el archivo del mapa
// ---------------------------------------------------------------------
class OfflineMap {
  OfflineMap._();
  static VectorSource? source;
  static String? error;
  static final ValueNotifier<int> changes = ValueNotifier(0);

  /// Usar el mapa del archivo (true) o el de internet (false).
  static bool get preferFile => Store.getBool('map_use_file', true);
  static Future<void> setPreferFile(bool v) async {
    await Store.setBool('map_use_file', v);
    changes.value++;
  }

  /// Carpeta donde el script del PC deja el mapa por cable (no necesita permisos):
  /// /sdcard/Android/data/com.panlabstudios.apoca/files
  static Future<Directory?> externalDir() async {
    try {
      return await getExternalStorageDirectory();
    } catch (_) {
      return null;
    }
  }

  static Future<Directory> _internalDir() async {
    final d = Directory('${(await getApplicationDocumentsDirectory()).path}/maps');
    if (!await d.exists()) await d.create(recursive: true);
    return d;
  }

  static Future<List<File>> files() async {
    final out = <File>[];
    for (final d in [await externalDir(), await _internalDir()]) {
      if (d == null || !await d.exists()) continue;
      await for (final f in d.list()) {
        if (f is File && f.path.toLowerCase().endsWith('.pmtiles')) out.add(f);
      }
    }
    return out;
  }

  /// Abre el mapa guardado (el elegido, o el primero que encuentre).
  static Future<VectorSource?> load({bool force = false}) async {
    if (source != null && !force) return source;
    error = null;
    final list = await files();
    if (list.isEmpty) {
      await _replace(null);
      return null;
    }
    final chosen = Store.getString('pm_path');
    final f = list.firstWhere((f) => f.path == chosen, orElse: () => list.first);
    try {
      final pm = await PmTiles.open(f.path);
      await _replace(VectorSource(pm));
      await Store.setString('pm_path', f.path);
    } catch (e) {
      error = '$e';
      await _replace(null);
    }
    return source;
  }

  static Future<void> _replace(VectorSource? s) async {
    final old = source;
    source = s;
    if (old != null && old != s) {
      try {
        await old.pm.close();
      } catch (_) {}
    }
    changes.value++;
  }

  static Future<void> choose(String path) async {
    await Store.setString('pm_path', path);
    await load(force: true);
  }

  /// Importar un .pmtiles desde Descargas u otra carpeta del teléfono.
  static Future<String?> import() async {
    final r = await FilePicker.platform.pickFiles(type: FileType.any);
    final path = r?.files.single.path;
    if (path == null) return null;
    if (!path.toLowerCase().endsWith('.pmtiles')) {
      return tr('Ese archivo no es .pmtiles', 'That file is not a .pmtiles', 'Esse arquivo não é .pmtiles');
    }
    final src = File(path);
    final dest = '${(await _internalDir()).path}/${src.uri.pathSegments.last}';
    try {
      await src.rename(dest); // el selector ya hizo una copia: moverla es instantáneo
    } catch (_) {
      await src.copy(dest);
    }
    await Store.setString('pm_path', dest);
    await load(force: true);
    return error;
  }

  static Future<void> delete(File f) async {
    if (source?.pm.path == f.path) await _replace(null);
    try {
      await f.delete();
    } catch (_) {}
    await load(force: true);
  }
}
