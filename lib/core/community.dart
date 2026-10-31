import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'i18n.dart';
import 'storage.dart';

/// Modo comunidad: varios teléfonos cerca comparten provisiones y la lista de personas
/// SIN INTERNET. Un teléfono crea una zona Wi-Fi (hotspot) y los demás se conectan;
/// la app se encuentra sola en esa red (UDP) y se intercambia los datos (HTTP local).
/// Solo funciona mientras la pantalla de Modo comunidad está abierta (ahorra batería).
class Community {
  Community._();
  static const port = 47123;
  static const discoPort = 47124;
  static const _tag = 'AURORA1';

  static HttpServer? _server;
  static RawDatagramSocket? _udp;
  static Timer? _beacon;
  static final ValueNotifier<int> changes = ValueNotifier(0);

  /// Teléfonos vistos: id -> (ip, nombre, visto a las ms)
  static final Map<String, (String, String, int)> peers = {};
  static final List<String> log = [];

  static bool get running => _server != null;

  static String get deviceId {
    var id = Store.getString('dev_id');
    if (id == null) {
      final r = Random();
      id = List.generate(8, (_) => r.nextInt(16).toRadixString(16)).join();
      Store.setString('dev_id', id);
    }
    return id;
  }

  static String get myName => Store.getString('group_name') ?? '';
  static Future<void> setMyName(String v) => Store.setString('group_name', v.trim());
  static String get pin => Store.getString('group_pin') ?? '';
  static Future<void> setPin(String v) => Store.setString('group_pin', v.trim());

  static String get _displayName => myName.isEmpty ? tr('Teléfono $deviceId', 'Phone $deviceId', 'Telefone $deviceId') : myName;

  static Map<String, dynamic> snapshot() => {
        'app': 'aurora',
        'v': 1,
        'id': deviceId,
        'name': _displayName,
        'time': DateTime.now().millisecondsSinceEpoch,
        'inventory': Store.jsonList('inventory'),
        'people': Store.jsonList('people'),
      };

  /// Datos recibidos de otros teléfonos: id -> snapshot.
  static Map<String, Map<String, dynamic>> get received {
    final raw = Store.getString('peer_data');
    if (raw == null || raw.isEmpty) return {};
    try {
      return (jsonDecode(raw) as Map).map((k, v) => MapEntry('$k', Map<String, dynamic>.from(v as Map)));
    } catch (_) {
      return {};
    }
  }

  static Future<void> forget(String id) async {
    final r = received..remove(id);
    peers.remove(id);
    await Store.setString('peer_data', jsonEncode(r));
    changes.value++;
  }

  static void _note(String s) {
    final t = DateTime.now();
    log.insert(0, '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}  $s');
    if (log.length > 30) log.removeLast();
    changes.value++;
  }

  static Future<void> _accept(Map<String, dynamic> d, String? ip) async {
    if (d['app'] != 'aurora') return;
    final id = '${d['id']}';
    if (id == deviceId || id.isEmpty) return;
    final r = received;
    r[id] = {
      'name': '${d['name']}',
      'time': d['time'],
      'got': DateTime.now().millisecondsSinceEpoch,
      'ip': ip,
      'inventory': d['inventory'] is List ? d['inventory'] : [],
      'people': d['people'] is List ? d['people'] : [],
    };
    if (ip != null) peers[id] = (ip, '${d['name']}', DateTime.now().millisecondsSinceEpoch);
    await Store.setString('peer_data', jsonEncode(r));
    changes.value++;
  }

  /// Mis direcciones IPv4 en la red local.
  static Future<List<String>> myIps() async {
    try {
      final list = await NetworkInterface.list(type: InternetAddressType.IPv4, includeLoopback: false);
      return [for (final i in list) for (final a in i.addresses) a.address];
    } catch (_) {
      return [];
    }
  }

