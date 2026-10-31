import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../core/i18n.dart';
import '../core/storage.dart';
import '../core/tile_store.dart';
import '../core/vector_map.dart';
import 'tools_screen.dart' show CompassPainter, cardinal;

/// Tipos de punto con icono y color.
const wpTypes = <String, (IconData, Color)>{
  'Agua': (Icons.water_drop, Colors.lightBlue),
  'Refugio': (Icons.cabin, Colors.brown),
  'Comida': (Icons.restaurant, Colors.green),
  'Base': (Icons.home, Colors.amber),
  'Peligro': (Icons.dangerous, Colors.red),
  'Otro': (Icons.place, Colors.purple),
};

/// Nombre visible del tipo de punto (se guarda en español).
String wpLabel(String t) => switch (t) {
      'Agua' => tr('Agua', 'Water', 'Água'),
      'Refugio' => tr('Refugio', 'Shelter', 'Abrigo'),
      'Comida' => tr('Comida', 'Food', 'Comida'),
      'Base' => tr('Base', 'Base', 'Base'),
      'Peligro' => tr('Peligro', 'Danger', 'Perigo'),
      'Otro' => tr('Otro', 'Other', 'Outro'),
      _ => t,
    };

/// Pide permisos y servicio. Devuelve un mensaje de error o null si todo bien.
Future<String?> ensureLocation() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    return tr('Activa la ubicación (GPS) del teléfono. Funciona aunque no haya señal ni internet.',
        'Turn on the phone\'s location (GPS). It works even without signal or internet.');
  }
  var p = await Geolocator.checkPermission();
  if (p == LocationPermission.denied) p = await Geolocator.requestPermission();
  if (p == LocationPermission.denied || p == LocationPermission.deniedForever) {
    return tr('Permiso de ubicación denegado. Actívalo en Ajustes > Apps > AURORA.', 'Location permission denied. Enable it in Settings > Apps > AURORA.');
  }
  return null;
}

String fmtDist(double m) => m < 1000 ? '${m.round()} m' : '${(m / 1000).toStringAsFixed(m < 10000 ? 2 : 1)} km';

String fmtArea(double m2) => m2 < 10000
    ? '${m2.round()} m²'
    : (m2 < 1e6 ? '${(m2 / 10000).toStringAsFixed(2)} ha' : '${(m2 / 1e6).toStringAsFixed(2)} km²');

String dms(double v, bool lat) {
  final h = lat ? (v >= 0 ? 'N' : 'S') : (v >= 0 ? (isPt ? 'L' : 'E') : (isEn ? 'W' : 'O'));
  final a = v.abs();
  final d = a.floor();
  final mF = (a - d) * 60;
  final m = mF.floor();
  final s = (mF - m) * 60;
  return '$d° $m\' ${s.toStringAsFixed(1)}" $h';
}

double _dist(LatLng a, LatLng b) => Geolocator.distanceBetween(a.latitude, a.longitude, b.latitude, b.longitude);

double pathLength(List<LatLng> p) {
  var d = 0.0;
  for (var i = 1; i < p.length; i++) {
    d += _dist(p[i - 1], p[i]);
  }
  return d;
}

/// Área de un polígono sobre la Tierra (m²).
double polygonArea(List<LatLng> p) {
  if (p.length < 3) return 0;
  const r = 6378137.0;
  double rad(double d) => d * math.pi / 180;
  var s = 0.0;
  for (var i = 0; i < p.length; i++) {
    final a = p[i], b = p[(i + 1) % p.length];
    s += (rad(b.longitude) - rad(a.longitude)) * (2 + math.sin(rad(a.latitude)) + math.sin(rad(b.latitude)));
  }
  return (s * r * r / 2).abs();
}

String _xml(String s) =>
    s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');

/// Archivo GPX (lo abren Google Earth, OsmAnd, Organic Maps, Garmin...).
String buildGpx(List<Map<String, dynamic>> wps, List<Map<String, dynamic>> track) {
  final b = StringBuffer()
    ..writeln('<?xml version="1.0" encoding="UTF-8"?>')
    ..writeln('<gpx version="1.1" creator="AURORA" xmlns="http://www.topografix.com/GPX/1/1">');
  for (final w in wps) {
    b.writeln('  <wpt lat="${w['lat']}" lon="${w['lon']}"><name>${_xml('${w['name']}')}</name><type>${_xml('${w['type']}')}</type></wpt>');
  }
  if (track.isNotEmpty) {
    b.writeln('  <trk><name>AURORA</name><trkseg>');
    for (final t in track) {
      final time = t['t'] is int ? '<time>${DateTime.fromMillisecondsSinceEpoch(t['t'] as int).toUtc().toIso8601String()}</time>' : '';
      b.writeln('    <trkpt lat="${t['lat']}" lon="${t['lon']}">$time</trkpt>');
    }
    b.writeln('  </trkseg></trk>');
  }
  b.writeln('</gpx>');
  return b.toString();
}

