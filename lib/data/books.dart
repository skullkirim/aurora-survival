import '../core/i18n.dart';

/// Libros gratuitos recomendados. Se descargan una vez (con internet) y luego
/// se leen sin conexión dentro de la app.
class BookPart {
  final String id;
  final String title;

  /// URLs a probar en orden (espejos).
  final List<String> urls;
  final String size;
  const BookPart(this.id, this.title, this.urls, this.size);
}

class Book {
  final String title;
  final String author;
  final String lang;
  final String about;
  final String license;
  final String page; // página oficial
  final List<BookPart> parts;
  const Book(this.title, this.author, this.lang, this.about, this.license, this.page, this.parts);
}

const _hes = 'https://hesperian.org/wp-content/uploads/pdf/es_wtnd_2017/es_wtnd_2017_';
const _hesW = 'https://hesperian.org/wp-content/uploads/pdf/es_wwhnd_2024/es_wwhnd_2024_';

const List<Book> books = [
  Book(
    'Donde no hay doctor',
    'David Werner · Hesperian',
    'Español',
    'El manual de salud más usado del mundo en zonas sin médico: primeros auxilios, enfermedades comunes, medicinas, '
        'remedios caseros que sirven y los que no. Imprescindible.',
    'Gratis para leer en hesperian.org. Si puedes, compra el libro completo o dona para apoyarlos.',
    'https://languages.hesperian.org/pages/es/pdf.html',
    [
      BookPart('wtnd_10', 'Cap. 10 · Primeros auxilios', ['${_hes}10.pdf'], '≈4 MB'),
      BookPart('wtnd_01', 'Cap. 1 · Curaciones caseras y creencias populares', ['${_hes}01.pdf'], '≈2 MB'),
      BookPart('wtnd_05', 'Cap. 5 · Curando sin medicinas', ['${_hes}05.pdf'], '≈1 MB'),
      BookPart('wtnd_11', 'Cap. 11 · Nutrición', ['${_hes}11.pdf'], '≈3 MB'),
      BookPart('wtnd_12', 'Cap. 12 · Medicina preventiva', ['${_hes}12.pdf'], '≈2 MB'),
      BookPart('wtnd_13', 'Cap. 13 · Enfermedades muy comunes', ['${_hes}13.pdf'], '≈3 MB'),
      BookPart('wtnd_14', 'Cap. 14 · Enfermedades graves', ['${_hes}14.pdf'], '≈2 MB'),
      BookPart('wtnd_19', 'Cap. 19 · Madres y parteras', ['${_hes}19.pdf'], '≈4 MB'),
      BookPart('wtnd_21', 'Cap. 21 · Salud de los niños', ['${_hes}21.pdf'], '≈3 MB'),
      BookPart('wtnd_23', 'Cap. 23 · El botiquín', ['${_hes}23.pdf'], '≈1 MB'),
      BookPart('wtnd_gp', 'Páginas verdes · Las medicinas y sus dosis', ['${_hes}gp.pdf'], '≈4 MB'),
    ],
  ),
  Book(
    'Donde no hay doctor para mujeres',
    'Hesperian',
    'Español',
    'Salud de la mujer, embarazo, parto y lactancia cuando no hay atención médica.',
    'Gratis para leer en hesperian.org.',
    'https://languages.hesperian.org/pages/es/pdf.html',
    [
      BookPart('wwhnd_06', 'Cap. 6 · El embarazo y el parto', ['${_hesW}06.pdf'], '≈5 MB'),
      BookPart('wwhnd_07', 'Cap. 7 · Dando pecho', ['${_hesW}07.pdf'], '≈2 MB'),
      BookPart('wwhnd_27', 'Cap. 27 · La salud mental', ['${_hesW}27.pdf'], '≈2 MB'),
    ],
  ),
  Book(
    'Survival (FM 21-76)',
    'Ejército de EE. UU.',
    'Inglés',
    'El manual de supervivencia militar clásico: agua, fuego, refugio, plantas, trampas, orientación, '
        'climas extremos. Muchas ilustraciones.',
    'Documento del gobierno de EE. UU.: dominio público.',
    'https://archive.org/details/FM21-76Survival1957',
    [
      BookPart('fm2176', 'Libro completo', [
        'https://www.sjsu.edu/people/michelle.hager/docs/fm_21-76_us_army_survival_manual_2006.pdf',
        'https://archive.org/download/FM21-76Survival1957/FM21-76Survival1957.pdf',
      ], '≈10 MB'),
    ],
  ),
  Book(
    'Nuclear War Survival Skills',
    'Cresson H. Kearny · Oak Ridge National Laboratory',
    'Inglés',
    'La guía más completa para sobrevivir a una guerra nuclear: refugios caseros, ventilación, agua, comida, '
        'medir radiación con instrumentos hechos en casa.',
    'Publicación de un laboratorio del gobierno de EE. UU., de libre distribución.',
    'https://apps.dtic.mil/sti/citations/ADA328301',
    [
      BookPart('nwss', 'Libro completo', [
        'https://apps.dtic.mil/sti/tr/pdf/ADA328301.pdf',
        'https://ia600501.us.archive.org/35/items/NuclearWarSurvivalSkills_201405/nwss.pdf',
      ], '≈15 MB'),
    ],
  ),
];

/// Textos en inglés de los libros: título -> (idioma, descripción, licencia).
const Map<String, (String, String, String)> _bookEn = {
  'Donde no hay doctor': ('Spanish', 'The most used health manual in the world for places without a doctor: first aid, common illnesses, medicines, home remedies that work and those that don\'t. Essential.',
      'Free to read at hesperian.org. If you can, buy the full book or donate to support them.'),
  'Donde no hay doctor para mujeres': ('Spanish', 'Women\'s health, pregnancy, birth and breastfeeding when there is no medical care.', 'Free to read at hesperian.org.'),
  'Survival (FM 21-76)': ('English', 'The classic military survival manual: water, fire, shelter, plants, traps, navigation, extreme climates. Many illustrations.',
      'U.S. government document: public domain.'),
  'Nuclear War Survival Skills': ('English', 'The most complete guide to surviving a nuclear war: homemade shelters, ventilation, water, food, measuring radiation with homemade instruments.',
      'Published by a U.S. government laboratory, freely distributable.'),
};

String bookLang(Book b) => isEn ? (_bookEn[b.title]?.$1 ?? b.lang) : b.lang;
String bookAbout(Book b) => isEn ? (_bookEn[b.title]?.$2 ?? b.about) : b.about;
String bookLicense(Book b) => isEn ? (_bookEn[b.title]?.$3 ?? b.license) : b.license;
