import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// ORIENTACIÓN Y SEÑALES
// =====================================================================
const orientacion = Category(
  id: 'orientacion',
  name: 'Orientación y señales',
  icon: Icons.explore_outlined,
  summary: 'Ubicarte sin GPS y pedir rescate.',
  articles: [
    Article('ori_sol', 'Orientarse con el sol y las estrellas', r'''
## El sol
- Sale aproximadamente por el Este y se pone por el Oeste.
- En Colombia (cerca del ecuador) al mediodía el sol está casi encima de ti; usa la mañana o la tarde para orientarte.

## Método de la sombra (el más confiable)
1. Clava un palo recto en el suelo.
2. Marca la punta de la sombra con una piedra.
3. Espera 15–20 minutos y marca la nueva punta.
4. La línea de la primera marca a la segunda apunta de Oeste a Este.

## De noche
- Hemisferio norte: la estrella Polar marca el Norte (en Colombia se ve muy baja sobre el horizonte).
- Cruz del Sur: prolonga 4,5 veces el eje largo de la cruz; desde ahí baja al horizonte: es el Sur.
- Orión: la estrella de la espada sale casi exactamente por el Este.

## Calcular horas de luz
Estira el brazo, mano horizontal bajo el sol: cada dedo entre el sol y el horizonte ≈ 15 minutos de luz.
'''),
    Article('ori_brujula', 'Usar brújula y coordenadas', r'''
## Brújula
- Aléjala de metales, imanes y del celular cargando.
- La aguja (o la app) marca el Norte magnético; en Colombia la diferencia con el Norte real es pequeña.
- Para caminar en línea recta: elige un rumbo, fija un punto visible en esa dirección (árbol, roca), camina hasta él, repite.

## Coordenadas GPS
- Latitud: Norte/Sur del ecuador (Colombia: entre −4° y 13°).
- Longitud: Este/Oeste (Colombia: aprox. −67° a −79°).
- 0,001° ≈ 111 metros.

* La pestaña Mapa de esta app guarda puntos (agua, refugio, peligro) y te guía hacia ellos con brújula, sin internet.
'''),
    Article('ori_perdido', 'Si estás perdido: S.T.O.P.', r'''
- S – Siéntate: detente. Caminar en pánico empeora todo.
- T – Piensa: ¿de dónde vine? ¿cuánto tiempo caminé?
- O – Observa: terreno, agua, sol, recursos, peligros.
- P – Planea: decide quedarte o moverte.

## Quedarse o moverse
- Si alguien sabe dónde estás, quédate y haz señales.
- Si debes moverte: sigue el agua cuesta abajo; los ríos llevan a poblaciones.
- Marca tu camino (ramas quebradas, piedras apiladas) para poder volver.
'''),
    Article('ori_senales', 'Señales de rescate', r'''
## Número tres = auxilio
Tres fogatas en triángulo, tres silbidos, tres disparos, tres destellos.

## SOS en código Morse
· · · — — — · · ·  (3 cortos, 3 largos, 3 cortos). Úsalo con linterna, espejo, golpes o silbato. La app tiene SOS con flash.

## Señales tierra–aire (hazlas grandes, mínimo 3 m, con contraste)
- V: necesito ayuda.
- X: necesito asistencia médica.
- Flecha →: voy en esta dirección.
- N: no / negativo.  Y: sí / afirmativo.

## Espejo de señales
Refleja el sol hacia un avión o barco: se ve a decenas de kilómetros. Apunta extendiendo tu otra mano con dos dedos en V y pon el destello entre ellos.

## Humo
- Día: humo blanco (pasto verde sobre fuego) sobre fondo oscuro.
- Humo negro (caucho, aceite) sobre fondo claro o nieve.
- De noche: fuego brillante.
'''),
    Article('ori_morse', 'Código Morse', r'''
Unidad: punto = 1, raya = 3, espacio entre señales = 1, entre letras = 3, entre palabras = 7.

- A ·—   B —···   C —·—·   D —··
- E ·   F ··—·   G ——·   H ····
- I ··   J ·———   K —·—   L ·—··
- M ——   N —·   O ———   P ·——·
- Q ——·—   R ·—·   S ···   T —
- U ··—   V ···—   W ·——   X —··—
- Y —·——   Z ——··
- 1 ·————   2 ··———   3 ···——   4 ····—   5 ·····
- 6 —····   7 ——···   8 ———··   9 ————·   0 —————

* Usa el traductor Morse de Herramientas para enviar cualquier mensaje con la linterna.
'''),
  ],
  quiz: [
    Question('El SOS en Morse es:',
        ['3 largos, 3 cortos, 3 largos', '3 cortos, 3 largos, 3 cortos', '1 largo', '5 cortos'], 1,
        '· · · — — — · · ·'),
    Question('Con el método de la sombra, la primera marca indica el...',
        ['Este', 'Norte', 'Oeste', 'Sur'], 2,
        'El sol se mueve al Oeste, así que la sombra se mueve al Este: la primera marca es Oeste.'),
    Question('Una gran X en el suelo para un avión significa:',
        ['Todo bien', 'Necesito asistencia médica', 'Voy hacia allá', 'Sí'], 1,
        'V = ayuda, X = asistencia médica.'),
    Question('Perdido en el monte y nadie sabe dónde estás. ¿Qué seguir?',
        ['Subir siempre', 'El agua cuesta abajo', 'Caminar de noche', 'Ir en círculos'], 1,
        'Ríos y quebradas suelen llevar a poblaciones.'),
    Question('Cada dedo entre el sol y el horizonte equivale a unos...',
        ['5 min', '15 min', '1 hora', '2 horas'], 1,
        'Aproximadamente 15 minutos de luz por dedo.'),
  ],
);