/// Guarda el GPX donde el usuario elija. Devuelve un mensaje.
Future<String> exportGpx() async {
  final gpx = buildGpx(Store.jsonList('waypoints'), TrackRecorder.track);
  final d = DateTime.now();
  final name = 'aurora_${d.year}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}_'
      '${d.hour.toString().padLeft(2, '0')}${d.minute.toString().padLeft(2, '0')}.gpx';
  try {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: tr('Guardar ruta GPX', 'Save GPX route', 'Salvar rota GPX'),
      fileName: name,
      bytes: utf8.encode(gpx),
    );
    if (path == null) return tr('Cancelado.', 'Cancelled.', 'Cancelado.');
    return tr('Guardado: $name', 'Saved: $name', 'Salvo: $name');
  } catch (e) {
    // Plan B: carpeta de la app (accesible por cable en Android/data/...).
    final dir = await OfflineMap.externalDir();
    if (dir == null) return '$e';
    await dir.create(recursive: true);
    final f = File('${dir.path}/$name');
    await f.writeAsString(gpx);
    return tr('Guardado en ${f.path}', 'Saved to ${f.path}', 'Salvo em ${f.path}');
  }
}

/// Grabación de ruta: sigue funcionando aunque cambies de pestaña.
class TrackRecorder {
  TrackRecorder._();
  static final ValueNotifier<int> changes = ValueNotifier(0);
  static StreamSubscription<Position>? _sub;
  static List<Map<String, dynamic>> track = Store.jsonList('track');
  static Position? last;
  static bool get recording => _sub != null;

