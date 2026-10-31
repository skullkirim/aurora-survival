import 'c_basics.dart';
import 'c_extra.dart';
import 'c_food.dart';
import 'c_health.dart';
import 'c_hygiene.dart';
import 'c_safety.dart';
import 'c_nav.dart';
import 'c_rebuild.dart';
import '../core/i18n.dart';
import 'en/c_basics_en.dart';
import 'en/c_extra_en.dart';
import 'en/c_food_en.dart';
import 'en/c_health_en.dart';
import 'en/c_hygiene_en.dart';
import 'en/c_safety_en.dart';
import 'en/c_nav_en.dart';
import 'en/c_rebuild_en.dart';
import 'models.dart';
import 'pt/content_pt.dart';

export 'models.dart';

const List<Category> libraryEs = [
  primerosAuxilios,
  agua,
  fuego,
  refugio,
  comida,
  plantas,
  medicinaNatural,
  higiene,
  orientacion,
  nudos,
  desastres,
  seguridad,
  radiacion,
  animales,
  comunicacion,
  reconstruir,
  mente,
];

const List<Category> libraryEn = [
  firstAidEn,
  waterEn,
  fireEn,
  shelterEn,
  foodEn,
  plantsEn,
  herbalEn,
  hygieneEn,
  navigationEn,
  knotsEn,
  disastersEn,
  safetyEn,
  radiationEn,
  animalsEn,
  commsEn,
  rebuildEn,
  mindEn,
];

/// Temas en el idioma actual.
List<Category> get library => isEn ? libraryEn : (isPt ? libraryPt : libraryEs);

List<Category>? _libraryPt;

/// Portugués: nombres de los temas traducidos; las lecciones siguen en español.
List<Category> get libraryPt => _libraryPt ??= [
      for (final c in libraryEs)
        Category(
          id: c.id,
          name: catPt[c.id]?.$1 ?? c.name,
          icon: c.icon,
          summary: catPt[c.id]?.$2 ?? c.summary,
          articles: c.articles,
          quiz: c.quiz,
        ),
    ];

Map<String, (Category, Article)>? _idxEs, _idxEn, _idxPt;

/// Índice rápido id -> (categoría, artículo) en el idioma actual.
Map<String, (Category, Article)> get articleIndex => isEn
    ? (_idxEn ??= {for (final c in libraryEn) for (final a in c.articles) a.id: (c, a)})
    : isPt
        ? (_idxPt ??= {for (final c in libraryPt) for (final a in c.articles) a.id: (c, a)})
        : (_idxEs ??= {for (final c in libraryEs) for (final a in c.articles) a.id: (c, a)});

/// Búsqueda sin acentos y sin mayúsculas.
String norm(String s) {
  const from = 'áéíóúüñÁÉÍÓÚÜÑãõçêâôàÃÕÇÊÂÔÀ';
  const to = 'aeiouunAEIOUUNaoceaoaAOCEAOA';
  final b = StringBuffer();
  for (final ch in s.split('')) {
    final i = from.indexOf(ch);
    b.write(i >= 0 ? to[i] : ch);
  }
  return b.toString().toLowerCase();
}

List<(Category, Article)> searchArticles(String q) {
  final n = norm(q.trim());
  if (n.isEmpty) return [];
  final title = <(Category, Article)>[];
  final body = <(Category, Article)>[];
  for (final c in library) {
    for (final a in c.articles) {
      if (norm(a.title).contains(n)) {
        title.add((c, a));
      } else if (norm(a.body).contains(n)) {
        body.add((c, a));
      }
    }
  }
  return [...title, ...body];
}