// =====================================================================
// NUDOS Y HERRAMIENTAS
// =====================================================================
const nudos = Category(
  id: 'nudos',
  name: 'Nudos y herramientas',
  icon: Icons.handyman_outlined,
  summary: 'Nudos esenciales, cuchillo, cuerda y mochila.',
  articles: [
    Article('nud_esenciales', 'Los 6 nudos esenciales', r'''
## As de guía (bowline)
Lazo fijo que no se cierra ni se suelta. Para rescate, amarrar a un árbol, atarse a la cintura.
"El conejo sale del hoyo, rodea el árbol y vuelve al hoyo": haz un ojo pequeño, pasa la punta de abajo hacia arriba, rodea la cuerda principal por detrás y vuelve a bajar por el ojo.

## Ballestrinque
Amarrar rápido a un poste. Dos vueltas cruzadas, la segunda pasa bajo sí misma.

## Nudo llano (rizo)
Unir dos cuerdas del mismo grosor y vendas. Derecha sobre izquierda, luego izquierda sobre derecha.

## Vuelta de tensión ajustable (Taut-line)
Para tensar cuerdas de carpa y lona; se desliza para ajustar pero aguanta con carga.

## Ocho
Tope al final de la cuerda para que no se salga de un agujero. Base de los nudos de escalada.

## Nudo de leñador (timber hitch)
Arrastrar troncos. Rodea, enrolla la punta sobre sí misma 3 veces. Se suelta fácil.

* Practica cada nudo con los ojos cerrados: en una emergencia puede ser de noche o con frío.
'''),
    Article('nud_mochila', 'Mochila de 72 horas', r'''
Una mochila lista para salir en minutos.

- Agua: 3 litros por persona + método de purificación.
- Comida: 3 días de alimentos que no requieran cocción (barras, maní, atún, panela).
- Linterna frontal + pilas, o linterna de dinamo.
- Encendedor, fósforos en bolsa hermética, ferrocerio.
- Navaja multiuso.
- Botiquín y medicamentos personales.
- Manta térmica, poncho o lona, cuerda (15 m).
- Muda de ropa, medias, gorro.
- Silbato.
- Copias de documentos en bolsa plástica, efectivo en billetes pequeños.
- Batería externa cargada, radio de pilas o dinamo.
- Libreta, lápiz, mapa en papel de tu zona.
- Higiene: jabón, cepillo, papel, toallas higiénicas, tapabocas.

* Usa la lista de verificación de Inventario para revisar tu mochila.
'''),
    Article('nud_cuchillo', 'Cuchillo y hacha: uso seguro', r'''
- Corta siempre alejándote del cuerpo; nada delante de la hoja ("triángulo de sangre": muslos interiores e ingle).
- Un cuchillo afilado es más seguro que uno sin filo: resbala menos.
- Afila con una piedra lisa húmeda en ángulo de unos 20°, mismo número de pasadas por cada lado.
- Hacha: separa bien los pies, golpea con el tronco sobre otro tronco, nunca sobre el suelo hacia tus pies.
- Guárdalo enfundado y seco; aceita la hoja para evitar óxido.
'''),
  ],
  quiz: [
    Question('El nudo que forma un lazo fijo para rescate es:',
        ['Llano', 'As de guía', 'Ocho', 'Ballestrinque'], 1,
        'El as de guía no se cierra ni se suelta con carga.'),
    Question('¿Cuánta agua lleva la mochila de 72 h por persona?',
        ['1 vaso', '3 litros mínimo', '20 litros', 'Nada'], 1,
        'Unos 3 litros más un método para purificar.'),
    Question('¿Un cuchillo sin filo es más seguro?',
        ['Sí', 'No, resbala más y se fuerza más', 'Igual', 'Depende del color'], 1,
        'Un filo bueno exige menos fuerza y resbala menos.'),
  ],
);