  static Future<String?> toggle() async {
    if (_sub != null) {
      await _sub!.cancel();
      _sub = null;
      changes.value++;
      return null;
    }
    final err = await ensureLocation();
    if (err != null) return err;
    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 25),
    ).listen((p) {
      last = p;
      track.add({'lat': p.latitude, 'lon': p.longitude, 't': DateTime.now().millisecondsSinceEpoch});
      Store.setJsonList('track', track);
      changes.value++;
    });
    changes.value++;
    return null;
  }

  static Future<void> clear() async {
    track = [];
    await Store.setJsonList('track', track);
    changes.value++;
  }

  static List<LatLng> get points =>
      [for (final t in track) LatLng((t['lat'] as num).toDouble(), (t['lon'] as num).toDouble())];

  static double get length => pathLength(points);
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mc = MapController();
  Position? _pos;
  String? _msg;
  bool _loading = false;
  bool _follow = false;
  StreamSubscription<Position>? _followSub;
  final List<Map<String, dynamic>> _wps = Store.jsonList('waypoints');
  final _tiles = OfflineTileProvider();
  VectorTileProvider? _vtp;

  // Medir distancia y área
  bool _measure = false;
  final List<LatLng> _mpts = [];

  LatLng get _initialCenter {
    final lat = Store.getInt('map_lat_e6', 4710000) / 1e6;
    final lon = Store.getInt('map_lon_e6', -74070000) / 1e6;
    return LatLng(lat, lon);
  }

  @override
  void initState() {
    super.initState();
    TrackRecorder.changes.addListener(_onTrack);
    OfflineMap.changes.addListener(_onTrack);
    OfflineMap.load();
    Geolocator.getLastKnownPosition().then((p) {
      if (p != null && mounted) setState(() => _pos = p);
    }).catchError((_) {});
  }

  void _onTrack() {
    if (!mounted) return;
    setState(() => _pos = TrackRecorder.last ?? _pos);
  }

  @override
  void dispose() {
    TrackRecorder.changes.removeListener(_onTrack);
    OfflineMap.changes.removeListener(_onTrack);
    _followSub?.cancel(); // seguir posición solo mientras miras el mapa
    super.dispose();
  }

  void _saveCamera() {
    final c = _mc.camera.center;
    Store.setInt('map_lat_e6', (c.latitude * 1e6).round());
    Store.setInt('map_lon_e6', (c.longitude * 1e6).round());
    Store.setInt('map_zoom', _mc.camera.zoom.round());
  }

  Future<void> _locate() async {
    setState(() {
      _loading = true;
      _msg = null;
    });
    final err = await ensureLocation();
    if (err != null) {
      setState(() {
        _msg = err;
        _loading = false;
      });
      return;
    }
    try {
      final p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 60)),
      );
      _pos = p;
      _mc.move(LatLng(p.latitude, p.longitude), _mc.camera.zoom < 13 ? 15 : _mc.camera.zoom);
      _saveCamera();
    } catch (_) {
      final last = await Geolocator.getLastKnownPosition();
      _pos = last;
      _msg = last == null
          ? tr('Sin señal GPS. Sal a cielo abierto y espera un minuto.', 'No GPS signal. Go under open sky and wait a minute.')
          : tr('Sin señal nueva: mostrando la última posición conocida.', 'No new signal: showing the last known position.');
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _toggleFollow() async {
    if (_follow) {
      await _followSub?.cancel();
      setState(() => _follow = false);
      return;
    }
    final err = await ensureLocation();
    if (err != null) {
      setState(() => _msg = err);
      return;
    }
    _followSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10),
    ).listen((p) {
      if (!mounted) return;
      setState(() => _pos = p);
      _mc.move(LatLng(p.latitude, p.longitude), _mc.camera.zoom);
    });
    setState(() => _follow = true);
  }

  Future<void> _addWaypoint({LatLng? at}) async {
    final point = at ?? (_pos != null ? LatLng(_pos!.latitude, _pos!.longitude) : _mc.camera.center);
    final name = TextEditingController();
    final lat = TextEditingController(text: point.latitude.toStringAsFixed(6));
    final lon = TextEditingController(text: point.longitude.toStringAsFixed(6));
    String type = 'Agua';
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          backgroundColor: const Color(0xFF111111),
          title: Text(tr('Guardar punto', 'Save point')),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(controller: name, decoration: InputDecoration(labelText: tr('Nombre (opcional)', 'Name (optional)'))),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final t in wpTypes.keys)
                  ChoiceChip(
                    avatar: Icon(wpTypes[t]!.$1, size: 16, color: wpTypes[t]!.$2),
                    label: Text(wpLabel(t)),
                    selected: type == t,
                    onSelected: (_) => setD(() => type = t),
                  ),
              ]),
              const SizedBox(height: 8),
              TextField(
                  controller: lat,
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                  decoration: InputDecoration(labelText: tr('Latitud', 'Latitude'))),
              const SizedBox(height: 8),
              TextField(
                  controller: lon,
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                  decoration: InputDecoration(labelText: tr('Longitud', 'Longitude'))),
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
    final la = double.tryParse(lat.text.replaceAll(',', '.'));
    final lo = double.tryParse(lon.text.replaceAll(',', '.'));
    if (la == null || lo == null || la.abs() > 90 || lo.abs() > 180) {
      setState(() => _msg = tr('Coordenadas inválidas.', 'Invalid coordinates.'));
      return;
    }
    _wps.add({
      'name': name.text.trim().isEmpty ? wpLabel(type) : name.text.trim(),
      'type': type,
      'lat': la,
      'lon': lo,
      'date': DateTime.now().toIso8601String().substring(0, 10),
    });
    await Store.setJsonList('waypoints', _wps);
    setState(() {});
  }

  Future<void> _export() async {
    final m = await exportGpx();
    if (mounted) setState(() => _msg = m);
  }

  void _showPoints() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (ctx, sc) => StatefulBuilder(
          builder: (ctx, setS) => ListView(
            controller: sc,
            padding: const EdgeInsets.all(12),
            children: [
              Text(tr('Mis puntos (${_wps.length})', 'My points (${_wps.length})', 'Meus pontos (${_wps.length})'),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(tr('Toca uno para que la app te lleve hasta él.', 'Tap one and the app will guide you to it.'),
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 6),
              Wrap(spacing: 8, children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.ios_share),
                  label: Text(tr('Exportar GPX (puntos y ruta)', 'Export GPX (points and route)', 'Exportar GPX (pontos e rota)')),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _export();
                  },
                ),
                if (TrackRecorder.track.isNotEmpty && !TrackRecorder.recording)
                  TextButton.icon(
                    icon: const Icon(Icons.delete_sweep, color: Colors.red),
                    label: Text(tr('Borrar ruta (${fmtDist(TrackRecorder.length)})', 'Delete route (${fmtDist(TrackRecorder.length)})',
                        'Apagar rota (${fmtDist(TrackRecorder.length)})'), style: const TextStyle(color: Colors.red)),
                    onPressed: () async {
                      await TrackRecorder.clear();
                      setS(() {});
                    },
                  ),
              ]),
              if (_wps.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(tr('Aún no hay puntos. Usa el botón + del mapa o mantén presionado el mapa.', 'No points yet. Use the + button or long-press the map.')),
                ),
              for (final w in _wps)
                ListTile(
                  leading: Icon(wpTypes[w['type']]?.$1 ?? Icons.place, color: wpTypes[w['type']]?.$2),
                  title: Text('${w['name']}'),
                  subtitle: Text(_pos == null
                      ? '${(w['lat'] as num).toStringAsFixed(5)}, ${(w['lon'] as num).toStringAsFixed(5)}'
                      : '${fmtDist(Geolocator.distanceBetween(_pos!.latitude, _pos!.longitude, (w['lat'] as num).toDouble(), (w['lon'] as num).toDouble()))}'
                          ' · ${cardinal((Geolocator.bearingBetween(_pos!.latitude, _pos!.longitude, (w['lat'] as num).toDouble(), (w['lon'] as num).toDouble()) + 360) % 360)}'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      tooltip: tr('Ver en el mapa', 'Show on map'),
                      icon: const Icon(Icons.center_focus_strong),
                      onPressed: () {
                        Navigator.pop(ctx);
                        _mc.move(LatLng((w['lat'] as num).toDouble(), (w['lon'] as num).toDouble()), 16);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        _wps.remove(w);
                        await Store.setJsonList('waypoints', _wps);
                        setS(() {});
                        setState(() {});
                      },
                    ),
                  ]),
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => NavigateScreen(w)));
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fab(IconData icon, String tip, VoidCallback onTap, {Color? color, bool active = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Material(
          color: active ? Theme.of(context).colorScheme.primary : const Color(0xE6111111),
          shape: const CircleBorder(),
          child: IconButton(
            tooltip: tip,
            iconSize: 24,
            icon: Icon(icon, color: active ? Colors.black : (color ?? Colors.white)),
            onPressed: onTap,
          ),
        ),
      );

  Widget _baseLayer() {
    final vs = OfflineMap.source;
    if (vs != null && OfflineMap.preferFile) {
      if (_vtp?.source != vs) _vtp = VectorTileProvider(vs);
      return TileLayer(
        key: ValueKey(vs.pm.path),
        urlTemplate: 'pmtiles://{z}/{x}/{y}',
        tileProvider: _vtp!,
        minNativeZoom: vs.pm.isVector ? 0 : vs.pm.minZoom,
        maxNativeZoom: vs.pm.isVector ? 18 : vs.pm.maxZoom,
      );
    }
    final savedMax = TileStore.maxSavedZoom;
    return TileLayer(
      urlTemplate: '${TileStore.url}/{z}/{x}/{y}.png',
      tileProvider: _tiles,
      maxNativeZoom: TileStore.probablyOffline && savedMax > 0 ? savedMax : 17,
      userAgentPackageName: 'com.panlabstudios.apoca',
    );
  }

  Future<void> _openStorage() async {
    final go = await Navigator.push<LatLng>(context, MaterialPageRoute(builder: (_) => const MapStorageScreen()));
    if (!mounted) return;
    setState(() {});
    if (go != null) _mc.move(go, 11);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final p = _pos;
    final track = TrackRecorder.points;
    final usingFile = OfflineMap.source != null && OfflineMap.preferFile;
    final hasAnyMap = usingFile || TileStore.maxSavedZoom > 0;
    return Stack(children: [
      FlutterMap(
        mapController: _mc,
        options: MapOptions(
          initialCenter: _initialCenter,
          initialZoom: Store.getInt('map_zoom', 12).toDouble(),
          minZoom: 3,
          maxZoom: 19,
          backgroundColor: const Color(0xFF0D0D0D),
          interactionOptions: const InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
          onTap: (_, latLng) {
            if (_measure) setState(() => _mpts.add(latLng));
          },
          onLongPress: (_, latLng) {
            if (!_measure) _addWaypoint(at: latLng);
          },
          onMapEvent: (e) {
            if (e is MapEventMoveEnd) _saveCamera();
          },
        ),
        children: [
          _baseLayer(),
          if (track.length > 1)
            PolylineLayer(polylines: [
              Polyline(points: track, strokeWidth: 4, color: cs.primary),
            ]),
          if (_measure && _mpts.length > 2)
            PolygonLayer(polygons: [
              Polygon(points: _mpts, color: Colors.cyan.withValues(alpha: 0.15), borderColor: Colors.transparent, borderStrokeWidth: 0),
            ]),
          if (_measure && _mpts.length > 1)
            PolylineLayer(polylines: [
              Polyline(points: _mpts, strokeWidth: 3, color: Colors.cyanAccent),
            ]),
          MarkerLayer(markers: [
            for (final w in _wps)
              Marker(
                point: LatLng((w['lat'] as num).toDouble(), (w['lon'] as num).toDouble()),
                width: 40,
                height: 40,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NavigateScreen(w))),
                  child: Icon(wpTypes[w['type']]?.$1 ?? Icons.place,
                      color: wpTypes[w['type']]?.$2 ?? Colors.purple, size: 34, shadows: const [Shadow(blurRadius: 4, color: Colors.black)]),
                ),
              ),
            if (_measure)
              for (final m in _mpts)
                Marker(
                  point: m,
                  width: 14,
                  height: 14,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.cyanAccent, shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2)),
                  ),
                ),
            if (p != null)
              Marker(
                point: LatLng(p.latitude, p.longitude),
                width: 26,
                height: 26,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
          ]),
        ],
      ),

      // ---------- Panel superior ----------
      Positioned(
        left: 8,
        right: 8,
        top: 8,
        child: Card(
          color: const Color(0xEE0D0D0D),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (p == null)
                Text(tr('Toca ◎ para ver dónde estás (el GPS funciona sin internet)', 'Tap ◎ to see where you are (GPS works without internet)'))
              else ...[
                SelectableText('${p.latitude.toStringAsFixed(5)}, ${p.longitude.toStringAsFixed(5)}',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Text('${dms(p.latitude, true)}  ${dms(p.longitude, false)} · alt ${p.altitude.round()} m · ±${p.accuracy.round()} m',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
              if (TrackRecorder.recording)
                Text(tr('● Grabando ruta: ${fmtDist(TrackRecorder.length)}', '● Recording route: ${fmtDist(TrackRecorder.length)}',
                    '● Gravando rota: ${fmtDist(TrackRecorder.length)}'), style: const TextStyle(color: Colors.red))
              else if (track.length > 1)
                Row(children: [
                  Expanded(
                    child: Text(tr('Ruta grabada: ${fmtDist(TrackRecorder.length)}', 'Recorded route: ${fmtDist(TrackRecorder.length)}',
                        'Rota gravada: ${fmtDist(TrackRecorder.length)}'), style: TextStyle(color: cs.primary)),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                    icon: const Icon(Icons.ios_share, size: 18),
                    label: const Text('GPX'),
                    onPressed: _export,
                  ),
                ]),
              if (_msg != null) Text(_msg!, style: const TextStyle(color: Colors.orange)),
              if (OfflineMap.error != null)
                Text(tr('Mapa sin internet: ${OfflineMap.error}', 'Offline map: ${OfflineMap.error}', 'Mapa sem internet: ${OfflineMap.error}'),
                    style: const TextStyle(color: Colors.orange, fontSize: 12)),
              if (!hasAnyMap)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.download_for_offline),
                    label: Text(tr('Tener el mapa SIN internet', 'Get the map WITHOUT internet', 'Ter o mapa SEM internet')),
                    onPressed: _openStorage,
                  ),
                ),
            ]),
          ),
        ),
      ),

      // ---------- Medición ----------
      if (_measure)
        Positioned(
          left: 8,
          right: 70,
          bottom: 8,
          child: Card(
            color: const Color(0xEE0D0D0D),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(tr('Medir: toca el mapa para poner puntos', 'Measure: tap the map to add points', 'Medir: toque o mapa para pôr pontos'),
                    style: const TextStyle(color: Colors.cyanAccent)),
                Text(tr('Distancia: ${fmtDist(pathLength(_mpts))}', 'Distance: ${fmtDist(pathLength(_mpts))}', 'Distância: ${fmtDist(pathLength(_mpts))}'),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                if (_mpts.length > 2) ...[
                  Text(tr('Área: ${fmtArea(polygonArea(_mpts))}', 'Area: ${fmtArea(polygonArea(_mpts))}', 'Área: ${fmtArea(polygonArea(_mpts))}'),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                      tr('Perímetro (cerrado): ${fmtDist(pathLength([..._mpts, _mpts.first]))}', 'Perimeter (closed): ${fmtDist(pathLength([..._mpts, _mpts.first]))}',
                          'Perímetro (fechado): ${fmtDist(pathLength([..._mpts, _mpts.first]))}'),
                      style: const TextStyle(color: Colors.grey)),
                ],
                Row(children: [
                  TextButton.icon(
                    icon: const Icon(Icons.undo),
                    label: Text(tr('Deshacer', 'Undo', 'Desfazer')),
                    onPressed: _mpts.isEmpty ? null : () => setState(() => _mpts.removeLast()),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.clear_all),
                    label: Text(tr('Limpiar', 'Clear', 'Limpar')),
                    onPressed: _mpts.isEmpty ? null : () => setState(_mpts.clear),
                  ),
                ]),
              ]),
            ),
          ),
        ),

      // ---------- Botones laterales ----------
      Positioned(
        right: 10,
        top: 130,
        bottom: 30,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _fab(Icons.download_for_offline, tr('Mapa sin internet', 'Offline map'), _openStorage, color: usingFile ? Colors.greenAccent : null),
              _fab(Icons.straighten, tr('Medir distancia y área', 'Measure distance and area', 'Medir distância e área'),
                  () => setState(() => _measure = !_measure),
                  active: _measure),
              _fab(Icons.add_location_alt, tr('Guardar punto', 'Save point'), () => _addWaypoint()),
              _fab(Icons.list, tr('Mis puntos', 'My points'), _showPoints),
              _fab(TrackRecorder.recording ? Icons.stop : Icons.fiber_manual_record, tr('Grabar ruta', 'Record route'), () async {
                final e = await TrackRecorder.toggle();
                setState(() => _msg = e);
              }, color: Colors.red, active: TrackRecorder.recording),
              _fab(Icons.navigation, tr('Seguirme', 'Follow me'), _toggleFollow, active: _follow),
              _loading
                  ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator())
                  : _fab(Icons.my_location, tr('Ubicarme', 'Locate me'), _locate, color: Colors.lightBlue),
            ]),
          ),
        ),
      ),

      // ---------- Atribución (obligatoria) ----------
      if (!_measure)
        Positioned(
          left: 8,
          bottom: 6,
          child: Text(usingFile ? '© OpenStreetMap · Protomaps' : '© OpenStreetMap',
              style: const TextStyle(fontSize: 10, color: Colors.white70)),
        ),
    ]);
  }
}

