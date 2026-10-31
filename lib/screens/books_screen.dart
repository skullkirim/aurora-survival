import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/i18n.dart';

import '../core/storage.dart';
import '../data/books.dart';

Future<Directory> _booksDir() async {
  final d = Directory('${(await getApplicationDocumentsDirectory()).path}/libros');
  if (!await d.exists()) await d.create(recursive: true);
  return d;
}

/// Pestaña "Libros": descargar una vez, leer siempre sin internet.
class BooksTab extends StatefulWidget {
  const BooksTab({super.key});
  @override
  State<BooksTab> createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  Directory? _dir;
  final Map<String, double> _progress = {}; // id -> 0..1 (descargando)
  final Map<String, String> _errors = {};

  @override
  void initState() {
    super.initState();
    _booksDir().then((d) => setState(() => _dir = d));
  }

  File? _file(String id) {
    if (_dir == null) return null;
    final f = File('${_dir!.path}/$id.pdf');
    return f.existsSync() ? f : null;
  }

  List<File> get _imported {
    if (_dir == null) return [];
    final known = {for (final b in books) for (final p in b.parts) '${p.id}.pdf'};
    return _dir!
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.pdf') && !known.contains(f.uri.pathSegments.last))
        .toList();
  }

  Future<void> _download(BookPart p) async {
    setState(() {
      _progress[p.id] = 0;
      _errors.remove(p.id);
    });
    final client = http.Client();
    String? lastError;
    for (final url in p.urls) {
      try {
        final req = http.Request('GET', Uri.parse(url))
          ..headers['User-Agent'] = 'Mozilla/5.0 (Android) AURORA/1.0';
        final res = await client.send(req).timeout(const Duration(seconds: 30));
        if (res.statusCode != 200) {
          lastError = tr('Error ${res.statusCode}', 'Error ${res.statusCode}', 'Erro ${res.statusCode}');
          continue;
        }
        final total = res.contentLength ?? 0;
        final tmp = File('${_dir!.path}/${p.id}.part');
        final sink = tmp.openWrite();
        var got = 0;
        var head = <int>[];
        await for (final chunk in res.stream) {
          if (head.length < 5) head = [...head, ...chunk.take(5 - head.length)];
          sink.add(chunk);
          got += chunk.length;
          if (total > 0 && mounted) setState(() => _progress[p.id] = got / total);
        }
        await sink.close();
        // Verifica que de verdad sea un PDF (%PDF)
        if (String.fromCharCodes(head).startsWith('%PDF')) {
          await tmp.rename('${_dir!.path}/${p.id}.pdf');
          lastError = null;
          break;
        } else {
          await tmp.delete();
          lastError = tr('El archivo descargado no es un PDF', 'The downloaded file is not a PDF');
        }
      } catch (e) {
        lastError = tr('Sin conexión o el enlace cambió', 'No connection or the link changed');
      }
    }
    client.close();
    if (!mounted) return;
    setState(() {
      _progress.remove(p.id);
      if (lastError != null) _errors[p.id] = lastError;
    });
  }

  Future<void> _import() async {
    try {
      final r = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      final path = r?.files.single.path;
      if (path == null) return;
      final name = r!.files.single.name.replaceAll(RegExp(r'[^\w\-. áéíóúñÁÉÍÓÚÑ]'), '_');
      await File(path).copy('${_dir!.path}/$name');
      setState(() {});
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(tr('No se pudo importar el archivo', 'Could not import the file'))));
      }
    }
  }

  void _open(File f, String title, String key) => Navigator.push(
      context, MaterialPageRoute(builder: (_) => PdfReaderScreen(file: f, title: title, keyId: key)));

  Future<void> _delete(File f) async {
    await f.delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_dir == null) return const Center(child: CircularProgressIndicator());
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          color: cs.primary.withValues(alpha: 0.08),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              tr('📥 Descarga los libros AHORA, mientras tengas internet. Después se leen sin conexión, ', '📥 Download the books NOW, while you have internet. Then you can read them offline, ') +
              tr('aunque no haya señal nunca más.', 'even if there is never signal again.'),
            ),
          ),
        ),
        for (final b in books)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.menu_book, color: cs.primary, size: 30),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(b.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${b.author} · ${bookLang(b)}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ]),
                  ),
                ]),
                const SizedBox(height: 6),
                Text(bookAbout(b)),
                const SizedBox(height: 4),
                Text(bookLicense(b), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const Divider(),
                for (final p in b.parts) _partRow(b, p),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: Text(tr('Página oficial', 'Official page')),
                    onPressed: () => launchUrl(Uri.parse(b.page), mode: LaunchMode.externalApplication),
                  ),
                ),
              ]),
            ),
          ),
        const SizedBox(height: 8),
        Text(tr('Mis PDF', 'My PDFs'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(tr('Agrega cualquier libro o manual en PDF que tengas en el teléfono.', 'Add any PDF book or manual you have on your phone.'),
            style: TextStyle(color: Colors.grey)),
        for (final f in _imported)
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text(f.uri.pathSegments.last.replaceAll('.pdf', '')),
            onTap: () => _open(f, f.uri.pathSegments.last, f.uri.pathSegments.last),
            trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => _delete(f)),
          ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.add),
          label: Text(tr('Agregar PDF del teléfono', 'Add PDF from phone')),
          onPressed: _import,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _partRow(Book b, BookPart p) {
    final f = _file(p.id);
    final prog = _progress[p.id];
    final err = _errors[p.id];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(f != null ? Icons.check_circle : Icons.cloud_download_outlined,
          color: f != null ? Colors.green : null),
      title: Text(p.title),
      subtitle: prog != null
          ? LinearProgressIndicator(value: prog == 0 ? null : prog)
          : Text(err ?? (f != null ? tr('Disponible sin internet', 'Available offline') : p.size),
              style: TextStyle(color: err != null ? Colors.orange : null)),
      trailing: f != null
          ? Row(mainAxisSize: MainAxisSize.min, children: [
              FilledButton(onPressed: () => _open(f, p.title, p.id), child: Text(tr('Leer', 'Read'))),
              IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => _delete(f)),
            ])
          : prog != null
              ? null
              : OutlinedButton(onPressed: () => _download(p), child: Text(tr('Descargar', 'Download'))),
    );
  }
}

/// Lector PDF sin conexión. Recuerda la última página leída.
class PdfReaderScreen extends StatefulWidget {
  final File file;
  final String title;
  final String keyId;
  const PdfReaderScreen({super.key, required this.file, required this.title, required this.keyId});
  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  late final PdfControllerPinch _ctrl;
  int _page = 1;
  int _pages = 0;

  @override
  void initState() {
    super.initState();
    _page = Store.getInt('book_page_${widget.keyId}', 1);
    _ctrl = PdfControllerPinch(
      document: PdfDocument.openFile(widget.file.path),
      initialPage: _page,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 15)),
        actions: [
          Center(child: Text(_pages == 0 ? '' : '$_page / $_pages  ')),
        ],
      ),
      backgroundColor: Colors.black,
      body: PdfViewPinch(
        controller: _ctrl,
        onDocumentLoaded: (doc) => setState(() => _pages = doc.pagesCount),
        onPageChanged: (p) {
          setState(() => _page = p);
          Store.setInt('book_page_${widget.keyId}', p);
        },
      ),
    );
  }
}
