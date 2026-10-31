import 'package:flutter/material.dart';

import '../core/i18n.dart';

import '../core/storage.dart';
import '../data/guides.dart';
import '../data/ill_map.dart';
import '../data/library.dart';
import '../widgets/ill.dart';
import '../widgets/markup.dart';
import 'atlas_screen.dart';
import 'books_screen.dart';
import 'guide_screen.dart';
import 'learn_screen.dart' show QuizScreen;

/// Biblioteca: Temas · Plantas y animales · Libros.
class LibraryScreen extends StatelessWidget {
  final int initialTab;
  const LibraryScreen({super.key, this.initialTab = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialTab,
      child: Column(children: [
        TabBar(tabs: [
          Tab(icon: Icon(Icons.menu_book_outlined), text: tr('Temas', 'Topics')),
          Tab(icon: Icon(Icons.photo_library_outlined), text: tr('Plantas y animales', 'Plants and animals')),
          Tab(icon: Icon(Icons.library_books_outlined), text: tr('Libros', 'Books')),
        ]),
        Expanded(
          child: TabBarView(children: [
            _TopicsTab(),
            AtlasScreen(embedded: true),
            BooksTab(),
          ]),
        ),
      ]),
    );
  }
}

/// Tarjeta de tema con dibujo, nombre y progreso.
class TopicCard extends StatelessWidget {
  final Category cat;
  final VoidCallback onTap;
  const TopicCard(this.cat, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final read = Store.read;
    final done = cat.articles.where((a) => read.contains(a.id)).length;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Ill(coverFor(cat.id), radius: BorderRadius.zero),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(cat.icon, size: 18, color: cs.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(cat.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ]),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: done / cat.articles.length,
                minHeight: 5,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 3),
              Text(tr('$done de ${cat.articles.length} lecciones', '$done of ${cat.articles.length} lessons', '$done de ${cat.articles.length} lições'),
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _TopicsTab extends StatefulWidget {
  const _TopicsTab();
  @override
  State<_TopicsTab> createState() => _TopicsTabState();
}

class _TopicsTabState extends State<_TopicsTab> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final results = searchArticles(_q);
    final favs = Store.favs.where(articleIndex.containsKey).toList();

    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: tr('Buscar: agua, sangrado, radiación, mango...', 'Search: water, bleeding, radiation, mango...')),
            onChanged: (v) => setState(() => _q = v),
          ),
        ),
      ),
      if (_q.trim().isNotEmpty)
        SliverList.list(children: [
          if (results.isEmpty) Padding(padding: EdgeInsets.all(16), child: Text(tr('Sin resultados.', 'No results.'))),
          for (final (c, a) in results)
            ListTile(
              leading: Icon(c.icon),
              title: Text(a.title),
              subtitle: Text(c.name),
              onTap: () => openArticle(context, c, a).then((_) => setState(() {})),
            ),
        ])
      else ...[
        if (favs.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(spacing: 6, runSpacing: 6, children: [
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(tr('★ Guardados:', '★ Saved:'), style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                for (final id in favs)
                  ActionChip(
                    label: Text(articleIndex[id]!.$2.title),
                    onPressed: () => openArticle(context, articleIndex[id]!.$1, articleIndex[id]!.$2)
                        .then((_) => setState(() {})),
                  ),
              ]),
            ),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(tr('Elige un tema', 'Choose a topic'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              childAspectRatio: 0.95,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, i) => TopicCard(library[i],
                  onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => CategoryScreen(library[i])))
                      .then((_) => setState(() {}))),
              childCount: library.length,
            ),
          ),
        ),
      ],
    ]);
  }
}

Future<void> openArticle(BuildContext context, Category c, Article a) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => ArticleScreen(c, a)));

/// Ilustraciones de una lección (o la portada del tema).
List<(String, String)> illsFor(Category c, Article a) => articleIll[a.id] ?? [(coverFor(c.id), '')];

class CategoryScreen extends StatefulWidget {
  final Category cat;
  const CategoryScreen(this.cat, {super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final read = Store.read;
    final c = widget.cat;
    final best = Store.quizBest(c.id);
    final next = c.articles.where((a) => !read.contains(a.id)).firstOrNull;
    return Scaffold(
      appBar: AppBar(title: Text(c.name)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Ill(coverFor(c.id)),
          const SizedBox(height: 10),
          Text(c.summary, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          if (next != null)
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: Text(read.contains(c.articles.first.id) ? tr('Continuar', 'Continue') : tr('Empezar el tema', 'Start the topic')),
                onPressed: () => openArticle(context, c, next).then((_) => setState(() {})),
              ),
            ),
          const SizedBox(height: 12),
          Text(tr('${c.articles.length} lecciones', '${c.articles.length} lessons', '${c.articles.length} lições'), style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          for (var i = 0; i < c.articles.length; i++)
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => openArticle(context, c, c.articles[i]).then((_) => setState(() {})),
                child: Row(children: [
                  SizedBox(
                    width: 104,
                    child: Ill(illsFor(c, c.articles[i]).first.$1, radius: BorderRadius.zero),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(tr('Lección ${i + 1}', 'Lesson ${i + 1}', 'Lição ${i + 1}'), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(c.articles[i].title,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: read.contains(c.articles[i].id)
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.chevron_right),
                  ),
                ]),
              ),
            ),
          const SizedBox(height: 12),
          if (c.quiz.isNotEmpty)
            SizedBox(
              height: 54,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.quiz),
                label: Text(best >= 0
                    ? tr('Repetir examen (mejor: $best/${c.quiz.length})', 'Retake quiz (best: $best/${c.quiz.length})', 'Repetir prova (melhor: $best/${c.quiz.length})')
                    : tr('Ponte a prueba: examen de ${c.quiz.length} preguntas', 'Test yourself: ${c.quiz.length}-question quiz', 'Teste-se: prova de ${c.quiz.length} perguntas')),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(c)))
                    .then((_) => setState(() {})),
              ),
            ),
        ],
      ),
    );
  }
}