// =====================================================================
// MAPAS SIN INTERNET: archivo .pmtiles (de verdad) + lo visto con internet
// =====================================================================
class MapStorageScreen extends StatefulWidget {
  const MapStorageScreen({super.key});
  @override
  State<MapStorageScreen> createState() => _MapStorageScreenState();
}

class _MapStorageScreenState extends State<MapStorageScreen> {
  (double, int)? _usage;
  List<File> _files = [];
  String? _extPath;
  String? _msg;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    OfflineMap.changes.addListener(_refresh);
    _refresh();
  }

  @override
  void dispose() {
    OfflineMap.changes.removeListener(_refresh);
    super.dispose();
  }

  Future<void> _refresh() async {
    final u = await TileStore.usage();
    final f = await OfflineMap.files();
    final e = await OfflineMap.externalDir();
    if (mounted) {
      setState(() {
        _usage = u;
        _files = f;
        _extPath = e?.path;
      });
    }
  }

  Future<void> _import() async {
    setState(() {
      _busy = true;
      _msg = null;
    });
    try {
      final e = await OfflineMap.import();
      _msg = e;
    } catch (e) {
      _msg = '$e';
    }
    if (mounted) setState(() => _busy = false);
    _refresh();
  }

  Future<void> _scan() async {
    setState(() => _busy = true);
    await OfflineMap.load(force: true);
    if (mounted) {
      setState(() {
        _busy = false;
        _msg = OfflineMap.source == null
            ? (OfflineMap.error ?? tr('No se encontró ningún mapa.', 'No map found.', 'Nenhum mapa encontrado.'))
            : tr('Mapa cargado.', 'Map loaded.', 'Mapa carregado.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final src = OfflineMap.source;
    final pm = src?.pm;
    return Scaffold(
      appBar: AppBar(title: Text(tr('Mapas sin internet', 'Offline maps'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ------- Archivo de mapa -------
          Text(tr('Mapa completo en el teléfono', 'Full map on the phone', 'Mapa completo no telefone'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: cs.primary)),
          const SizedBox(height: 4),
          Text(tr(
              'Un archivo .pmtiles con calles, ríos, pueblos y ciudades de todo tu país o región. Funciona 100 % sin señal.',
              'A .pmtiles file with streets, rivers, towns and cities of your whole country or region. Works 100 % without signal.',
              'Um arquivo .pmtiles com ruas, rios, vilas e cidades de todo o seu país ou região. Funciona 100 % sem sinal.')),
          const SizedBox(height: 8),
          if (pm != null)
            Card(
              color: Colors.green.withValues(alpha: 0.12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('✔ ${pm.path.split('/').last}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(tr('Zoom ${pm.minZoom}–${pm.maxZoom} · ${pm.isVector ? 'vectorial' : 'imágenes'}',
                      'Zoom ${pm.minZoom}–${pm.maxZoom} · ${pm.isVector ? 'vector' : 'images'}',
                      'Zoom ${pm.minZoom}–${pm.maxZoom} · ${pm.isVector ? 'vetorial' : 'imagens'}')),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(tr('Usar este mapa', 'Use this map', 'Usar este mapa')),
                    subtitle: Text(tr('Apágalo para ver el mapa de internet', 'Turn it off to see the online map', 'Desligue para ver o mapa da internet')),
                    value: OfflineMap.preferFile,
                    onChanged: (v) async {
                      await OfflineMap.setPreferFile(v);
                      setState(() {});
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.center_focus_strong),
                      label: Text(tr('Ir a la zona del mapa', 'Go to the map area', 'Ir para a área do mapa')),
                      onPressed: () => Navigator.pop(
                          context,
                          LatLng(pm.centerLat != 0 || pm.centerLon != 0 ? pm.centerLat : (pm.minLat + pm.maxLat) / 2,
                              pm.centerLat != 0 || pm.centerLon != 0 ? pm.centerLon : (pm.minLon + pm.maxLon) / 2)),
                    ),
                  ),
                ]),
              ),
            ),
          if (OfflineMap.error != null) Text(OfflineMap.error!, style: const TextStyle(color: Colors.orange)),
          if (_msg != null) Text(_msg!, style: const TextStyle(color: Colors.orange)),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _busy ? null : _import,
                icon: _busy
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.file_open),
                label: Text(tr('Importar .pmtiles', 'Import .pmtiles', 'Importar .pmtiles')),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: _busy ? null : _scan, child: Text(tr('Buscar', 'Scan', 'Procurar'))),
          ]),
          for (final f in _files)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(f.path == pm?.path ? Icons.radio_button_checked : Icons.radio_button_off, color: cs.primary),
              title: Text(f.path.split('/').last),
              subtitle: Text('${(f.lengthSync() / 1048576).toStringAsFixed(0)} MB'),
              onTap: () => OfflineMap.choose(f.path),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF111111),
                      title: Text(tr('¿Borrar este mapa?', 'Delete this map?', 'Apagar este mapa?')),
                      content: Text(f.path.split('/').last),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(tr('Cancelar', 'Cancel'))),
                        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(tr('Eliminar', 'Delete'))),
                      ],
                    ),
                  );
                  if (ok == true) await OfflineMap.delete(f);
                },
              ),
            ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(tr('Cómo conseguirlo (una vez, con un PC)', 'How to get it (once, with a PC)', 'Como conseguir (uma vez, com um PC)'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                for (final (n, t) in [
                  ('1', tr('En el teléfono: activa "Depuración USB" (Ajustes > Opciones de desarrollador) y conéctalo al PC por cable.',
                      'On the phone: turn on "USB debugging" (Settings > Developer options) and plug it into the PC.',
                      'No telefone: ative "Depuração USB" (Configurações > Opções do desenvolvedor) e conecte ao PC pelo cabo.')),
                  ('2', tr('En el PC, dentro de la carpeta del proyecto, ejecuta:\npowershell -ExecutionPolicy Bypass -File .\\tool\\mapa_offline.ps1',
                      'On the PC, inside the project folder, run:\npowershell -ExecutionPolicy Bypass -File .\\tool\\mapa_offline.ps1',
                      'No PC, dentro da pasta do projeto, execute:\npowershell -ExecutionPolicy Bypass -File .\\tool\\mapa_offline.ps1')),
                  ('3', tr('El script baja el mapa de Colombia (u otra zona) y lo pasa al teléfono. Luego toca "Buscar".',
                      'The script downloads the map of Colombia (or another area) and copies it to the phone. Then tap "Scan".',
                      'O script baixa o mapa da Colômbia (ou outra área) e copia para o telefone. Depois toque "Procurar".')),
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      CircleAvatar(radius: 11, backgroundColor: cs.primary, child: Text(n, style: const TextStyle(fontSize: 12, color: Colors.black))),
                      const SizedBox(width: 8),
                      Expanded(child: SelectableText(t)),
                    ]),
                  ),
                const SizedBox(height: 6),
                Text(
                    tr('Sin script: copia el archivo .pmtiles al teléfono (Descargas) y toca "Importar".',
                        'Without the script: copy the .pmtiles file to the phone (Downloads) and tap "Import".',
                        'Sem script: copie o arquivo .pmtiles para o telefone (Downloads) e toque "Importar".'),
                    style: const TextStyle(color: Colors.grey)),
                if (_extPath != null)
                  SelectableText(tr('Carpeta del mapa por cable: $_extPath', 'Map folder for USB copy: $_extPath', 'Pasta do mapa pelo cabo: $_extPath'),
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
            ),
          ),
          const Divider(height: 32),

          // ------- Lo visto con internet -------
          Text(tr('Lo que viste con internet', 'What you viewed online', 'O que você viu com internet'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)),
          const SizedBox(height: 6),
          Text(tr(
              'Si no usas el archivo, el mapa de internet guarda automáticamente lo que recorres para verlo después sin señal.',
              'If you don\'t use the file, the online map automatically saves what you browse so you can see it later without signal.',
              'Se não usar o arquivo, o mapa da internet salva automaticamente o que você percorre para ver depois sem sinal.')),
          const SizedBox(height: 8),
          Text(_usage == null
              ? tr('Calculando...', 'Calculating...')
              : tr('Guardado: ${_usage!.$1.toStringAsFixed(1)} MB (${_usage!.$2} partes del mapa)',
                  'Saved: ${_usage!.$1.toStringAsFixed(1)} MB (${_usage!.$2} map tiles)', 'Salvo: ${_usage!.$1.toStringAsFixed(1)} MB (${_usage!.$2} partes do mapa)')),
          TextButton.icon(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            label: Text(tr('Borrar el mapa guardado', 'Delete saved map'), style: const TextStyle(color: Colors.red)),
            onPressed: () async {
              await TileStore.clear();
              _refresh();
            },
          ),
          const SizedBox(height: 8),
          Text(
              tr('Mapas © colaboradores de OpenStreetMap (ODbL). Archivo de mapa: Protomaps.',
                  'Maps © OpenStreetMap contributors (ODbL). Map file: Protomaps.', 'Mapas © colaboradores do OpenStreetMap (ODbL). Arquivo de mapa: Protomaps.'),
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

/// Navegar hacia un punto: brújula + GPS en vivo (solo mientras está abierta).
class NavigateScreen extends StatefulWidget {
  final Map<String, dynamic> wp;
  const NavigateScreen(this.wp, {super.key});
  @override
  State<NavigateScreen> createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  Position? _pos;
  double? _heading;
  String? _msg;
  StreamSubscription<Position>? _gps;
  StreamSubscription<CompassEvent>? _cmp;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    _cmp = FlutterCompass.events?.listen((e) {
      if (e.heading != null && mounted) setState(() => _heading = (e.heading! + 360) % 360);
    });
    final err = await ensureLocation();
    if (err != null) {
      if (mounted) setState(() => _msg = err);
      return;
    }
    _gps = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 5),
    ).listen((p) {
      if (mounted) setState(() => _pos = p);
    });
  }

  @override
  void dispose() {
    _gps?.cancel();
    _cmp?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.wp;
    final wl = (w['lat'] as num).toDouble(), wo = (w['lon'] as num).toDouble();
    final p = _pos;
    double? bearing;
    double? dist;
    if (p != null) {
      bearing = (Geolocator.bearingBetween(p.latitude, p.longitude, wl, wo) + 360) % 360;
      dist = Geolocator.distanceBetween(p.latitude, p.longitude, wl, wo);
    }
    return Scaffold(
      appBar: AppBar(title: Text(tr('Ir a: ${w['name']}', 'Go to: ${w['name']}', 'Ir para: ${w['name']}'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(dist == null ? tr('Buscando GPS...', 'Searching GPS...') : fmtDist(dist),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ),
          if (bearing != null)
            Center(
                child: Text(tr('Rumbo ${bearing.round()}° ${cardinal(bearing)}', 'Heading ${bearing.round()}° ${cardinal(bearing)}',
                    'Rumo ${bearing.round()}° ${cardinal(bearing)}'), style: const TextStyle(fontSize: 20))),
          if (p != null)
            Center(
                child: Text(tr('Precisión ±${p.accuracy.round()} m', 'Accuracy ±${p.accuracy.round()} m', 'Precisão ±${p.accuracy.round()} m'),
                    style: const TextStyle(color: Colors.grey))),
          if (_msg != null) Text(_msg!, style: const TextStyle(color: Colors.orange)),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              painter: CompassPainter(_heading ?? 0, Theme.of(context).colorScheme.primary, target: bearing),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _heading == null
                ? tr('Sin brújula: camina y observa cómo cambia la distancia.', 'No compass: walk and watch how the distance changes.')
                : tr('Gira hasta que la flecha de color quede bajo la marca de arriba y camina.', 'Turn until the colored arrow is under the top mark, then walk.'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
