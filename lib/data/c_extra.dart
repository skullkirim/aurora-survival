import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// ANIMALES
// =====================================================================
const animales = Category(
  id: 'animales',
  name: 'Animales',
  icon: Icons.pets_outlined,
  summary: 'Animales peligrosos, enfermedades que transmiten y fauna útil.',
  articles: [
    Article('ani_serpientes', 'Serpientes venenosas de Colombia', r'''
Colombia tiene más de 50 especies de serpientes venenosas. La mayoría de mordeduras ocurren en el campo, de noche, al pisar o meter las manos sin mirar.
@ mapana, cascabel, coral, verrugosa

## Pistas (no infalibles)
- Víboras (mapaná, cascabel, verrugosa): cabeza triangular más ancha que el cuello, pupila vertical, una fosita entre el ojo y la nariz.
- Corales: pequeñas, anillos de colores vivos, cabeza redonda. Muy venenosas aunque parezcan inofensivas.
! Trata a TODA serpiente desconocida como venenosa. No intentes matarla: la mayoría de mordeduras ocurren así.

## Prevención
- Botas altas, pantalón largo y linterna de noche.
- Mira dónde pisas y dónde pones las manos (leña, huecos, piedras).
- Mantén el pasto corto y sin basura alrededor de la casa: atrae ratones y estos a las serpientes.
- Golpea el suelo con un palo al caminar en pasto alto.
'''),
    Article('ani_aracnidos', 'Arañas, alacranes e insectos peligrosos', r'''
@ viuda_negra, alacran, arana_bananera, lonomia, hormiga_conga, abeja_africanizada

## Reglas generales
- Sacude ropa, zapatos, cobijas y toallas antes de usarlos.
- Usa guantes al mover leña, piedras, tejas o escombros.
- No toques orugas peludas o con espinas.
- Mantén la cama separada de la pared.

## Si te pican
- Lava con agua y jabón.
- Frío local para el dolor.
- Vigila 24 horas: dificultad para respirar, sudor intenso, vómito o sangrado son señales de alarma.
'''),
    Article('ani_enfermedades', 'Enfermedades que transmiten los animales', r'''
Después de un desastre, las enfermedades transmitidas por animales matan más que los propios animales.
@ aedes, pito, vampiro

## Zancudos (dengue, malaria, zika)
- Elimina el agua quieta: tapa tanques, voltea recipientes, cambia el agua de bebederos cada 3 días.
- Toldillo de noche; ropa larga al amanecer y atardecer.

## Ratas (leptospirosis)
- Se transmite por orina de rata en agua de inundaciones y charcos.
- Usa botas en el agua; guarda comida en recipientes cerrados; caza o ahuyenta ratas.
! Fiebre alta, dolor fuerte en las pantorrillas y ojos rojos después de caminar en agua de inundación: puede ser leptospirosis.

## Rabia
- Perros, gatos, murciélagos y zorros pueden transmitirla.
- Toda mordedura: lava 15 minutos con agua y jabón a chorro. Es la medida más importante.
! Un animal que actúa raro (agresivo sin razón, babea, no puede tragar, muy manso siendo salvaje) puede tener rabia. Aléjate.

## Parásitos
- Cocina bien toda la carne y el pescado.
- Camina con calzado: muchos parásitos entran por los pies descalzos.
'''),
    Article('ani_grandes', 'Animales grandes y perros ferales', r'''
@ jaguar, caiman, raya

## Perros sin dueño (el peligro más común)
- En un colapso, los perros abandonados forman jaurías.
- No corras: activa su instinto de persecución.
- Ponte de lado, sin mirarlos fijo a los ojos, y retrocede despacio.
- Ten un palo o algo entre tú y ellos. Sube a un lugar alto si atacan.
- Protege cuello y cara con el brazo envuelto en ropa.

## Ganado
- Toros y vacas con terneros pueden embestir. No cruces potreros con ellos.

## En ríos y ciénagas
- Arrastra los pies para espantar rayas.
- Evita aguas turbias y quietas al anochecer (babillas).
'''),
    Article('ani_caza', 'Proteína animal sostenible', r'''
@ gallina, cuy, conejo, tilapia, chiguiro, iguana

- Criar es más seguro y rinde más que cazar: gallinas, cuyes, conejos y peces en estanque.
- Los animales pequeños se reproducen rápido y comen sobras y pasto.
- La pesca con líneas de fondo y nasas trabaja sola mientras haces otras tareas.

## Limpiar un animal pequeño
1. Desangra cortando el cuello, colgado cabeza abajo.
2. Retira piel o plumas (agua caliente ayuda a desplumar).
3. Abre el vientre sin perforar los intestinos y retira las vísceras.
4. Guarda corazón e hígado sanos (rojos, firmes, sin manchas).
5. Lava con agua limpia y cocina bien.

! Un hígado con manchas blancas o quistes indica enfermedad: bota el animal completo.
* Las vísceras y la sangre sirven de carnada para pescar o como abono enterradas.
'''),
  ],
  quiz: [
    Question('¿Qué hacer con una serpiente desconocida?',
        ['Matarla', 'Tratarla como venenosa y alejarse', 'Atraparla', 'Seguirla'], 1,
        'Muchas mordeduras ocurren al intentar matar o atrapar la serpiente.'),
    Question('Las corales en Colombia...',
        ['Son inofensivas', 'Se distinguen por la regla de colores', 'Son muy venenosas', 'Solo viven en el mar'], 2,
        'Su veneno puede paralizar la respiración; la regla de los colores no sirve aquí.'),
    Question('La leptospirosis se transmite principalmente por...',
        ['Picadura de abeja', 'Orina de rata en agua', 'Comer fruta', 'El sol'], 1,
        'Agua de inundación contaminada con orina de ratas.'),
    Question('Ante una mordedura de perro o murciélago, lo primero es:',
        ['Lavar 15 minutos con agua y jabón', 'Ponerle hielo', 'Quemar la herida', 'Nada'], 0,
        'El lavado a chorro reduce mucho el riesgo de rabia.'),
    Question('Si te ataca un enjambre de abejas africanizadas:',
        ['Saltar al agua', 'Correr a un lugar cerrado cubriendo la cara', 'Quedarse quieto', 'Golpearlas'], 1,
        'Te esperan sobre el agua; correr a un refugio cerrado es lo mejor.'),
    Question('Al cruzar un río con rayas conviene...',
        ['Saltar', 'Arrastrar los pies', 'Ir descalzo', 'Correr'], 1,
        'Arrastrar los pies las espanta en lugar de pisarlas.'),
  ],
);

