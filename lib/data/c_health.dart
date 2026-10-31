import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// RADIACIÓN Y NUCLEAR
// =====================================================================
const radiacion = Category(
  id: 'radiacion',
  name: 'Radiación y nuclear',
  icon: Icons.warning_amber_rounded,
  summary: 'Bombas, accidentes nucleares, refugio, descontaminación y yoduro.',
  articles: [
    Article('rad_que_es', 'Qué es la radiación (explicado fácil)', r'''
La radiación es energía invisible que sale de materiales radiactivos. No se ve, no huele, no se siente. En grandes dosis daña las células del cuerpo.

## Tres tipos
- Alfa: se frena con una hoja de papel o la piel. Peligrosa solo si la respiras, comes o entra por una herida.
- Beta: atraviesa unos milímetros; la ropa la frena en parte. Puede quemar la piel si el polvo queda encima.
- Gamma: muy penetrante, como los rayos X. Solo la frena mucha masa: tierra, concreto, agua, ladrillo.

## Las 3 defensas
- TIEMPO: menos tiempo expuesto = menos daño. La lluvia radiactiva pierde fuerza muy rápido.
- DISTANCIA: cada vez que duplicas la distancia a la fuente, recibes 4 veces menos.
- BLINDAJE: pon masa entre tú y el exterior. Cuanto más pesada, mejor.

## Unidades
La dosis se mide en Sievert (Sv). Como referencia:
- Una radiografía: 0,0001 Sv.
- 1 Sv de golpe: náuseas, enfermedad leve por radiación.
- 4–5 Sv de golpe: la mitad de las personas mueren sin atención médica.
* Un dosímetro o contador Geiger es la única forma de medirla. Si consigues uno, guárdalo como un tesoro.
'''),
    Article('rad_explosion', 'Si hay una explosión nuclear', r'''
## En el momento del destello
1. NO mires la luz: puede dejarte ciego.
2. Tírate al suelo boca abajo detrás de algo sólido (muro, zanja, bordillo). Cubre cabeza y nuca con los brazos, boca abierta.
3. La onda expansiva llega segundos después (1 segundo por cada 340 m de distancia). Quédate en el suelo hasta que pase el viento y los vidrios.

## Después: ENTRA, QUÉDATE, INFÓRMATE
- Tienes unos 10–20 minutos antes de que caiga el polvo radiactivo (parece arena, ceniza o polvo).
- Entra al edificio más sólido cercano. Ve al sótano o al centro del edificio, lejos de techos y paredes exteriores.
- Quédate dentro mínimo 24 horas, mejor 2–3 días, salvo que las autoridades digan otra cosa.
- Escucha radio de pilas para recibir instrucciones.

! No salgas a buscar a familiares durante las primeras horas: es cuando la radiación es más alta. Acordad antes un punto de encuentro.
* Usa la herramienta "Radiación" para calcular cuánto ha bajado la radiación.
'''),
    Article('rad_refugio', 'Refugio contra lluvia radiactiva', r'''
## Qué protege más
Lo que importa es la masa entre tú y el polvo radiactivo (en el techo y el suelo de afuera).

Espesor que reduce la radiación a la MITAD:
- Acero: 1,8 cm
- Concreto: 6 cm
- Tierra apisonada: 9 cm
- Agua: 18 cm
- Madera: 22 cm
Con 10 de esos espesores (por ejemplo 90 cm de tierra), la radiación baja unas 1.000 veces.

## Mejores lugares
- Sótanos, túneles, parqueaderos subterráneos, estaciones de metro.
- El centro de un edificio grande de concreto, pisos intermedios.
- Una zanja cubierta con puertas o tablas y 60–90 cm de tierra encima.

## Mejora un refugio improvisado
- Pon cajas de libros, tierra, agua en garrafas o muebles pesados contra paredes y encima de una mesa donde te refugies.
- Ventilación: el aire se puede mover con un abanico; el polvo radiactivo es pesado y casi no entra si cierras y tapas rendijas.
- Agua: 4 L por persona al día; letrina de balde con bolsas y tapa.
'''),
    Article('rad_descontaminar', 'Descontaminación personal', r'''
Si estuviste afuera cuando caía el polvo:
1. Antes de entrar, quítate la ropa exterior: elimina hasta el 90 % de la contaminación. Métela en una bolsa cerrada lejos de las personas.
2. Dúchate con agua y jabón; lava el pelo con champú. NO uses acondicionador: pega el polvo al pelo.
3. No frotes fuerte ni rasques la piel.
4. Suénate la nariz, limpia orejas, párpados y uñas.
5. Si no hay ducha: limpia la piel con un trapo húmedo, de arriba hacia abajo, cambiando de parte limpia.
6. Ropa limpia que haya estado guardada.
7. Limpia a las mascotas con agua y jabón usando guantes.

! Una herida contaminada se lava con abundante agua antes de cubrirla.
'''),
    Article('rad_comida', 'Agua y comida después de la lluvia radiactiva', r'''
## Seguro
- Comida enlatada, en frascos, bolsas cerradas, nevera o despensa cerrada.
- Limpia el exterior de latas y frascos antes de abrirlos.
- Agua embotellada, del tanque cubierto o de la tubería del edificio (llena recipientes al inicio).

## Con cuidado
- Frutas y verduras del exterior: lávalas y pélalas; quita las hojas de afuera.
- Agua de ríos y lagos: déjala reposar para que el polvo se asiente, toma la de arriba y fíltrala por tierra o arena. Hervir NO elimina la radiactividad.
- Leche de animales que comieron pasto contaminado: evítala las primeras semanas (yodo radiactivo).

! El agua de pozo profundo es de las más seguras porque la tierra filtra el polvo.
'''),
    Article('rad_yoduro', 'Yoduro de potasio (KI)', r'''
Protege SOLO la tiroides contra el yodo radiactivo (típico de accidentes de centrales nucleares). No protege contra el resto de la radiación.

## Cuándo
Solo si las autoridades lo indican, idealmente antes o justo después de la exposición. Una dosis protege unas 24 horas.

## Dosis de referencia (comprimidos de yoduro de potasio)
- Adultos: 130 mg.
- Niños de 3 a 18 años: 65 mg (adolescentes de más de 68 kg: 130 mg).
- Niños de 1 mes a 3 años: 32 mg.
- Bebés menores de 1 mes: 16 mg.

! NO tomes sal yodada, tintura de yodo ni yodo povidona: no sirven y pueden intoxicar.
! Los mayores de 40 años solo lo necesitan ante exposiciones muy altas. Personas con problemas de tiroides o alergia al yodo: consultar.
'''),
    Article('rad_enfermedad', 'Enfermedad por radiación', r'''
## Síntomas
- Náuseas y vómito en las primeras horas: cuanto antes empiezan, mayor fue la dosis.
- Luego puede haber días en que la persona "parece" mejorar.
- Después: caída del pelo, sangrado de encías, moretones, infecciones, diarrea.

## Cuidados posibles sin hospital
- Mucho líquido con sales (suero oral).
- Higiene extrema: manos, comida y agua limpias. Las defensas bajan y cualquier infección es grave.
- Reposo y comida blanda nutritiva.
- Separar a la persona de quien tenga infecciones.

* La enfermedad por radiación no se contagia. Cuidar a alguien enfermo es seguro si ya se descontaminó.
'''),
    Article('rad_central', 'Accidente en central nuclear y pulso electromagnético', r'''
## Accidente en una central
- Si estás dentro de la zona indicada por las autoridades: refúgiate dentro o evacúa en la dirección que digan, perpendicular al viento.
- Cierra ventanas y apaga ventilación.
- Yoduro de potasio solo si lo indican.

## Pulso electromagnético (EMP)
Una explosión nuclear en lo alto de la atmósfera puede dañar aparatos electrónicos en una zona enorme.
- Guarda una radio pequeña, linterna y una batería externa dentro de una caja metálica cerrada (una lata o caja de galletas), envueltos en tela o cartón para que no toquen el metal: es una "jaula de Faraday".
- Los aparatos desconectados y apagados tienen más probabilidad de sobrevivir.
- Ten mapas, manuales y libros en papel.
'''),
  ],
  quiz: [
    Question('Las tres defensas contra la radiación son:',
        ['Tiempo, distancia y blindaje', 'Agua, sal y yodo', 'Correr, gritar y saltar', 'Pastillas, guantes y gafas'], 0,
        'Menos tiempo, más distancia y más masa entre tú y la fuente.'),
    Question('Tras una explosión nuclear, lo mejor es:',
        ['Salir a ver qué pasó', 'Entrar a un edificio sólido y quedarse 24 h o más', 'Ir al río', 'Subir a la azotea'], 1,
        'Entra, quédate dentro, infórmate.'),
    Question('Según la regla 7-10, a las 7 horas la radiación es...',
        ['Igual', '10 veces menor que a la hora 1', 'El doble', '7 veces mayor'], 1,
        'Cada vez que el tiempo se multiplica por 7, baja 10 veces.'),
    Question('¿Hervir el agua elimina la radiactividad?',
        ['Sí', 'No', 'Solo con sal', 'Solo de noche'], 1,
        'Hervir mata microbios pero no elimina partículas radiactivas; se dejan asentar y se filtra.'),
    Question('Al entrar al refugio después de estar afuera:',
        ['Quitar ropa exterior y lavarse con champú sin acondicionador', 'Echarse acondicionador', 'Dormir así', 'Rascarse la piel fuerte'], 0,
        'Quitar la ropa exterior elimina hasta el 90 % de la contaminación.'),
    Question('El yoduro de potasio protege...',
        ['Todo el cuerpo', 'Solo la tiroides', 'Los pulmones', 'La piel'], 1,
        'Solo bloquea el yodo radiactivo en la tiroides.'),
    Question('¿Cuál material blinda más por centímetro?',
        ['Madera', 'Agua', 'Concreto', 'Tela'], 2,
        'Concreto: 6 cm reducen a la mitad; la madera necesita 22 cm.'),
  ],
);

