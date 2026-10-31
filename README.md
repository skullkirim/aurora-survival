# AURORA — Supervivencia offline / Offline survival

Manual de supervivencia para Android que funciona **100 % sin internet** y gasta muy poca batería. Hecho en Flutter por **PanLabStudios**. Español · English · Português.

📥 **Descargar el APK:** ver [Releases](../../releases) (instálalo permitiendo "orígenes desconocidos").

## Qué trae
- **Emergencia paso a paso**: sangrado (con alarma de torniquete), no respira (RCP), atragantamiento, agua, fuego, frío, perdido, rescate, nuclear, serpiente, plantas, sismo.
- **Biblioteca**: 17 temas ilustrados (primeros auxilios, agua, fuego, refugio, comida, plantas, medicina natural, **higiene y botiquín casero**, orientación, nudos, desastres, **autoprotección y seguridad**, radiación, animales, comunicación, reconstruir la sociedad, mente) · 96 plantas y animales con foto · libros PDF.
- **Aprender**: lecciones, exámenes y rangos.
- **Herramientas**: SOS con linterna, silbato, Morse (escribir/descifrar/practicar), pantalla señal, estroboscópica, metrónomo de RCP, pulso, ficha médica, **alarmas** (medicinas, torniquete, guardia), brújula, sol y luna, provisiones + lista de personas, **recetas con tu despensa** (25), **modo comunidad** (comparte provisiones y personas entre teléfonos por hotspot Wi-Fi, sin internet), raciones, radiación, ahorro de batería.
- **Mapa**: mapa vectorial **sin internet** desde un archivo `.pmtiles` (lector propio en `lib/core/vector_map.dart`), GPS, puntos, navegar con brújula, grabar ruta, medir distancia y área, exportar GPX.

## Compilar
```powershell
git clone https://github.com/skullkirim/aurora-survival
cd aurora-survival
powershell -ExecutionPolicy Bypass -File .\setup.ps1
powershell -ExecutionPolicy Bypass -File .\tool\imagenes.ps1   # fotos de especies (opcional, con internet)
flutter run --release
```

## Mapa sin internet
```powershell
powershell -ExecutionPolicy Bypass -File .\tool\mapa_offline.ps1                 # Colombia hasta zoom 14
powershell -ExecutionPolicy Bypass -File .\tool\mapa_offline.ps1 -Zona bogota -MaxZoom 15
```
Baja la herramienta `pmtiles`, recorta tu zona del mapa base de Protomaps y la copia al teléfono por cable (ADB). En la app: Mapa → Mapa sin internet → Buscar.

## Ahorro de batería
Pantalla a 60 Hz (MainActivity nativa en `android_overrides/`), brillo propio y atenuado automático, modo ahorro extremo, negro puro AMOLED, sin animaciones, GPS y red solo bajo demanda.

## Agregar contenido
Textos en `lib/data/c_*.dart` (español), `lib/data/en/` (inglés), `lib/data/pt/` y `lib/core/pt_ui.dart` (portugués). Marcado: `## título`, `- viñeta`, `! advertencia`, `* consejo`, `@ ids` de especies.

## Créditos
- Mapas © colaboradores de [OpenStreetMap](https://www.openstreetmap.org/copyright) (ODbL); mapa base de [Protomaps](https://protomaps.com).
- Fotos de Wikimedia Commons bajo licencias libres; autor y licencia en `assets/img/credits.json` y dentro de la app.

> ⚠️ Contenido educativo. No reemplaza a un médico, a los socorristas ni a las autoridades. Si hay ayuda profesional disponible, úsala.
