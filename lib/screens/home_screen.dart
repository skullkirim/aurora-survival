import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/i18n.dart';

import '../core/storage.dart';
import '../data/guides.dart';
import '../data/library.dart';
import '../data/species.dart';

import '../main.dart' show LangSwitch, appName, showTutorial;
import '../widgets/ill.dart';
import 'atlas_screen.dart';
import 'library_screen.dart';
import 'power_screen.dart';
import 'tools_screen.dart';

List<String> get _tips => [
  tr('Regla de los 3: 3 minutos sin aire, 3 horas sin refugio en clima extremo, 3 días sin agua, 3 semanas sin comida.', 'Rule of 3: 3 minutes without air, 3 hours without shelter in extreme weather, 3 days without water, 3 weeks without food.'),
  tr('Tres de cualquier cosa (fuegos, silbidos, destellos) significa AUXILIO en todo el mundo.', 'Three of anything (fires, whistles, flashes) means HELP all over the world.'),
  tr('Hierve el agua 1 minuto; en Bogotá o más alto, 3 minutos.', 'Boil water for 1 minute; above 2,000 m, 3 minutes.'),
  tr('2 gotas de blanqueador por litro de agua clara y 30 minutos de espera la vuelven segura.', '2 drops of bleach per liter of clear water and a 30-minute wait make it safe.'),
  tr('El algodón mojado no abriga: en frío usa lana o ropa sintética.', 'Wet cotton doesn\'t keep you warm: in the cold use wool or synthetics.'),
  tr('El suero oral casero: 1 litro de agua, 6 cucharaditas de azúcar y media de sal.', 'Homemade oral rehydration: 1 liter of water, 6 teaspoons of sugar and half a teaspoon of salt.'),
  tr('Si no estás 100 % seguro de una planta, no te la comas.', 'If you are not 100 % sure about a plant, don\'t eat it.'),
  tr('Los ríos llevan a los pueblos: si estás perdido, sigue el agua cuesta abajo.', 'Rivers lead to towns: if you are lost, follow water downhill.'),
  tr('Tras una explosión nuclear: entra, quédate dentro al menos 24 horas, infórmate.', 'After a nuclear blast: get inside, stay inside at least 24 hours, stay tuned.'),
  tr('Quitarte la ropa de afuera elimina hasta el 90 % del polvo radiactivo.', 'Removing your outer clothing removes up to 90 % of radioactive dust.'),
  tr('La linterna se ve a kilómetros de noche: SOS es ··· ——— ···', 'A flashlight can be seen for kilometers at night: SOS is ··· ——— ···'),
  tr('El método de la sombra: la primera marca de la sombra apunta al Oeste.', 'Shadow method: the first shadow mark points West.'),
  tr('Un refugio pequeño es un refugio caliente.', 'A small shelter is a warm shelter.'),
  tr('El suelo roba calor más rápido que el aire: aíslate con ramas u hojas.', 'The ground steals heat faster than air: insulate yourself with branches or leaves.'),
  tr('Nunca hagas fuego dentro de una carpa: el monóxido no huele y mata.', 'Never light a fire inside a tent: carbon monoxide has no smell and kills.'),
  tr('Remojar el fríjol desde la noche anterior ahorra la mitad del combustible.', 'Soaking beans overnight saves half the fuel.'),
  tr('Una letrina va a mínimo 30 metros del agua y cuesta abajo.', 'A latrine goes at least 30 meters from water and downhill.'),
  tr('El agua de un coco verde es estéril.', 'The water of a green coconut is sterile.'),
  tr('Las semillas criollas se pueden volver a sembrar; las híbridas no dan igual.', 'Heirloom seeds can be replanted; hybrid seeds don\'t breed true.'),
  tr('Lava una mordedura de animal 15 minutos con agua y jabón: reduce el riesgo de rabia.', 'Wash an animal bite for 15 minutes with soap and water: it lowers the risk of rabies.'),
  tr('Arrastra los pies al cruzar ríos: espantas a las rayas.', 'Shuffle your feet when crossing rivers: it scares stingrays away.'),
  tr('Un torniquete se pone 5–8 cm arriba de la herida y se anota la hora.', 'A tourniquet goes 5–8 cm above the wound, and you write down the time.'),
  tr('Modo avión: buscar señal es lo que más batería gasta.', 'Airplane mode: searching for signal drains the most battery.'),
  tr('Descarga el mapa de tu zona ahora: sin internet no podrás hacerlo.', 'Browse your area on the map now: what you see is saved for when there is no internet.'),
  tr('Guarda una radio en una caja metálica cerrada: la protege de un pulso electromagnético.', 'Keep a radio in a closed metal box: it protects it from an electromagnetic pulse.'),
  tr('Las hojas de guayaba en té son un remedio tradicional para la diarrea.', 'Guava leaf tea is a traditional remedy for diarrhea.'),
  tr('Practica Morse: aprende primero E, T, I, A, N, M, S.', 'Practice Morse: learn E, T, I, A, N, M, S first.'),
  tr('Las comunidades que cooperan sobreviven mejor que las personas solas.', 'Communities that cooperate survive better than people alone.'),
];

Widget _section(String title, {String? action, VoidCallback? onAction}) => Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 8),
      child: Row(children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        if (action != null) TextButton(onPressed: onAction, child: Text(action)),
      ]),
    );

class HomeScreen extends StatefulWidget {
  /// Cambia de pestaña en la barra inferior.
  final void Function(int tab) goTab;
  const HomeScreen({super.key, required this.goTab});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _battery;

