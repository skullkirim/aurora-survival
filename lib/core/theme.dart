import 'package:flutter/material.dart';

/// Tema AMOLED: fondo negro puro (los píxeles negros no consumen energía en
/// pantallas OLED/AMOLED). Modo rojo: protege la visión nocturna.
/// Transición instantánea entre pantallas: ahorra GPU/batería.
class _NoTransition extends PageTransitionsBuilder {
  const _NoTransition();
  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context,
          Animation<double> a, Animation<double> b, Widget child) =>
      child;
}

ThemeData buildTheme({required bool red}) {
  final accent = red ? const Color(0xFFE53935) : const Color(0xFFFFB300);
  final scheme = ColorScheme.dark(
    primary: accent,
    secondary: accent,
    surface: Colors.black,
    onSurface: red ? const Color(0xFFFF8A80) : const Color(0xFFE6E6E6),
    onPrimary: Colors.black,
    surfaceContainerHighest: const Color(0xFF111111),
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    // Sin animaciones de "splash" -> menos redibujado.
    splashFactory: NoSplash.splashFactory,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: _NoTransition(),
      TargetPlatform.iOS: _NoTransition(),
    }),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: accent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF0D0D0D),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF222222)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      indicatorColor: accent.withValues(alpha: 0.18),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 11, color: scheme.onSurface),
      ),
    ),
    dividerColor: const Color(0xFF222222),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      isDense: true,
    ),
  );
}