// =====================================================================
// COMUNICACIÓN
// =====================================================================
const comunicacion = Category(
  id: 'comunicacion',
  name: 'Comunicación y radio',
  icon: Icons.settings_input_antenna,
  summary: 'Radios, alfabeto fonético, mensajes y señales en grupo.',
  articles: [
    Article('com_radio', 'Radios para emergencias', r'''
## Recibir información
- Una radio AM/FM de pilas, solar o de manivela es lo más importante: las emisoras locales informan sobre albergues, agua y peligros.
- AM llega más lejos de noche.

## Hablar con otros
- Walkie-talkies (radios PMR/FRS): fáciles, alcance de 1–5 km en terreno abierto, menos en ciudad o montaña.
- Radios de radioaficionado (VHF/UHF y HF): alcance de decenas a miles de km; en emergencias los radioaficionados forman redes de ayuda.

## Aumentar alcance
- Ponte en un lugar alto y despejado.
- Antena vertical y lejos de metal.
- Habla corto, claro, cerca del micrófono sin gritar.

## Protocolo
- Escucha antes de hablar. Di a quién llamas y quién eres: "Base, aquí Patrulla Uno, cambio".
- "Cambio" = terminé, te toca. "Fuera" = terminé la comunicación.
- Horarios fijos de contacto (por ejemplo cada hora en punto 5 minutos) ahorran batería.
'''),
    Article('com_fonetico', 'Alfabeto fonético y mensajes claros', r'''
Para deletrear nombres o coordenadas sin errores:
- A Alfa · B Bravo · C Charlie · D Delta · E Eco · F Foxtrot
- G Golf · H Hotel · I India · J Juliet · K Kilo · L Lima
- M Mike · N November · O Óscar · P Papa · Q Quebec · R Romeo
- S Sierra · T Tango · U Uniform · V Víctor · W Whiskey
- X X-ray · Y Yankee · Z Zulu

## Mensaje de emergencia (formato corto)
1. Quién eres y cuántas personas son.
2. Dónde estás (coordenadas de la pestaña Mapa, o lugar conocido).
3. Qué pasa (heridos, agua, peligro).
4. Qué necesitas.
5. Qué vas a hacer y cuándo vuelves a llamar.

* Para la emergencia internacional en radio: "MAYDAY, MAYDAY, MAYDAY" (peligro de vida). "PAN-PAN" para urgencias sin peligro inmediato.
'''),
    Article('com_grupo', 'Coordinación del grupo sin señal', r'''
- Acuerda un punto de encuentro principal y otro alternativo antes de que pase algo.
- Plan de familia escrito: teléfonos en papel, contacto en otra ciudad, puntos de encuentro.
- Deja notas visibles con fecha y hora: "Estamos bien, fuimos a X, 29/10 15:00".
- Marcas en la puerta tras revisar una casa (sistema de rescate): una X con fecha arriba, equipo a la izquierda, peligros a la derecha y número de víctimas abajo.
- Silbato: 1 = ¿dónde estás? / atención, 2 = ven aquí, 3 = auxilio.
- Señas con brazos para distancia: brazos en "Y" = sí / necesito ayuda, un brazo arriba y otro abajo = no.
'''),
  ],
  quiz: [
    Question('El aparato más importante para recibir información en un desastre es:',
        ['Televisor', 'Radio AM/FM de pilas o manivela', 'Consola', 'Impresora'], 1,
        'Funciona sin red eléctrica ni internet.'),
    Question('En radio, "cambio" significa...',
        ['Terminé, te toca hablar', 'Cambiar de canal', 'Fin de la comunicación', 'Ayuda'], 0,
        '"Fuera" es terminar la comunicación.'),
    Question('Tres pitazos de silbato significan...',
        ['Todo bien', 'Ven aquí', 'Auxilio', 'Comida lista'], 2,
        'El número tres es la señal universal de auxilio.'),
    Question('La palabra "MAYDAY" se usa cuando...',
        ['Hay peligro de vida', 'Se pide la hora', 'Hay buen clima', 'Es de noche'], 0,
        'Peligro grave e inminente.'),
  ],
);
