import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'storage.dart';

/// Almacén de mosaicos de mapa (OpenStreetMap) en el teléfono.
/// - Con internet: muestra el mapa y GUARDA LO QUE VES (permitido por OSM: caché de lo visto).
/// - Sin internet: usa solo lo guardado (no intenta conectarse cada vez: ahorra batería).
/// OJO: OpenStreetMap prohíbe descargar zonas por adelantado ("bulk"/offline),
/// por eso no hay botón de descarga masiva.
class TileStore {
  TileStore._();
  static const url = 'https://tile.openstreetmap.org';
  static const userAgent = 'AuroraSurvival/1.6 (+https://github.com/skullkirim; Android app by PanLabStudios)';
  static Directory? _dir;
  static final _client = http.Client();
  static DateTime _offlineUntil = DateTime.fromMillisecondsSinceEpoch(0);

  static Future<Directory> dir() async {
    if (_dir != null) return _dir!;
    final d = Directory('${(await getApplicationDocumentsDirectory()).path}/tiles');
    if (!await d.exists()) await d.create(recursive: true);
    return _dir = d;
  }

  static Future<File> file(int z, int x, int y) async => File('${(await dir()).path}/$z/$x/$y.png');

  /// Borra la caché de versiones anteriores (pudo guardar mosaicos "bloqueados").
  static Future<void> migrate() async {
    if (Store.getInt('tiles_v') < 5) {
      try {
        await clear();
      } catch (_) {}
      await Store.setInt('tiles_v', 5);
    }
  }

  static bool get probablyOffline => DateTime.now().isBefore(_offlineUntil);

  /// Mayor zoom descargado (para no mostrar zonas vacías al acercar sin internet).
  static int get maxSavedZoom => Store.getInt('tiles_maxz', 0);
  static Future<void> noteZoom(int z) async {
    if (z > maxSavedZoom) await Store.setInt('tiles_maxz', z);
  }

  /// Descarga un mosaico y lo guarda. Lanza error si no hay conexión.
  static Future<Uint8List> fetch(int z, int x, int y) async {
    if (probablyOffline) throw const SocketException('sin conexión (pausa)');
    try {
      final r = await _client
          .get(Uri.parse('$url/$z/$x/$y.png'), headers: {'User-Agent': userAgent})
          .timeout(const Duration(seconds: 15));
      if (r.statusCode != 200) throw HttpException('HTTP ${r.statusCode}');
      final f = await file(z, x, y);
      await f.parent.create(recursive: true);
      await f.writeAsBytes(r.bodyBytes, flush: false);
      await noteZoom(z);
      return r.bodyBytes;
    } on HttpException {
      rethrow;
    } catch (_) {
      // Sin red: no volver a intentar durante 1 minuto (ahorra batería).
      _offlineUntil = DateTime.now().add(const Duration(seconds: 60));
      rethrow;
    }
  }

  // ---------- matemáticas de mosaicos ----------
  static int lonToX(double lon, int z) => ((lon + 180) / 360 * (1 << z)).floor().clamp(0, (1 << z) - 1);
  static int latToY(double lat, int z) {
    final r = lat * pi / 180;
    return ((1 - log(tan(r) + 1 / cos(r)) / pi) / 2 * (1 << z)).floor().clamp(0, (1 << z) - 1);
  }

  /// Lista de mosaicos para un área (centro + radio en km) entre dos zooms.
  static List<(int, int, int)> tilesFor(double lat, double lon, double radiusKm, int minZ, int maxZ) {
    final dLat = radiusKm / 111.32;
    final dLon = radiusKm / (111.32 * cos(lat * pi / 180));
    return tilesForBox(lat - dLat, lon - dLon, lat + dLat, lon + dLon, minZ, maxZ);
  }

  static List<(int, int, int)> tilesForBox(double s, double w, double n, double e, int minZ, int maxZ) {
    final out = <(int, int, int)>[];
    for (var z = minZ; z <= maxZ; z++) {
      final x1 = lonToX(w, z), x2 = lonToX(e, z);
      final y1 = latToY(n, z), y2 = latToY(s, z);
      for (var x = x1; x <= x2; x++) {
        for (var y = y1; y <= y2; y++) {
          out.add((z, x, y));
        }
      }
    }
    return out;
  }

  /// Tamaño total guardado (MB) y número de mosaicos.
  static Future<(double, int)> usage() async {
    final d = await dir();
    var bytes = 0, n = 0;
    await for (final f in d.list(recursive: true)) {
      if (f is File) {
        bytes += await f.length();
        n++;
      }
    }
    return (bytes / 1048576, n);
  }

  static Future<void> clear() async {
    final d = await dir();
    if (await d.exists()) await d.delete(recursive: true);
    _dir = null;
    await Store.setInt('tiles_maxz', 0);
  }
}

/// Proveedor de mosaicos para flutter_map: archivo local primero, red después.
class OfflineTileProvider extends TileProvider {
  OfflineTileProvider();
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) =>
      OfflineTileImage(coordinates.z, coordinates.x, coordinates.y);
}

class OfflineTileImage extends ImageProvider<OfflineTileImage> {
  final int z, x, y;
  const OfflineTileImage(this.z, this.x, this.y);

  @override
  Future<OfflineTileImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(OfflineTileImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(codec: _load(decode), scale: 1);

  Future<ui.Codec> _load(ImageDecoderCallback decode) async {
    final f = await TileStore.file(z, x, y);
    final Uint8List bytes = await f.exists() ? await f.readAsBytes() : await TileStore.fetch(z, x, y);
    return decode(await ui.ImmutableBuffer.fromUint8List(bytes));
  }

  @override
  bool operator ==(Object other) => other is OfflineTileImage && other.z == z && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(z, x, y);
}
