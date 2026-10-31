import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// RECONSTRUIR LA SOCIEDAD
// =====================================================================
const reconstruir = Category(
  id: 'reconstruir',
  name: 'Reconstruir la sociedad',
  icon: Icons.foundation_outlined,
  summary: 'Agricultura, higiene, energía, construcción, comunidad y conocimiento.',
  articles: [
    Article('rec_prioridades', 'Por dónde empezar', r'''
Sobrevivir la primera semana es una cosa; vivir los próximos años es otra. Una comunidad sostenible necesita, en este orden:

1. Agua segura y saneamiento (letrinas lejos del agua).
2. Comida renovable: huertas, semillas, animales.
3. Refugio duradero.
4. Salud: higiene, partos, heridas, conocimiento médico básico.
5. Organización: reglas, reparto de tareas, resolución de conflictos.
6. Herramientas y oficios: carpintería, herrería, textiles, cerámica.
7. Conocimiento: enseñar a leer, escribir, contar y los oficios a los niños.
8. Energía y comunicación.

* Los libros y el conocimiento son tan valiosos como la comida. Rescata bibliotecas, manuales técnicos y libros de texto escolares.
'''),
    Article('rec_huerta', 'Huerta: cultivar tu comida', r'''
## Cultivos fáciles y rendidores en Colombia
- Clima cálido: yuca, plátano, maíz, fríjol, ahuyama, batata, papaya, ñame.
- Clima frío: papa, haba, arveja, maíz, cebolla, ajo, repollo, zanahoria, quinua.
- Rápidos (cosecha en 30–60 días): rábano, lechuga, espinaca, cilantro, acelga.
- Perennes que alimentan por años: plátano, frutales, aguacate, guandul, moringa.
@ yuca, platano, ahuyama, moringa, amaranto

## Pasos básicos
1. Lugar con al menos 6 horas de sol y cerca del agua.
2. Afloja la tierra 20–30 cm y mezcla compost o estiércol bien descompuesto.
3. Siembra semillas a una profundidad de 2–3 veces su tamaño.
4. Riega temprano en la mañana o al atardecer.
5. Cubre el suelo con hojas secas o paja (mulch): conserva humedad y frena malezas.

## La "milpa" o tres hermanas
Maíz + fríjol + ahuyama juntos: el maíz sostiene al fríjol, el fríjol aporta nitrógeno al suelo y la ahuyama cubre el suelo. Sistema indígena americano probado por miles de años.

## Rotación de cultivos
No siembres lo mismo en el mismo lugar cada temporada. Alterna: hojas → frutos → raíces → leguminosas (fríjol, arveja), que recuperan el suelo.
'''),
    Article('rec_semillas', 'Guardar semillas', r'''
Sin semillas no hay futuro. Guardarlas es la tarea más importante de largo plazo.

- Usa variedades criollas o tradicionales (no híbridas F1): sus semillas dan plantas iguales a la madre.
- Escoge las mejores plantas (sanas, productivas) para semilla, no las sobras.
- Deja madurar el fruto completamente en la planta (fríjol seco en la vaina, ahuyama bien madura).
- Seca las semillas a la sombra varios días.
- Guarda en frascos de vidrio cerrados, lugar fresco, seco y oscuro. Un poco de ceniza o arroz seco absorbe humedad.
- Etiqueta: especie, variedad, fecha.
- Prueba de germinación: 10 semillas en papel húmedo; si germinan 7, tienes 70 %.

* La yuca, el plátano y la papa se propagan por esquejes, hijuelos y tubérculos, no por semilla.
'''),
    Article('rec_compost', 'Compost y suelo fértil', r'''
- Mezcla materiales "verdes" (restos de cocina, pasto fresco, estiércol) y "cafés" (hojas secas, paja, cartón) en proporción aproximada 1:2.
- Debe estar húmedo como una esponja exprimida.
- Voltéalo cada 1–2 semanas para darle aire.
- En 2–3 meses obtienes tierra oscura con olor a bosque.
- No pongas carne, grasa ni heces de perro o humanas en el compost de la huerta.

* La orina humana diluida (1 parte por 8–10 de agua) es un fertilizante rico en nitrógeno; aplícala al suelo, no a las hojas que se comen crudas.
'''),
    Article('rec_animales', 'Animales de granja', r'''
@ gallina, cuy, conejo, tilapia, abeja_miel
- Gallinas: las más fáciles. Huevos diarios, carne, comen sobras e insectos. Necesitan gallinero cerrado de noche.
- Conejos y cuyes: se reproducen rápido, comen pasto y sobras, carne magra.
- Cabras: leche, carne, se adaptan a terreno pobre.
- Abejas: miel (endulzante, medicina, conservante), cera y polinización de cultivos.
- Peces en estanque (tilapia, cachama) en clima cálido.

! Lava muy bien las manos después de manejar animales y cocina bien la carne y los huevos.
'''),
    Article('rec_higiene', 'Higiene y saneamiento', r'''
El saneamiento salvó más vidas en la historia que casi cualquier medicina.

## Letrina de hoyo
- Mínimo 30 m de distancia de pozos y fuentes de agua, y cuesta abajo de ellas.
- Hoyo de 1,5–2 m de profundidad.
- Tras cada uso: un puñado de ceniza, cal o tierra. Reduce olor y moscas.
- Tapa. Cuando esté a 50 cm del borde, cúbrela de tierra y cava otra.

## Lavado de manos
Con jabón, siempre: después del baño, antes de cocinar y comer, después de cuidar enfermos. Una estación de lavado con un galón colgado y un palito ("tippy tap") ahorra agua.

## Jabón casero
El jabón se hace con grasa + álcali (lejía). La lejía tradicional se obtiene filtrando agua a través de ceniza de madera dura.
! La lejía quema la piel y los ojos: usa guantes, gafas y recipientes que no sean de aluminio.

## Basura
Separa: orgánico al compost; lo demás enterrado o quemado lejos de las viviendas y del agua.
'''),
    Article('rec_energia', 'Energía y luz', r'''
- Paneles solares: rescátalos de techos, señales viales o calculadoras. Un panel + regulador de carga + batería de carro da luz y carga celulares.
- Las baterías de plomo de carros se pueden recargar con paneles; no las descargues por debajo del 50 %.
- Dinamos de bicicleta generan electricidad pedaleando.
- Agua: una rueda en una quebrada con caída puede mover un molino o un pequeño generador.
- Luz: lámparas de aceite (aceite vegetal + mecha de algodón), velas de cera de abejas o sebo.
- Calor: estufas eficientes de leña ("rocket", estufa Lorena de barro).

* Ahorra el celular: modo avión, brillo bajo, tema oscuro (esta app ya lo usa), y cárgalo durante el día con el sol.
'''),
    Article('rec_construccion', 'Construcción tradicional', r'''
Técnicas con materiales locales que se usan en Colombia desde hace siglos:

- Bahareque: estructura de guadua o madera rellena de barro mezclado con paja. Resiste bien sismos por ser flexible.
- Adobe: bloques de barro + paja secados al sol. Gruesos, frescos de día y tibios de noche. Débiles ante sismos si no se refuerzan.
- Tapia pisada: tierra húmeda compactada en moldes de madera.
@ guadua
- Guadua: "el acero vegetal". Fuerte, flexible y crece rápido. Córtala madura (3–5 años) y cúrala (inmersión en agua o humo) para que no la ataquen insectos.

## Principios
- Cimientos de piedra que eleven la pared sobre el suelo: el agua destruye el barro.
- Aleros largos en el techo: protegen las paredes de la lluvia.
- Techos ligeros en zonas sísmicas.
'''),
    Article('rec_comunidad', 'Organizar una comunidad', r'''
## Primeros acuerdos
- Censo: nombres, habilidades (médicos, agricultores, mecánicos, profesores, cocineros), salud y necesidades.
- Inventario común de recursos clave (agua, comida, medicinas, herramientas).
- Reglas simples y claras, escritas y aceptadas por todos.
- Asamblea periódica para decisiones importantes.

## Repartir el trabajo
Rotación de tareas pesadas (agua, guardia, letrinas). Cada uno aporta según su capacidad.

## Resolver conflictos
- Escuchar a ambas partes por separado y luego juntas.
- Mediador neutral.
- Sanciones proporcionales y conocidas de antemano.
- Robar comida o agua comunes y la violencia son las faltas más graves.

## Trueque y comercio
Bienes de valor tras un colapso: sal, agua potable, medicamentos, semillas, herramientas, jabón, encendedores, alcohol (desinfectante), conocimiento (curar, reparar, enseñar).

* Las comunidades que cooperan sobreviven mejor que los individuos aislados. Es la lección más repetida de la historia.
'''),
    Article('rec_conocimiento', 'Conocimiento básico para reiniciar', r'''
## Método científico
Observa → pregunta → hipótesis → experimenta (cambiando una sola cosa a la vez) → registra → concluye. Así se mejora todo: cultivos, medicina, herramientas.

## Máquinas simples
Palanca, polea, plano inclinado, rueda y eje, cuña y tornillo. Con ellas una persona mueve cargas enormes.
- Palanca: cuanto más lejos del punto de apoyo empujas, menos fuerza necesitas.
- Polea doble: reduce la fuerza a la mitad.

## Medir
- Un paso promedio ≈ 0,75 m; cuenta pasos dobles para medir distancias.
- Un litro = 1 kg de agua.
- Calendario: registra lunas y lluvias para planear siembras.

## Química útil
- Ceniza + agua = lejía (álcali) → jabón.
- Cal (piedra caliza quemada) → mortero, desinfectar letrinas, mejorar suelos ácidos.
- Carbón vegetal: madera quemada sin oxígeno (enterrada o en horno cerrado). Combustible potente y filtro.
- Alcohol por fermentación de fruta o caña + destilación: desinfectante y combustible.

## Educación
Enseña a leer, escribir y las cuatro operaciones a todos los niños. Escribe lo que sabes: el conocimiento que no se escribe se pierde en una generación.
'''),
    Article('rec_parto', 'Parto de emergencia', r'''
La mayoría de los partos salen bien solos. Tu trabajo es ayudar, mantener limpio y no apresurar.

- Lávate muy bien las manos, ten telas limpias, agua hervida, algo para amarrar el cordón (cordones hervidos) y una cuchilla o tijera hervida.
- Deja que la madre adopte la posición que quiera.
- No jales al bebé: sostén la cabeza a medida que sale.
- Si el cordón está alrededor del cuello, pásalo suavemente por encima de la cabeza.
- Seca al bebé, ponlo piel con piel sobre el pecho de la madre y cúbrelos a ambos.
- Si no llora ni respira: frota la espalda, limpia boca y nariz.
- Espera a que el cordón deje de latir. Amárralo en dos puntos (a 10 y 15 cm del bebé) y corta entre ellos.
- La placenta sale sola en unos 30 minutos. No tires del cordón. Amamantar ayuda a que el útero se contraiga.

! Sangrado abundante después del parto: masajea firmemente el abdomen bajo (útero) y pon al bebé a mamar.
'''),
  ],
  quiz: [
    Question('La "milpa" o tres hermanas combina:',
        ['Papa, yuca y arroz', 'Maíz, fríjol y ahuyama', 'Café, cacao y caña', 'Trigo, cebada y avena'], 1,
        'Un sistema indígena donde cada planta ayuda a las otras.'),
    Question('¿A qué distancia mínima del agua va una letrina?',
        ['3 m', '30 m', '1 m', 'No importa'], 1,
        'Al menos 30 m y cuesta abajo de la fuente.'),
    Question('¿Qué semillas conviene guardar?',
        ['Híbridas F1', 'Criollas o tradicionales', 'Cualquiera', 'Las de plantas enfermas'], 1,
        'Las criollas reproducen la planta madre; las híbridas no.'),
    Question('La lejía para hacer jabón se obtiene de...',
        ['Arena', 'Ceniza de madera y agua', 'Sal', 'Azúcar'], 1,
        'El agua filtrada por ceniza es alcalina.'),
    Question('El bahareque usa...',
        ['Cemento y hierro', 'Guadua o madera con barro y paja', 'Vidrio', 'Plástico'], 1,
        'Técnica tradicional flexible y resistente a sismos.'),
    Question('En un parto de emergencia, ¿se tira del cordón para sacar la placenta?',
        ['Sí, fuerte', 'No, sale sola', 'Sí, con pinzas', 'Solo si llora el bebé'], 1,
        'Tirar puede causar una hemorragia grave.'),
  ],
);

