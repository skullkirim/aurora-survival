import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/i18n.dart';
import 'core/power.dart';
import 'core/storage.dart';
import 'core/theme.dart';
import 'core/tile_store.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/library_screen.dart';
import 'screens/map_screen.dart';
import 'screens/tools_screen.dart';

final ValueNotifier<bool> redMode = ValueNotifier(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Store.init();
  redMode.value = Store.redMode;
  initLang();
  Power.applyAll(); // 60 Hz y brillo guardado
  TileStore.migrate(); // limpia mapas de la versión anterior
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    systemNavigationBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const AuroraApp());
}

const appName = 'AURORA';

class AuroraApp extends StatelessWidget {
  const AuroraApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Se reconstruye todo al cambiar el modo rojo o el idioma.
    return AnimatedBuilder(
      animation: Listenable.merge([redMode, lang]),
      builder: (_, __) => MaterialApp(
        key: ValueKey(lang.value),
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: buildTheme(red: redMode.value),
        builder: (context, child) => IdleDimmer(child: child ?? const SizedBox()),
        home: const HomeShell(),
      ),
    );
  }
}

/// Selector de idioma ES / EN / PT (compacto para no apretar el encabezado).
class LangSwitch extends StatelessWidget {
  const LangSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Idioma / Language',
      initialValue: lang.value,
      onSelected: setLang,
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'es', child: Text('🇨🇴  Español')),
        PopupMenuItem(value: 'en', child: Text('🇺🇸  English')),
        PopupMenuItem(value: 'pt', child: Text('🇧🇷  Português')),
      ],
      child: Chip(
        visualDensity: VisualDensity.compact,
        avatar: const Icon(Icons.translate, size: 16),
        label: Text(lang.value.toUpperCase()),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Store.getString('lang') == null) {
        // Primera vez: elegir idioma (al cambiarlo la app se reconstruye).
        final l = await showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => SimpleDialog(
            backgroundColor: const Color(0xFF0D0D0D),
            title: Column(children: [
              SvgPicture.asset('assets/logo/logo.svg', height: 96),
              const SizedBox(height: 12),
              const Text('Idioma / Language / Idioma', textAlign: TextAlign.center),
            ]),
            children: [
              SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, 'es'),
                  child: const Text('🇨🇴  Español', style: TextStyle(fontSize: 20))),
              SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, 'en'),
                  child: const Text('🇺🇸  English', style: TextStyle(fontSize: 20))),
              SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, 'pt'),
                  child: const Text('🇧🇷  Português', style: TextStyle(fontSize: 20))),
            ],
          ),
        );
        await setLang(l ?? lang.value);
        return;
      }
      if (!Store.getBool('tutorial_done') && mounted) {
        await showTutorial(context);
        Store.setBool('tutorial_done', true);
      }
    });
  }

  void _go(int i) => setState(() => _tab = i);

  // Las pantallas se construyen solo cuando se abren (sensores apagados si no).
  Widget _page(int i) => switch (i) {
        0 => HomeScreen(goTab: _go),
        1 => const LibraryScreen(),
        2 => const LearnScreen(),
        3 => const ToolsScreen(),
        _ => const MapScreen(),
      };

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // El botón "atrás" vuelve a Inicio antes de cerrar la app.
      canPop: _tab == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _go(0);
      },
      child: Scaffold(
        body: SafeArea(child: _page(_tab)),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tab,
          height: 66,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          animationDuration: Duration.zero,
          onDestinationSelected: _go,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: tr('Inicio', 'Home')),
            NavigationDestination(
                icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: tr('Biblioteca', 'Library')),
            NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: tr('Aprender', 'Learn')),
            NavigationDestination(icon: Icon(Icons.build_outlined), selectedIcon: Icon(Icons.build), label: tr('Herramientas', 'Tools')),
            NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: tr('Mapa', 'Map')),
          ],
        ),
      ),
    );
  }
}

/// Tutorial corto de bienvenida (se puede abrir de nuevo con el botón "?").
Future<void> showTutorial(BuildContext context) {
  final pages = [
    (Icons.shield_moon, tr('Bienvenido a AURORA', 'Welcome to AURORA'),
        tr('Tu manual de supervivencia. Funciona SIN internet y gasta muy poca batería.', 'Your survival manual. Works WITHOUT internet and uses very little battery.')),
    (Icons.emergency, tr('Emergencias', 'Emergencies'), tr('En Inicio, el botón rojo EMERGENCIA te guía paso a paso: sangrado, no respira, nuclear, perdido...', 'On Home, the red EMERGENCY button guides you step by step: bleeding, not breathing, nuclear, lost...')),
    (Icons.menu_book, tr('Biblioteca', 'Library'), tr('Temas para leer, fotos de plantas y animales (qué se come, qué cura, qué mata) y libros en PDF.', 'Topics to read, photos of plants and animals (what you can eat, what heals, what kills) and PDF books.')),
    (Icons.school, tr('Aprender', 'Learn'), tr('Cursos con lecciones y exámenes. Sube de rango: de Novato a Reconstructor.', 'Courses with lessons and quizzes. Rank up: from Rookie to Rebuilder.')),
    (Icons.build, tr('Herramientas', 'Tools'), tr('Linterna, Morse (escribe una palabra y envíala con luz o sonido), silbato, brújula, pulso, sol y luna, ficha médica...', 'Flashlight, Morse (type a word and send it with light or sound), whistle, compass, pulse, sun and moon, medical card...')),
    (Icons.map, tr('Mapa', 'Map'), tr('Con internet, RECORRE TU ZONA en el mapa: queda guardada para que veas dónde estás sin señal.', 'While you have internet, BROWSE YOUR AREA on the map: it is saved so you can see where you are without signal.')),
    (Icons.battery_std, tr('Batería', 'Battery'), tr('Toca el indicador de batería en Inicio para activar el ahorro extremo.', 'Tap the battery indicator on Home to turn on extreme saving.')),
  ];
  final ctrl = PageController();
  var index = 0;
  return showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setD) {
        final cs = Theme.of(ctx).colorScheme;
        final last = index == pages.length - 1;
        return Dialog(
          backgroundColor: const Color(0xFF0D0D0D),
          child: SizedBox(
            height: 380,
            child: Column(children: [
              Expanded(
                child: PageView(
                  controller: ctrl,
                  onPageChanged: (i) => setD(() => index = i),
                  children: [
                    for (final (icon, title, text) in pages)
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          if (icon == Icons.shield_moon)
                            SvgPicture.asset('assets/logo/logo.svg', height: 110)
                          else
                            Icon(icon, size: 72, color: cs.primary),
                          const SizedBox(height: 16),
                          Text(title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                        ]),
                      ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var i = 0; i < pages.length; i++)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == index ? cs.primary : const Color(0xFF444444),
                    ),
                  ),
              ]),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: Text(tr('Saltar', 'Skip'))),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => last
                        ? Navigator.pop(ctx)
                        : ctrl.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeOut),
                    child: Text(last ? tr('Empezar', 'Start') : tr('Siguiente', 'Next')),
                  ),
                ]),
              ),
            ]),
          ),
        );
      },
    ),
  );
}