  static Future<String?> start() async {
    if (running) return null;
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, port, shared: true);
      _server!.listen(_handle, onError: (_) {});
    } catch (e) {
      _server = null;
      return tr('No se pudo abrir el puerto $port: $e', 'Could not open port $port: $e', 'Não foi possível abrir a porta $port: $e');
    }
    try {
      final u = await RawDatagramSocket.bind(InternetAddress.anyIPv4, discoPort, reuseAddress: true);
      u.broadcastEnabled = true;
      u.listen((ev) {
        if (ev != RawSocketEvent.read) return;
        final dg = u.receive();
        if (dg == null) return;
        final parts = utf8.decode(dg.data, allowMalformed: true).split('|');
        if (parts.length < 3 || parts[0] != _tag || parts[1] == deviceId) return;
        final isNew = !peers.containsKey(parts[1]);
        peers[parts[1]] = (dg.address.address, parts[2], DateTime.now().millisecondsSinceEpoch);
        if (isNew) {
          _note(tr('Encontrado: ${parts[2]}', 'Found: ${parts[2]}', 'Encontrado: ${parts[2]}'));
          syncWith(dg.address.address);
        }
        changes.value++;
      });
      _udp = u;
      _beacon = Timer.periodic(const Duration(seconds: 5), (_) => _announce());
      _announce();
    } catch (_) {
      // Sin UDP: se puede escribir la IP del otro teléfono a mano.
    }
    changes.value++;
    return null;
  }

  static Future<void> stop() async {
    _beacon?.cancel();
    _beacon = null;
    _udp?.close();
    _udp = null;
    await _server?.close(force: true);
    _server = null;
    changes.value++;
  }

  static Future<void> _announce() async {
    final u = _udp;
    if (u == null) return;
    final msg = utf8.encode('$_tag|$deviceId|${_displayName.replaceAll('|', ' ')}');
    final targets = <String>{'255.255.255.255'};
    for (final ip in await myIps()) {
      final p = ip.split('.');
      if (p.length == 4) targets.add('${p[0]}.${p[1]}.${p[2]}.255');
    }
    for (final t in targets) {
      try {
        u.send(msg, InternetAddress(t), discoPort);
      } catch (_) {}
    }
  }

  static Future<void> _handle(HttpRequest req) async {
    try {
      if (req.uri.path != '/aurora') {
        req.response.statusCode = HttpStatus.notFound;
      } else if ((req.headers.value('x-aurora-pin') ?? '') != pin) {
        req.response.statusCode = HttpStatus.forbidden;
      } else if (req.method == 'POST') {
        if (req.contentLength > 8 * 1024 * 1024) {
          req.response.statusCode = HttpStatus.requestEntityTooLarge;
        } else {
          final body = await utf8.decoder.bind(req).join();
          await _accept(Map<String, dynamic>.from(jsonDecode(body) as Map), req.connectionInfo?.remoteAddress.address);
          _note(tr('Recibido de ${req.connectionInfo?.remoteAddress.address}', 'Received from ${req.connectionInfo?.remoteAddress.address}',
              'Recebido de ${req.connectionInfo?.remoteAddress.address}'));
          req.response.write('ok');
        }
      } else {
        req.response.headers.contentType = ContentType.json;
        req.response.write(jsonEncode(snapshot()));
      }
    } catch (_) {
      req.response.statusCode = HttpStatus.badRequest;
    }
    try {
      await req.response.close();
    } catch (_) {}
  }

  /// Intercambia datos con un teléfono: recibe los suyos y le envía los míos.
  static Future<String?> syncWith(String ip) async {
    final c = HttpClient()..connectionTimeout = const Duration(seconds: 4);
    try {
      final uri = Uri.parse('http://$ip:$port/aurora');
      final g = await c.getUrl(uri);
      g.headers.set('x-aurora-pin', pin);
      final gr = await g.close().timeout(const Duration(seconds: 10));
      if (gr.statusCode == HttpStatus.forbidden) {
        await gr.drain<void>();
        return tr('$ip usa otro PIN de grupo', '$ip uses a different group PIN', '$ip usa outro PIN de grupo');
      }
      if (gr.statusCode != 200) {
        await gr.drain<void>();
        return 'HTTP ${gr.statusCode}';
      }
      final body = await utf8.decoder.bind(gr).join();
      await _accept(Map<String, dynamic>.from(jsonDecode(body) as Map), ip);
      final p = await c.postUrl(uri);
      p.headers.set('x-aurora-pin', pin);
      p.headers.contentType = ContentType.json;
      p.write(jsonEncode(snapshot()));
      final pr = await p.close().timeout(const Duration(seconds: 10));
      await pr.drain<void>();
      _note(tr('Sincronizado con $ip', 'Synced with $ip', 'Sincronizado com $ip'));
      return null;
    } catch (_) {
      return tr('Sin conexión con $ip', 'No connection to $ip', 'Sem conexão com $ip');
    } finally {
      c.close(force: true);
    }
  }

  /// Sincroniza con todos los vistos y prueba la "puerta" de la red (el teléfono con el hotspot).
  static Future<int> syncAll() async {
    final mine = await myIps();
    final targets = <String>{for (final p in peers.values) p.$1};
    for (final ip in mine) {
      final p = ip.split('.');
      if (p.length == 4 && p[3] != '1') targets.add('${p[0]}.${p[1]}.${p[2]}.1');
    }
    targets.removeAll(mine);
    var ok = 0;
    for (final t in targets) {
      if (await syncWith(t) == null) ok++;
    }
    return ok;
  }
}