// =====================================================================
// MENTE Y LIDERAZGO
// =====================================================================
const mente = Category(
  id: 'mente',
  name: 'Mente y liderazgo',
  icon: Icons.psychology_outlined,
  summary: 'Controlar el miedo, mantener la moral y liderar.',
  articles: [
    Article('men_miedo', 'Controlar el pánico', r'''
El pánico mata más que muchas heridas: hace tomar malas decisiones.

## Respiración en caja (usada por militares)
Inhala 4 segundos → retén 4 → exhala 4 → retén 4. Repite 4 veces.

## Técnica 5-4-3-2-1
Nombra 5 cosas que ves, 4 que tocas, 3 que oyes, 2 que hueles, 1 que saboreas. Te devuelve al presente.

## Mentalidad
- Divide los problemas en tareas pequeñas: "ahora solo necesito agua".
- Celebra cada logro.
- Acepta lo que no puedes cambiar; enfócate en lo que sí.
'''),
    Article('men_moral', 'Moral del grupo', r'''
- Rutinas diarias: horarios para comer, trabajar, descansar. Dan sensación de control.
- Cada persona necesita sentirse útil.
- Momentos de descanso, juegos, música e historias.
- Hablar del duelo; no ocultar las pérdidas.
- Cuida especialmente a niños y ancianos: necesitan explicaciones simples y presencia.
- Duerme: la falta de sueño destroza el juicio y el humor.
'''),
    Article('men_lider', 'Liderar en crisis', r'''
- Decide rápido con la información disponible; una decisión razonable a tiempo es mejor que una perfecta tarde.
- Comunica con claridad: qué pasa, qué haremos, qué necesito de cada uno.
- Da el ejemplo: el líder come al último y trabaja como los demás.
- Escucha a los expertos del grupo.
- Delega: nadie puede hacerlo todo.
- Admite errores y corrige.
'''),
  ],
  quiz: [
    Question('La respiración en caja es:',
        ['4-4-4-4 segundos', 'Rápida y corta', 'Contener 1 minuto', 'Solo exhalar'], 0,
        'Inhalar, retener, exhalar y retener 4 segundos cada uno.'),
    Question('Un buen líder en crisis...',
        ['Come primero', 'Da el ejemplo y delega', 'Decide solo sin escuchar', 'Oculta la información'], 1,
        'El ejemplo y la delegación mantienen la confianza.'),
  ],
);