// =====================================================================
// MEDICINA NATURAL
// =====================================================================
const medicinaNatural = Category(
  id: 'medicina_natural',
  name: 'Plantas medicinales',
  icon: Icons.spa_outlined,
  summary: 'Qué plantas recoger, para qué sirven y cómo prepararlas.',
  articles: [
    Article('med_reglas', 'Antes de usar una planta medicinal', r'''
! Las plantas medicinales SÍ tienen efectos y también pueden intoxicar. Úsalas para molestias leves; las enfermedades graves necesitan medicina.

- Identifica la planta con seguridad: mira la foto, las hojas, flores, olor y dónde crece. Si dudas, no la uses.
- Recoge lejos de carreteras, basureros, minas y cultivos fumigados.
- Empieza con poca cantidad y observa 24 horas.
- Una sola planta a la vez: así sabes cuál funciona o cuál hizo daño.
- Embarazadas, bebés, niños pequeños y personas con enfermedades del hígado o riñón: evita los remedios o usa los más suaves (manzanilla, hierbabuena) en poca cantidad.
- Suspende si aparece sarpullido, vómito, mareo o dolor.
'''),
    Article('med_preparar', 'Cómo preparar remedios', r'''
## Infusión (té) — hojas y flores
1 cucharada de planta seca (o 2 de fresca) por taza de agua recién hervida. Tapa 5–10 minutos y cuela. Máximo 3 tazas al día.
@ manzanilla, hierbabuena, toronjil, cidron

## Cocimiento (decocción) — raíces, cortezas y semillas
Hierve 10–20 minutos a fuego bajo con la olla tapada. Cuela.
@ jengibre, una_gato

## Compresa
Moja un trapo limpio en una infusión tibia y ponlo sobre la zona (golpes, inflamación, ojos irritados).

## Cataplasma (emplasto)
Machaca la planta fresca hasta hacer una pasta, ponla sobre la piel y cubre con un trapo. Para picaduras, raspones y granos.
@ llanten, sabila, calendula

## Vapores
Hierve hojas aromáticas, cúbrete la cabeza con una toalla y respira el vapor a distancia segura. Para la congestión.
@ eucalipto, tomillo

## Gárgaras
Infusión tibia con una pizca de sal, varias veces al día, para la garganta.
@ malva, manzanilla

## Ungüento casero
Calienta a fuego muy bajo 1 taza de aceite con un puñado de planta seca 1–2 horas, cuela, añade 2 cucharadas de cera de abejas derretida y deja enfriar.

## Secar y guardar
- Recoge en la mañana, después de que se seque el rocío.
- Seca a la sombra en manojos colgados, en lugar ventilado, 1–2 semanas.
- Guarda en frascos cerrados con etiqueta (planta y fecha). Duran aproximadamente un año.
'''),
    Article('med_botiquin', 'Botiquín verde: qué planta para qué', r'''
## Diarrea
Primero suero oral. Té de hojas de guayaba (un puñado de hojas tiernas hervidas 10 min).
@ guayaba

## Náuseas y mareo
@ jengibre, hierbabuena

## Gases, cólicos y digestión pesada
@ manzanilla, hierbabuena, cidron, prontoalivio, albahaca

## Tos y dolor de garganta
Té de tomillo o flores de saúco con miel; gárgaras de malva.
@ tomillo, sauco, malva, eucalipto

## Heridas pequeñas y raspones
Lava primero. Luego sangre de drago, caléndula o llantén.
@ sangre_drago, calendula, llanten

## Quemaduras leves y quemaduras de sol
@ sabila

## Golpes y moretones (piel sin heridas)
@ arnica

## Nervios, ansiedad e insomnio
@ valeriana, toronjil, manzanilla, cidron

## Picaduras de insectos
@ llanten, sabila

## Dolor de articulaciones e inflamación
@ una_gato, jengibre

## Repeler insectos
@ limoncillo, achiote, albahaca

! Fiebre alta que no baja, sangre en heces, dificultad para respirar, confusión o heridas infectadas necesitan medicinas y atención médica.
'''),
    Article('med_peligrosas', 'Remedios tradicionales peligrosos', r'''
Algunas plantas se usan en la medicina popular pero pueden intoxicar gravemente.
@ ruda, paico, quina, cola_caballo, matarraton

- Ruda: se usa para "limpias" y cólicos, pero puede causar aborto, daño al hígado y quemaduras en la piel con el sol. Nunca en embarazo.
- Paico: tradicional contra los parásitos; su aceite es tóxico y ha causado muertes, sobre todo en niños.
- Quina: su corteza dio la quinina contra la malaria, pero en exceso causa sordera, problemas del corazón y la vista. Solo si no hay otra opción y con dosis prudente.
- Cola de caballo: diurética; no la uses por semanas seguidas.
- Matarratón: tradicional en baños para la fiebre; solo uso externo.
- Borrachero, higuerilla y dieffenbachia: nunca como remedio.
'''),
  ],
  quiz: [
    Question('¿Cómo se prepara una infusión?',
        ['Hervir la planta 1 hora', 'Agua recién hervida sobre la planta, tapar 5–10 min', 'Planta en agua fría', 'Quemar la planta'], 1,
        'Hojas y flores se preparan en infusión; raíces y cortezas en cocimiento.'),
    Question('Para quemaduras leves se usa el gel de:',
        ['Ruda', 'Sábila', 'Paico', 'Higuerilla'], 1,
        'El gel interno de la sábila calma la piel.'),
    Question('La árnica se usa...',
        ['Tomada en té', 'Solo por fuera en golpes sin herida', 'En los ojos', 'En heridas abiertas'], 1,
        'La árnica es tóxica si se ingiere.'),
    Question('¿Qué planta tradicional NO debe usar una embarazada?',
        ['Ruda', 'Manzanilla en poca cantidad', 'Sábila en la piel', 'Llantén en cataplasma'], 0,
        'La ruda puede provocar aborto e intoxicación.'),
    Question('Para la diarrea, además del suero oral, se usa té de hojas de...',
        ['Guayaba', 'Higuerilla', 'Borrachero', 'Adelfa'], 0,
        'Las hojas de guayaba son astringentes.'),
    Question('¿Dónde NO debes recoger plantas medicinales?',
        ['En tu huerta', 'Junto a carreteras y cultivos fumigados', 'En el monte limpio', 'En tu patio'], 1,
        'Absorben humo, metales y pesticidas.'),
  ],
);