// =====================================================================
// DESASTRES Y PELIGROS
// =====================================================================
const desastres = Category(
  id: 'desastres',
  name: 'Desastres y peligros',
  icon: Icons.warning_amber_outlined,
  summary: 'Sismos, inundaciones, volcanes, epidemias y seguridad.',
  articles: [
    Article('des_sismo', 'Terremoto', r'''
Colombia está en zona de alto riesgo sísmico.

## Durante
- AGÁCHATE, CÚBRETE y AGÁRRATE: bajo una mesa firme, o pegado a una pared interior cubriendo cabeza y cuello.
- Lejos de ventanas, estantes y objetos que caigan.
- No corras hacia la calle durante el sacudón ni uses ascensores.
- Si estás afuera: aléjate de edificios, postes y cables.

## Después
- Espera réplicas.
- Revisa olor a gas: si hueles, no prendas nada, abre y sal.
- Corta la luz y el gas si puedes.
- Si quedas atrapado: tápate la boca, golpea tubos o paredes (tres golpes), usa silbato; grita solo si es necesario para ahorrar energía.
'''),
    Article('des_inundacion', 'Inundaciones y avalanchas', r'''
- Sube a zonas altas de inmediato. No esperes a que el agua llegue.
- 15 cm de agua corriendo pueden tumbarte; 60 cm pueden arrastrar un carro.
- No cruces ríos crecidos. Si debes cruzar un río: en el tramo más ancho y lento, de frente a la corriente en diagonal, con un palo como tercer apoyo, mochila suelta de la cintura.
- Escucha: un rugido fuerte río arriba o agua turbia con troncos puede anunciar una avalancha (como Armero y Mocoa). Sube lateralmente, no río abajo.
- El agua de inundación está contaminada: no la bebas sin purificar.
'''),
    Article('des_volcan', 'Erupción volcánica y ceniza', r'''
- Aléjate de los cauces de ríos que bajan del volcán: los lahares (flujos de lodo) viajan muy rápido.
- Protege tu respiración: tapabocas N95 o tela húmeda.
- Gafas cerradas para los ojos.
- Limpia la ceniza de los techos: pesa mucho y los derrumba.
- Cubre los tanques de agua.
'''),
    Article('des_epidemia', 'Epidemias y cuarentena', r'''
- Lavado de manos con jabón 20 segundos: la medida más efectiva.
- Aísla a los enfermos en un espacio aparte, con una sola persona cuidándolos.
- Tapabocas para el enfermo y el cuidador.
- Utensilios separados; lava ropa y platos con agua caliente y jabón.
- Entierra o quema excrementos y residuos lejos (mínimo 30 m) del agua.
- Cuarentena: quien llega de fuera espera 14 días separado del grupo si hay una enfermedad contagiosa activa.
'''),
    Article('des_nuclear', 'Accidente nuclear o químico', r'''
## Radiación / explosión
- Entra a un edificio sólido, al centro y en el sótano si hay: lejos de techos y paredes externas.
- Quédate dentro mínimo 24 horas: la radiación del polvo radiactivo cae rápido en los primeros días.
- Al entrar: quítate la ropa exterior (elimina gran parte del polvo), métela en una bolsa y lávate con agua y jabón; no uses acondicionador.
- Agua y comida en recipientes cerrados son seguras.

## Químico
- Sube a pisos altos (muchos gases pesan más que el aire).
- Cierra ventanas, apaga ventilación, sella rendijas con tela húmeda y cinta.
'''),
    Article('des_seguridad', 'Seguridad personal y del grupo', r'''
- Discreción: no muestres tus provisiones; mucha gente desesperada puede volverse peligrosa.
- Luz y humo delatan tu posición de noche: cubre ventanas.
- Muévete en grupo; acuerda señales y puntos de encuentro.
- Turnos de guardia por la noche: 2 horas por persona.
- Acordad palabras clave para reconocerse.
- Evita conflictos: negociar y retirarse casi siempre es mejor que pelear. Una herida sin médico puede ser fatal.
'''),
  ],
  quiz: [
    Question('Durante un terremoto debes:',
        ['Correr a la calle', 'Agacharte, cubrirte y agarrarte', 'Usar el ascensor', 'Pararte junto a una ventana'], 1,
        'Correr durante el sacudón causa muchas lesiones por caídas de objetos.'),
    Question('¿Cuánta agua corriendo puede tumbar a una persona?',
        ['2 metros', '15 cm', '1 metro', '5 cm nunca'], 1,
        'Unos 15 cm de agua rápida pueden derribarte.'),
    Question('Tras una lluvia radiactiva, ¿qué hacer al entrar a casa?',
        ['Nada', 'Quitar la ropa exterior y lavarse', 'Abrir ventanas', 'Ir al techo'], 1,
        'Gran parte de la contaminación queda en la ropa exterior.'),
    Question('Ante gases químicos conviene...',
        ['Ir al sótano', 'Subir a pisos altos y sellar', 'Salir a correr', 'Abrir ventanas'], 1,
        'Muchos gases tóxicos son más pesados que el aire.'),
  ],
);