  @override
  void initState() {
    super.initState();
    Battery().batteryLevel.then((v) {
      if (mounted) setState(() => _battery = v);
    }).catchError((_) {});
  }

  (Category, Article)? get _nextLesson {
    final read = Store.read;
    for (final c in library) {
      for (final a in c.articles) {
        if (!read.contains(a.id)) return (c, a);
      }
    }
    return null;
  }

  void _push(Widget w) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => w)).then((_) => setState(() {}));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final day = DateTime.now().difference(DateTime(2024)).inDays;
    final tip = _tips[day % _tips.length];
    final next = _nextLesson;
    final readCount = Store.read.length;
    final totalArticles = library.fold<int>(0, (a, c) => a + c.articles.length);

    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      children: [
        // ---------- Encabezado ----------
        Row(children: [
          SvgPicture.asset('assets/logo/logo.svg', height: 38),
          const SizedBox(width: 6),
          Expanded(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(appName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 3, color: cs.primary)),
            ),
          ),
          const LangSwitch(),
          const SizedBox(width: 4),
          ActionChip(
            avatar: Icon(Icons.battery_std,
                size: 18, color: (_battery ?? 100) > 30 ? Colors.green : Colors.red),
            label: Text(_battery == null ? tr('Ahorro', 'Saver') : '$_battery %'),
            onPressed: () => _push(const PowerScreen()),
          ),
          IconButton(
            tooltip: tr('Cómo usar la app', 'How to use the app'),
            icon: const Icon(Icons.help_outline),
            onPressed: () => showTutorial(context),
          ),
        ]),
        const SizedBox(height: 8),

        // ---------- Emergencia ----------
        SizedBox(
          height: 70,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFB71C1C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            icon: const Icon(Icons.emergency, size: 32),
            label: Text(tr('EMERGENCIA', 'EMERGENCY'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            onPressed: () => _push(const EmergencyScreen()),
          ),
        ),

        // ---------- ¿Qué necesitas? ----------
        _section(tr('¿Qué necesitas ahora?', 'What do you need now?'),
            action: tr('Ver las ${guides.length}', 'See all ${guides.length}', 'Ver as ${guides.length}'), onAction: () => _push(const EmergencyScreen())),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.15,
          children: [for (final g in guides.take(6)) GuideTile(g)],
        ),

        // ---------- Herramientas rápidas ----------
        _section(tr('Herramientas rápidas', 'Quick tools'), action: tr('Todas', 'All'), onAction: () => widget.goTab(3)),
        Row(children: [
          for (final (icon, label, page) in <(IconData, String, Widget Function())>[
            (Icons.flashlight_on, tr('Linterna', 'Flashlight'), () => const FlashlightScreen()),
            (Icons.sos, 'SOS', () => const MorseFlashScreen(initial: 'SOS')),
            (Icons.campaign, tr('Silbato', 'Whistle'), () => const WhistleScreen()),
            (Icons.explore, tr('Brújula', 'Compass'), () => const CompassScreen()),
          ])
            Expanded(
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _push(page()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(children: [
                      Icon(icon, color: cs.primary, size: 30),
                      const SizedBox(height: 4),
                      Text(label, style: const TextStyle(fontSize: 12)),
                    ]),
                  ),
                ),
              ),
            ),
        ]),

        // ---------- Mapa ----------
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            leading: CircleAvatar(
                radius: 24,
                backgroundColor: cs.primary.withValues(alpha: 0.15),
                child: Icon(Icons.map, color: cs.primary)),
            title: Text(tr('Mapa sin internet', 'Offline map'), style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(tr('Descarga el mapa de tu zona ahora y ubícate después sin señal', 'Browse your area now while online and find yourself later without signal')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => widget.goTab(4),
          ),
        ),

        // ---------- Sigue aprendiendo ----------
        _section(tr('Sigue aprendiendo', 'Keep learning'), action: tr('Todos los temas', 'All topics'), onAction: () => widget.goTab(2)),
        if (next != null)
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => openArticle(context, next.$1, next.$2).then((_) => setState(() {})),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Ill(illsFor(next.$1, next.$2).first.$1, radius: BorderRadius.zero),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(next.$1.name, style: TextStyle(color: cs.primary, fontSize: 13)),
                    Text(next.$2.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: readCount / totalArticles, minHeight: 5),
                    const SizedBox(height: 4),
                    Text(tr('$readCount de $totalArticles lecciones leídas', '$readCount of $totalArticles lessons read', '$readCount de $totalArticles lições lidas'),
                        style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ]),
                ),
              ]),
            ),
          ),
        SizedBox(
          height: 210,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final c in library)
                SizedBox(
                  width: 170,
                  child: TopicCard(c,
                      onTap: () => _push(CategoryScreen(c))),
                ),
            ],
          ),
        ),

        // ---------- Guía visual ----------
        _section(tr('Plantas y animales', 'Plants and animals'), action: tr('Abrir', 'Open'), onAction: () => _push(const AtlasScreen())),
        Wrap(spacing: 6, runSpacing: 6, children: [
          for (final k in Kind.values)
            ActionChip(
              avatar: Icon(k.icon, size: 16, color: k.color),
              label: Text(k.label, style: const TextStyle(fontSize: 12)),
              onPressed: () => _push(AtlasScreen(initial: k)),
            ),
        ]),

        // ---------- Dato del día ----------
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.lightbulb, color: cs.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(tr('Dato del día', 'Tip of the day'), style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(tip, style: const TextStyle(fontSize: 15)),
                ]),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