class ArticleScreen extends StatefulWidget {
  final Category cat;
  final Article article;
  const ArticleScreen(this.cat, this.article, {super.key});
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _scale = Store.getInt('text_scale', 100) / 100;
    Store.markRead(widget.article.id);
  }

  void _setScale(double s) {
    setState(() => _scale = s.clamp(0.8, 1.8));
    Store.setInt('text_scale', (_scale * 100).round());
  }

  @override
  Widget build(BuildContext context) {
    final fav = Store.favs.contains(widget.article.id);
    final list = widget.cat.articles;
    final i = list.indexOf(widget.article);
    final guide = guides.where((g) => g.article == widget.article.id).firstOrNull;
    final ills = illsFor(widget.cat, widget.article);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat.name, style: const TextStyle(fontSize: 16)),
        actions: [
          IconButton(
              tooltip: tr('Letra más pequeña', 'Smaller text'),
              icon: const Icon(Icons.text_decrease),
              onPressed: () => _setScale(_scale - 0.1)),
          IconButton(
              tooltip: tr('Letra más grande', 'Larger text'),
              icon: const Icon(Icons.text_increase),
              onPressed: () => _setScale(_scale + 0.1)),
          IconButton(
            tooltip: tr('Guardar', 'Save'),
            icon: Icon(fav ? Icons.star : Icons.star_border),
            onPressed: () async {
              await Store.toggleFav(widget.article.id);
              setState(() {});
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          // Barra de progreso de las lecciones del tema
          Row(children: [
            for (var k = 0; k < list.length; k++)
              Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  color: k <= i ? Theme.of(context).colorScheme.primary : const Color(0xFF333333),
                ),
              ),
          ]),
          const SizedBox(height: 8),
          Text(tr('Lección ${i + 1} de ${list.length}', 'Lesson ${i + 1} of ${list.length}', 'Lição ${i + 1} de ${list.length}'), style: const TextStyle(color: Colors.grey)),
          Text(widget.article.title, style: TextStyle(fontSize: 24 * _scale, fontWeight: FontWeight.bold)),
          if (isPt)
            const Text('Lição em espanhol (tradução para o português em andamento).',
                style: TextStyle(color: Colors.orange, fontSize: 12)),
          if (guide != null) ...[
            const SizedBox(height: 8),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: guide.color),
              icon: Icon(guide.icon, color: Colors.black),
              label: Text(tr('¿Es una emergencia? Ver PASO A PASO', 'Is it an emergency? See STEP BY STEP'), style: TextStyle(color: Colors.black)),
              onPressed: () => openGuide(context, guide),
            ),
          ],
          const SizedBox(height: 6),
          for (final (name, caption) in ills) IllCaption(name, caption, scale: _scale),
          const SizedBox(height: 6),
          Markup(widget.article.body, scale: _scale),
          const SizedBox(height: 24),
          if (i >= 0 && i < list.length - 1)
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: Text(tr('Siguiente: ${list[i + 1].title}', 'Next: ${list[i + 1].title}', 'Próxima: ${list[i + 1].title}'), overflow: TextOverflow.ellipsis),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ArticleScreen(widget.cat, list[i + 1]))),
              ),
            )
          else if (widget.cat.quiz.isNotEmpty)
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                icon: const Icon(Icons.quiz),
                label: Text(tr('Terminaste el tema: hacer el examen', 'Topic finished: take the quiz')),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => QuizScreen(widget.cat))),
              ),
            ),
        ],
      ),
    );
  }
}

/// Emergencias: botones grandes que abren guías paso a paso.
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('EMERGENCIA', 'EMERGENCY'))),
      body: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.05,
        children: [
          for (final g in guides) GuideTile(g),
        ],
      ),
    );
  }
}

/// Botón grande de situación (con dibujo si existe).
class GuideTile extends StatelessWidget {
  final Guide g;
  const GuideTile(this.g, {super.key});

  @override
  Widget build(BuildContext context) {
    final ill = guideIll[g.id]?.values.first;
    return Material(
      color: g.color.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openGuide(context, g),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (ill != null)
            Expanded(child: Ill(ill, radius: BorderRadius.zero))
          else
            Expanded(child: Icon(g.icon, size: 48, color: g.color)),
          Container(
            color: g.color.withValues(alpha: 0.85),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(children: [
              Icon(g.icon, color: Colors.black, size: 20),
              const SizedBox(width: 6),
              Expanded(
                child: Text(g.title,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
