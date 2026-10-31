import 'package:flutter/material.dart';

import '../core/i18n.dart';
import 'en/guides_en.dart';
import 'pt/content_pt.dart';

/// Un paso de una guía: título corto, explicación y si es una advertencia.
class GuideStep {
  final String title;
  final String text;
  final bool warn;

  /// Especies a mostrar con foto en este paso (ids de la guía visual).
  final List<String> species;
  const GuideStep(this.title, this.text, {this.warn = false, this.species = const []});
}

/// Guía "paso a paso" para una situación concreta.
class Guide {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<GuideStep> steps;

  /// Artículo para leer más (id de la biblioteca).
  final String? article;

  /// Herramienta relacionada: 'sos', 'morse', 'linterna', 'brujula', 'radiacion', 'mapa', 'atlas'.
  final String? tool;
  const Guide(this.id, this.title, this.subtitle, this.icon, this.color, this.steps,
      {this.article, this.tool});
}

const _red = Color(0xFFE53935);
const _blue = Color(0xFF42A5F5);
const _orange = Color(0xFFFF9800);
const _green = Color(0xFF43A047);
const _purple = Color(0xFFAB47BC);
const _yellow = Color(0xFFFDD835);

const List<Guide> guidesEs = [
  Guide('sangrado', 'Sangra mucho', 'Herida que no para de sangrar', Icons.bloodtype, _red, [
    GuideStep('¿Es seguro acercarte?', 'Mira alrededor: tráfico, fuego, derrumbes, personas armadas. Si no es seguro, no te acerques todavía.'),
    GuideStep('Presiona fuerte', 'Pon una tela limpia (camiseta, gasa) sobre la herida y aprieta con las dos manos, con todo tu peso. No levantes para mirar.'),
    GuideStep('Mantén 10 minutos', 'Sigue apretando al menos 10 minutos seguidos. Si la tela se empapa, pon otra ENCIMA sin quitar la primera.'),
    GuideStep('Herida profunda', 'Si es en axila, ingle o cuello y sigue sangrando: mete tela dentro de la herida hasta llenarla y presiona encima.'),
    GuideStep('¿Brazo o pierna y no para?', 'Torniquete: cinta ancha (cinturón, tela) 5–8 cm ARRIBA de la herida. Gira un palo hasta que el sangrado PARE. Ata el palo.', warn: true),
    GuideStep('Anota la hora', 'Escribe la hora del torniquete en la frente de la persona. No lo aflojes: duele mucho, es normal.'),
    GuideStep('Evita el shock', 'Acuéstalo, abrígalo y, si no hay fracturas en las piernas, levántalas un poco. Háblale y mantenlo tranquilo.'),
  ], article: 'aux_hemorragia', tool: 'torniquete'),
  Guide('rcp', 'No respira', 'Persona inconsciente que no respira', Icons.favorite, _red, [
    GuideStep('Llámalo fuerte', 'Sacúdelo de los hombros y grita "¿Me oyes?". Si responde, no necesita RCP.'),
    GuideStep('Mira si respira', 'Inclina su cabeza hacia atrás levantando el mentón. Mira el pecho 10 segundos. Boqueadas raras NO cuentan como respirar.'),
    GuideStep('Pide ayuda', 'Grita pidiendo ayuda. Si alguien puede buscar un desfibrilador o llamar, que lo haga ya.'),
    GuideStep('Manos en el pecho', 'Arrodíllate a su lado. Talón de una mano en el centro del pecho, la otra encima, brazos rectos.'),
    GuideStep('Comprime fuerte y rápido', 'Hunde el pecho 5–6 cm, 100 a 120 veces por minuto (ritmo de "Stayin\' Alive"). Deja que el pecho suba entre cada una.'),
    GuideStep('30 y 2', 'Si sabes: después de 30 compresiones, 2 soplos (nariz tapada, 1 segundo cada uno). Si no sabes, solo compresiones sin parar.'),
    GuideStep('No pares', 'Sigue hasta que respire, llegue ayuda o no puedas más. Cambia de persona cada 2 minutos.'),
  ], article: 'aux_rcp'),
  Guide('atragantado', 'Se atragantó', 'No puede respirar ni hablar', Icons.air, _red, [
    GuideStep('¿Puede toser?', 'Si tose con fuerza, anímalo a seguir tosiendo. No le pegues todavía.'),
    GuideStep('5 golpes en la espalda', 'Inclínalo hacia adelante y dale 5 golpes fuertes entre los omóplatos con el talón de la mano.'),
    GuideStep('5 compresiones en el abdomen', 'Ponte detrás, puño entre ombligo y pecho, la otra mano encima: tira fuerte hacia adentro y arriba 5 veces.'),
    GuideStep('Repite', 'Alterna 5 golpes y 5 compresiones hasta que salga el objeto.'),
    GuideStep('Si se desmaya', 'Acuéstalo y empieza RCP. Antes de soplar, mira si el objeto está en la boca y sácalo con el dedo solo si lo ves.', warn: true),
  ], article: 'aux_atragantamiento'),
  Guide('agua', 'Necesito agua', 'Encontrar y potabilizar', Icons.water_drop, _blue, [
    GuideStep('Busca la mejor fuente', 'Mejor a peor: lluvia recogida, manantial, río con corriente, laguna, charco. En casa: tanque del sanitario (la caja de atrás) o el calentador.'),
    GuideStep('Deja asentar y filtra', 'Si está turbia, déjala reposar y pásala por una tela doblada varias veces.'),
    GuideStep('Hierve', 'Haz que hierva a borbotones 1 minuto (3 minutos si estás a más de 2.000 m, como Bogotá). Tapa y deja enfriar.'),
    GuideStep('O usa cloro', 'Blanqueador normal sin aroma: 2 gotas por litro (4 si está turbia). Revuelve y espera 30 minutos.'),
    GuideStep('O usa el sol', 'Botella plástica transparente llena, al sol directo 6 horas (2 días si está nublado).'),
    GuideStep('Guarda bien', 'En recipientes limpios y tapados, a la sombra. Sirve con un cucharón limpio, sin meter las manos.'),
  ], article: 'agua_purificar'),
  Guide('fuego', 'Necesito fuego', 'Encender y mantener una fogata', Icons.local_fire_department, _orange, [
    GuideStep('Reúne todo antes', 'Yesca (pelusa, algodón, hojas y pasto muy secos), astillas finas y leña de varios grosores. El doble de lo que crees.'),
    GuideStep('Haz una base seca', 'Si el suelo está mojado, pon una cama de palos o corteza. Protege del viento con piedras.'),
    GuideStep('Nido de yesca', 'Forma una bolita con la yesca y enciéndela (fósforo, encendedor, chispa, lupa).'),
    GuideStep('Sopla suave', 'Sopla despacio en la base de la llama y agrega astillas finas en forma de tipi.'),
    GuideStep('Agrega leña poco a poco', 'De lo más delgado a lo más grueso. No ahogues la llama: el fuego necesita aire.'),
    GuideStep('Seguridad', 'Nunca dentro de una carpa o cuarto cerrado: el humo mata sin olor. Apaga con agua y tierra antes de irte.', warn: true),
  ], article: 'fuego_basico'),
  Guide('frio', 'Mucho frío', 'Evitar y tratar la hipotermia', Icons.ac_unit, _blue, [
    GuideStep('Sal del viento y la lluvia', 'Busca o arma un refugio. Lo que más enfría es estar mojado y con viento.'),
    GuideStep('Quita lo mojado', 'Cambia la ropa mojada por seca. El algodón mojado no abriga.'),
    GuideStep('Aíslate del suelo', 'Ramas, hojas secas, cartón o la mochila debajo de ti. El suelo roba calor rapidísimo.'),
    GuideStep('Cubre cabeza y cuello', 'Gorro, bufanda, capucha. Abrázate con otras personas bajo cobijas.'),
    GuideStep('Bebe tibio y dulce', 'Si está consciente: agua tibia con panela. Sin alcohol.'),
    GuideStep('Señales graves', 'Si deja de tiritar estando frío, está confundido o somnoliento: es hipotermia grave. Calor corporal ya, sin frotar.', warn: true),
  ], article: 'aux_temperatura'),
  Guide('perdido', 'Estoy perdido', 'Qué hacer paso a paso', Icons.explore_off, _green, [
    GuideStep('PARA', 'Siéntate y respira. Caminar con miedo te pierde más.'),
    GuideStep('Piensa', '¿De dónde vine? ¿Cuánto caminé? ¿Alguien sabe dónde estoy?'),
    GuideStep('Observa', 'Mira el sol, ríos, caminos, humo, ruidos. Usa la brújula y el GPS de la app (funcionan sin internet).'),
    GuideStep('Decide', 'Si alguien te buscará: quédate y haz señales. Si no: sigue el agua cuesta abajo, los ríos llevan a pueblos.'),
    GuideStep('Haz señales', 'Tres de todo = auxilio: 3 fogatas, 3 silbidos, 3 destellos. Usa el SOS de la app.'),
    GuideStep('Marca el camino', 'Rompe ramas o apila piedras para poder volver.'),
  ], article: 'ori_perdido', tool: 'brujula'),
  Guide('rescate', 'Pedir rescate', 'Que te vean y te oigan', Icons.sos, _yellow, [
    GuideStep('Ubícate', 'Abre la pestaña Mapa y toca "Ubicarme" para tener tus coordenadas. Anótalas.'),
    GuideStep('Luz', 'De noche: SOS con la linterna (3 cortos, 3 largos, 3 cortos). Úsalo desde la herramienta Morse.'),
    GuideStep('Sonido', 'Silbato o golpes: 3 seguidos, pausa, repite. Ahorra la voz.'),
    GuideStep('Señales en el suelo', 'Letras grandes (3 m) con piedras, ramas o ropa: V = necesito ayuda, X = necesito médico.'),
    GuideStep('Humo y espejo', 'De día: humo (pasto verde sobre el fuego) y destellos con un espejo o el celular hacia aviones.'),
    GuideStep('Quédate visible', 'En un claro o lugar alto. Ropa de colores fuertes extendida.'),
  ], article: 'ori_senales', tool: 'sos'),
  Guide('nuclear', 'Alerta nuclear', 'Explosión, accidente o lluvia radiactiva', Icons.warning_amber_rounded, _yellow, [
    GuideStep('No mires el destello', 'Tírate al suelo detrás de algo sólido, boca abajo, cubre cabeza y nuca. Espera a que pase la onda (llega segundos después).'),
    GuideStep('Entra ya', 'Tienes unos 10–20 minutos antes de que caiga el polvo. Entra al edificio más sólido: sótano o centro del edificio.'),
    GuideStep('Quítate la ropa de afuera', 'Métela en una bolsa cerrada. Elimina hasta el 90 % del polvo radiactivo.'),
    GuideStep('Lávate', 'Ducha con jabón y champú, sin acondicionador. Si no hay agua, trapo húmedo de arriba abajo.'),
    GuideStep('Quédate dentro', 'Mínimo 24 horas, mejor 2–3 días. La radiación baja muy rápido (regla 7-10).'),
    GuideStep('Infórmate', 'Radio de pilas. Yoduro de potasio solo si las autoridades lo dicen.'),
    GuideStep('Come y bebe lo cerrado', 'Comida en latas o empaques cerrados, agua embotellada o de la tubería. Limpia las latas antes de abrir.'),
  ], article: 'rad_explosion', tool: 'radiacion'),
  Guide('serpiente', 'Mordedura de serpiente', 'Qué hacer y qué NO', Icons.warning, _purple, [
    GuideStep('Aléjate', 'Retírate de la serpiente. No intentes atraparla ni matarla. Una foto de lejos ayuda.', species: ['mapana', 'cascabel', 'coral']),
    GuideStep('Calma y quietud', 'Acuesta a la persona. Moverse hace que el veneno avance más rápido.'),
    GuideStep('Quita anillos y relojes', 'La zona se va a hinchar.'),
    GuideStep('Inmoviliza', 'Entablilla el brazo o pierna como si fuera una fractura, a la altura del corazón.'),
    GuideStep('Lo que NO se hace', 'No cortar, no chupar, no torniquete, no hielo, no alcohol, no remedios caseros.', warn: true),
    GuideStep('Busca antiveneno', 'Es lo único que cura. Traslado a un hospital lo antes posible, cargándolo si se puede.'),
  ], article: 'aux_mordeduras'),
  Guide('comer', '¿Esto se come?', 'Antes de comer una planta', Icons.eco, _green, [
    GuideStep('Si no estás seguro, NO', 'Muchas plantas mortales se parecen a las comestibles. La duda es suficiente para no comerla.'),
    GuideStep('Busca en la Guía visual', 'Compara con las fotos: hojas, flores, frutos, olor y dónde crece. Deben coincidir varios rasgos.', species: ['guayaba', 'mango', 'borrachero', 'manzanillo']),
    GuideStep('Señales de peligro', 'Savia blanca lechosa, olor a almendra amarga, frutos de colores brillantes que no conoces, hongos (todos).', warn: true),
    GuideStep('Prefiere lo cultivado', 'Frutales de fincas y patios abandonados son mucho más seguros que plantas silvestres.'),
    GuideStep('Insectos y peces', 'Hormigas, grillos, larvas y pescado son proteína segura si se cocinan bien.'),
  ], article: 'pla_reglas', tool: 'atlas'),
  Guide('sismo', 'Terremoto', 'Durante y después', Icons.vibration, _orange, [
    GuideStep('Agáchate, cúbrete, agárrate', 'Bajo una mesa firme o junto a una pared interior, cubriendo cabeza y cuello.'),
    GuideStep('No corras afuera', 'Lejos de ventanas y estantes. No uses ascensores.'),
    GuideStep('Después del temblor', 'Espera réplicas. Sal con cuidado por las escaleras con zapatos puestos.'),
    GuideStep('¿Huele a gas?', 'No prendas nada (ni fósforos ni interruptores). Abre puertas y sal.', warn: true),
    GuideStep('Si quedas atrapado', 'Tápate la boca con tela, golpea tubos o paredes 3 veces, usa silbato. Grita solo si oyes gente cerca.'),
  ], article: 'des_sismo'),
];

List<Guide>? _guidesEnCache, _guidesPtCache;

/// Guías en el idioma actual.
List<Guide> get guides {
  if (isEn) return _guidesEnCache ??= _translated(guidesEnText);
  if (isPt) return _guidesPtCache ??= _translated(guidesPtText);
  return guidesEs;
}

List<Guide> _translated(Map<String, (String, String, List<(String, String)>)> text) {
  return [
    for (final g in guidesEs)
      if (text[g.id] case final t?)
        Guide(
          g.id,
          t.$1,
          t.$2,
          g.icon,
          g.color,
          [
            for (var i = 0; i < g.steps.length; i++)
              GuideStep(
                i < t.$3.length ? t.$3[i].$1 : g.steps[i].title,
                i < t.$3.length ? t.$3[i].$2 : g.steps[i].text,
                warn: g.steps[i].warn,
                species: g.steps[i].species,
              ),
          ],
          article: g.article,
          tool: g.tool,
        )
      else
        g,
  ];
}

Map<String, Guide> get guideById => {for (final g in guides) g.id: g};
