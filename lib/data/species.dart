import 'package:flutter/material.dart';

import '../core/i18n.dart';
import 'en/species_en.dart';

/// Tipo de especie en la guía visual.
enum Kind {
  fruta('Fruta comestible', 'Edible fruit', 'Fruta comestível', Icons.apple, Color(0xFF43A047)),
  comestible('Planta comestible', 'Edible plant', 'Planta comestível', Icons.grass, Color(0xFF7CB342)),
  medicinal('Medicinal', 'Medicinal', 'Medicinal', Icons.spa, Color(0xFF26A69A)),
  venenosa('Venenosa', 'Poisonous', 'Venenosa', Icons.dangerous, Color(0xFFE53935)),
  peligro('Animal peligroso', 'Dangerous animal', 'Animal perigoso', Icons.pest_control, Color(0xFFFF7043)),
  animal('Animal útil / comestible', 'Useful / edible animal', 'Animal útil / comestível', Icons.pets, Color(0xFF42A5F5));

  final String labelEs;
  final String labelEn;
  final String labelPt;
  final IconData icon;
  final Color color;
  const Kind(this.labelEs, this.labelEn, this.labelPt, this.icon, this.color);

  String get label => tr(labelEs, labelEn, labelPt);
}

class Species {
  final String id;
  final String name;
  final String sci;
  final Kind kind;

  /// Título del artículo en es.wikipedia (lo usa tool/imagenes.ps1).
  final String wiki;

  /// Cómo reconocerla (marcado simple).
  final String ident;

  /// Usos, peligros y qué hacer (marcado simple).
  final String info;
  const Species(this.id, this.name, this.sci, this.kind, this.wiki, this.ident, this.info);

  String get image => 'assets/img/$id.jpg';
}

const List<Species> speciesEs = [
  // ===================================================================
  // FRUTAS
  // ===================================================================
  Species('mango', 'Mango', 'Mangifera indica', Kind.fruta, 'Mangifera indica', r'''
- Árbol grande (10–30 m), copa densa y redonda, siempre verde.
- Hojas largas, angostas y brillantes; las nuevas salen rojizas.
- Frutos ovalados colgando de tallos largos; verdes, amarillos o rojizos.''', r'''
- Muy común en clima cálido (0–1.500 m). Pulpa dulce, rica en energía y vitamina A y C.
! La cáscara y la savia son de la misma familia que el marañón: pueden causar sarpullido en personas sensibles. Pela el mango si te irrita.'''),
  Species('guayaba', 'Guayaba', 'Psidium guajava', Kind.fruta, 'Psidium guajava', r'''
- Arbusto o árbol pequeño; corteza lisa color canela que se descascara en láminas.
- Hojas opuestas, ásperas, con venas muy marcadas; huelen al estrujarlas.
- Fruto redondo, verde a amarillo, olor fuerte y dulce; pulpa rosada o blanca con muchas semillas.''', r'''
- Una de las frutas con más vitamina C. Crece casi en cualquier potrero cálido o templado.
* El té de hojas de guayaba se usa tradicionalmente contra la diarrea.
- Su madera es excelente para ahumar carne.'''),
  Species('papaya', 'Papaya', 'Carica papaya', Kind.fruta, 'Carica papaya', r'''
- Tronco único, recto y sin ramas, con cicatrices de hojas caídas.
- Hojas enormes, muy recortadas (palmeadas), solo en la punta.
- Frutos pegados directamente al tronco bajo las hojas.''', r'''
- Fruto maduro: dulce y digestivo. Verde y cocido se come como verdura.
- Las semillas tienen sabor picante; se usan en poca cantidad.
* Es de las pocas plantas con savia lechosa que es comestible; la savia del fruto verde irrita la piel.'''),
  Species('guanabana', 'Guanábana', 'Annona muricata', Kind.fruta, 'Annona muricata', r'''
- Árbol pequeño de hojas brillantes, verde oscuro, olorosas.
- Fruto grande verde con "espinas" blandas y curvas.
- Pulpa blanca, fibrosa, jugosa, con semillas negras.''', r'''
- Pulpa comestible, ácida y dulce.
! No comas las semillas ni abuses de hojas en té: contienen sustancias tóxicas para el sistema nervioso.'''),
  Species('coco', 'Coco', 'Cocos nucifera', Kind.fruta, 'Cocos nucifera', r'''
- Palma alta de tronco delgado e inclinado, típica de las playas.
- Hojas largas como plumas.
- Racimos de cocos verdes o marrones en la copa.''', r'''
- El agua de un coco verde sano es estéril y sirve para hidratarse.
- La pulpa aporta mucha grasa y energía; de ella se saca aceite.
- Fibras para cuerdas, cáscaras como recipientes y yesca.
! Nunca te pares bajo una palma con cocos maduros: caen y pueden matar.'''),
  Species('platano', 'Plátano y banano', 'Musa × paradisiaca', Kind.fruta, 'Musa × paradisiaca', r'''
- Planta grande sin tronco leñoso: un "tallo" de hojas enrolladas.
- Hojas gigantes, enteras, que se rompen con el viento.
- Racimo colgante con una flor morada (bellota) en la punta.''', r'''
- Fruto: base de la alimentación en Colombia. Verde se cocina; maduro se come crudo.
- La bellota (flor) se come cocida.
- Hojas: techo, platos, envolver comida, refugio impermeable.
* Se propaga por hijuelos que salen de la base: arráncalos con raíz y siémbralos.'''),
  Species('maracuya', 'Maracuyá', 'Passiflora edulis', Kind.fruta, 'Passiflora edulis', r'''
- Enredadera con zarcillos que se agarran a cercas y árboles.
- Hojas con tres lóbulos; flor blanca y morada muy llamativa.
- Fruto redondo amarillo o morado, cáscara dura y lisa.''', r'''
- Pulpa ácida con semillas, rica en vitaminas. Se come la pulpa con las semillas.
! Come solo el fruto maduro (cáscara amarilla o morada y algo arrugada). El fruto verde puede ser tóxico.'''),
  Species('mamoncillo', 'Mamoncillo', 'Melicoccus bijugatus', Kind.fruta, 'Melicoccus bijugatus', r'''
- Árbol mediano de hojas compuestas.
- Racimos de bolitas verdes de cáscara dura y delgada.
- Pulpa gelatinosa salmón alrededor de una semilla grande.''', r'''
- Pulpa dulce y ácida. Común en el Caribe y valles cálidos.
! La semilla es grande y resbalosa: los niños pueden atragantarse.'''),
  Species('borojo', 'Borojó', 'Borojoa patinoi', Kind.fruta, 'Borojó', r'''
- Arbusto de la selva del Pacífico (Chocó).
- Hojas grandes, opuestas.
- Fruto redondo café, blando cuando madura, pulpa café muy densa.''', r'''
- Muy nutritivo y energético. Se come en jugo o dulce.
- Se conserva bien en dulce o deshidratado.'''),
  Species('chontaduro', 'Chontaduro', 'Bactris gasipaes', Kind.fruta, 'Bactris gasipaes', r'''
- Palma con troncos llenos de espinas negras en anillos.
- Racimos de frutos rojos, naranjas o amarillos del tamaño de un huevo pequeño.''', r'''
- Muy nutritivo: grasa, proteína, vitamina A. Del cogollo se saca palmito.
! Siempre cocido (hervido con sal 1–3 horas). Crudo irrita la boca y el estómago.'''),
  Species('mora', 'Mora de Castilla', 'Rubus glaucus', Kind.fruta, 'Rubus glaucus', r'''
- Arbusto trepador con tallos arqueados llenos de espinas.
- Hojas de 3 folíolos, blanquecinas por debajo.
- Frutos en racimos: verdes, luego rojos y negros al madurar.''', r'''
- Fruto comestible fresco o en jugo; clima frío (1.800–2.800 m).
* Las moras silvestres (Rubus) son en general seguras: frutos compuestos de "bolitas".'''),
  Species('lulo', 'Lulo', 'Solanum quitoense', Kind.fruta, 'Solanum quitoense', r'''
- Arbusto de 1–2 m, hojas enormes con espinas y pelos morados.
- Frutos redondos naranjas cubiertos de pelusa que se quita frotando.
- Pulpa verde, jugosa y muy ácida.''', r'''
- Comestible maduro (naranja). Rico en vitamina C. Clima templado húmedo.
! Pertenece a la familia de las solanáceas: no comas sus hojas ni frutos verdes.'''),
  Species('tomate_arbol', 'Tomate de árbol', 'Solanum betaceum', Kind.fruta, 'Solanum betaceum', r'''
- Arbusto de 2–3 m de tallo frágil, hojas grandes en forma de corazón con olor fuerte.
- Frutos ovalados colgantes, rojos o naranjas, cáscara lisa.''', r'''
- Fruto maduro comestible, ácido; típico en jugo. Clima frío-templado.
- La cáscara es amarga: se pela o se escalda.'''),
  Species('uchuva', 'Uchuva', 'Physalis peruviana', Kind.fruta, 'Physalis peruviana', r'''
- Hierba o arbusto bajo de hojas en forma de corazón, aterciopeladas.
- Fruto: bolita naranja dentro de un capuchón de papel (cáliz) seco.''', r'''
- Fruto maduro muy nutritivo; se conserva semanas dentro del capuchón.
! Solo el fruto bien maduro y naranja. Hojas, tallos y frutos verdes son tóxicos.'''),
  Species('granadilla', 'Granadilla', 'Passiflora ligularis', Kind.fruta, 'Passiflora ligularis', r'''
- Enredadera de hojas en forma de corazón.
- Fruto ovalado amarillo-naranja con pintas, cáscara dura y frágil.
- Pulpa gris transparente con semillas negras.''', r'''
- Muy digestiva; apta para niños y enfermos. Clima templado.'''),
  Species('aguacate', 'Aguacate', 'Persea americana', Kind.fruta, 'Persea americana', r'''
- Árbol grande de hojas ovaladas, coriáceas, que huelen a anís al estrujarlas.
- Fruto en forma de pera, verde o negro, con una gran semilla.''', r'''
- Una de las frutas con más grasa: excelente fuente de energía.
! Las hojas, la cáscara y la semilla son tóxicas para aves, conejos, cabras y caballos.'''),
  Species('guama', 'Guama', 'Inga edulis', Kind.fruta, 'Inga edulis', r'''
- Árbol mediano de hojas compuestas.
- Vainas largas verdes (hasta 1 m) colgantes.
- Dentro: semillas cubiertas de algodón blanco y dulce.''', r'''
- Se chupa el algodón dulce que cubre las semillas.
- Árbol de sombra para café; fija nitrógeno y mejora el suelo.
! No comas las semillas crudas.'''),
  Species('maranon', 'Marañón', 'Anacardium occidentale', Kind.fruta, 'Anacardium occidentale', r'''
- Árbol mediano de clima cálido y seco.
- "Fruto" carnoso rojo o amarillo con forma de pimentón.
- Debajo cuelga una nuez en forma de riñón.''', r'''
- La parte carnosa se come cruda o en jugo.
! La cáscara de la nuez tiene un aceite cáustico que quema la piel y la boca. La nuez solo se come tostada al fuego al aire libre y pelada; el humo también irrita.'''),
  Species('zapote', 'Zapote', 'Matisia cordata', Kind.fruta, 'Matisia cordata', r'''
- Árbol alto de hojas grandes en forma de corazón.
- Fruto redondo verde-café con cáscara gruesa.
- Pulpa naranja fibrosa y dulce con varias semillas.''', r'''
- Pulpa comestible y energética; común en el Pacífico y valles cálidos.'''),
  Species('carambola', 'Carambola', 'Averrhoa carambola', Kind.fruta, 'Averrhoa carambola', r'''
- Árbol pequeño de hojas compuestas.
- Fruto amarillo con 5 costillas: cortado parece una estrella.''', r'''
- Fruto refrescante y ácido.
! Personas con enfermedad de los riñones NO deben comerla: contiene una toxina que no pueden eliminar.'''),
  Species('pitahaya', 'Pitahaya amarilla', 'Selenicereus megalanthus', Kind.fruta, 'Selenicereus megalanthus', r'''
- Cactus trepador de tallos con tres costillas.
- Fruto amarillo con protuberancias espinosas que se caen al madurar.
- Pulpa blanca con semillas negras pequeñas.''', r'''
- Pulpa dulce y laxante. Quita las espinas antes de pelar.'''),
  Species('naranja', 'Naranja y cítricos', 'Citrus × sinensis', Kind.fruta, 'Citrus × sinensis', r'''
- Árbol con espinas en las ramas; hojas brillantes que huelen a cítrico.
- Flores blancas muy aromáticas (azahar).''', r'''
- Vitamina C: previene el escorbuto en encierros largos.
- La cáscara seca sirve como yesca y repelente suave.
* Limón: desinfecta superficies y ayuda a conservar alimentos.'''),

  // ===================================================================
  // PLANTAS COMESTIBLES Y ÚTILES
  // ===================================================================
  Species('yuca', 'Yuca', 'Manihot esculenta', Kind.comestible, 'Manihot esculenta', r'''
- Arbusto de 1–3 m, tallos con nudos marcados.
- Hojas palmeadas de 5–7 lóbulos largos, pecíolo rojizo.
- Raíces gruesas bajo tierra, cáscara café y pulpa blanca.''', r'''
- Gran fuente de energía. Se siembra con trozos de tallo de 20 cm.
! Contiene cianuro: siempre pelada y bien cocida. La "yuca brava" (amarga) necesita rallarse, remojarse y exprimirse antes de cocinar (casabe, fariña). Nunca cruda.'''),
  Species('verdolaga', 'Verdolaga', 'Portulaca oleracea', Kind.comestible, 'Portulaca oleracea', r'''
- Hierba rastrera de tallos rojizos y carnosos.
- Hojas pequeñas, gruesas y suculentas, en forma de cuchara.
- Flores amarillas diminutas.''', r'''
- Hojas y tallos crudos o cocidos; rica en omega-3. Crece como maleza en huertas y andenes.
! No confundir con la lechetrezna (Euphorbia), parecida pero con savia blanca lechosa: si sale leche, NO es verdolaga.'''),
  Species('diente_leon', 'Diente de león', 'Taraxacum officinale', Kind.comestible, 'Taraxacum officinale', r'''
- Roseta de hojas a ras del suelo con bordes en dientes.
- Una flor amarilla por tallo hueco; luego bola blanca de semillas.''', r'''
- Toda la planta es comestible: hojas jóvenes en ensalada, raíz tostada como sustituto de café. Muy común en clima frío.'''),
  Species('amaranto', 'Amaranto (bledo)', 'Amaranthus', Kind.comestible, 'Amaranthus', r'''
- Hierba de hasta 2 m, hojas ovaladas, a veces rojizas.
- Espigas densas de flores diminutas verdes, rojas o moradas.''', r'''
- Hojas cocidas como espinaca; semillas como cereal (tostadas o en atole).
- Crece rápido como maleza en suelos removidos.'''),
  Species('moringa', 'Moringa', 'Moringa oleifera', Kind.comestible, 'Moringa oleifera', r'''
- Árbol de crecimiento muy rápido, ramas frágiles.
- Hojas compuestas de folíolos pequeños y redondos.
- Vainas largas en forma de palillo.''', r'''
- Hojas muy nutritivas (proteína, hierro, vitaminas), cocidas o secas en polvo.
* Las semillas trituradas aclaran el agua turbia (después igual hay que hervirla).'''),
  Species('ortiga', 'Ortiga', 'Urtica dioica', Kind.comestible, 'Urtica dioica', r'''
- Hierba de hojas dentadas en forma de corazón, opuestas.
- Toda cubierta de pelos que pican al tocarlos.''', r'''
- Cocida pierde el picor: muy nutritiva en sopas. Fibra para cuerdas.
! Recógela con guantes. La pringamosa (otra planta urticante) causa ardor más fuerte.'''),
  Species('ahuyama', 'Ahuyama', 'Cucurbita moschata', Kind.comestible, 'Cucurbita moschata', r'''
- Planta rastrera de hojas grandes y ásperas, flores amarillas grandes.
- Frutos grandes de cáscara dura, pulpa naranja.''', r'''
- Fruto, flores, hojas tiernas y semillas tostadas: todo se come.
- Se conserva meses entera en lugar seco. Parte de la "milpa" (maíz, fríjol, ahuyama).'''),
  Species('guadua', 'Guadua', 'Guadua angustifolia', Kind.comestible, 'Guadua angustifolia', r'''
- Bambú gigante nativo (hasta 25 m), tallos verdes con nudos y bandas blancas.
- Crece en guaduales a orillas de ríos.''', r'''
- "Acero vegetal": casas, puentes, tuberías, recipientes, balsas.
- Los entrenudos guardan agua potable en algunas épocas.
- Los brotes tiernos se comen bien cocidos.'''),

  // ===================================================================
  // MEDICINALES
  // ===================================================================
  Species('manzanilla', 'Manzanilla', 'Matricaria chamomilla', Kind.medicinal, 'Matricaria chamomilla', r'''
- Hierba baja de hojas muy finas, divididas.
- Flores como pequeñas margaritas: centro amarillo hueco y pétalos blancos. Olor a manzana.''', r'''
- Té para nervios, insomnio, cólicos y digestión. Compresas tibias para ojos irritados.
! Puede causar alergia a quienes son alérgicos a las margaritas.'''),
  Species('hierbabuena', 'Hierbabuena', 'Mentha spicata', Kind.medicinal, 'Mentha spicata', r'''
- Hierba de tallo cuadrado, hojas dentadas con fuerte olor a menta.
- Se extiende por tallos subterráneos.''', r'''
- Té para dolor de estómago, gases y náuseas. Refresca el aliento.'''),
  Species('sabila', 'Sábila', 'Aloe vera', Kind.medicinal, 'Aloe vera', r'''
- Roseta de hojas gruesas, carnosas, verde grisáceo con dientes en los bordes.
- Gel transparente dentro de la hoja.''', r'''
- El gel calma quemaduras leves, raspones y quemaduras de sol.
! La capa amarilla bajo la cáscara (acíbar) es un laxante fuerte: no se toma.'''),
  Species('calendula', 'Caléndula', 'Calendula officinalis', Kind.medicinal, 'Calendula officinalis', r'''
- Hierba de hojas alargadas y pegajosas.
- Flores naranjas o amarillas tipo margarita.''', r'''
- Compresas o pomada para pequeñas heridas, irritaciones y picaduras. Pétalos comestibles.'''),
  Species('jengibre', 'Jengibre', 'Zingiber officinale', Kind.medicinal, 'Zingiber officinale', r'''
- Planta de hojas largas y angostas en tallos tipo caña.
- Rizoma (raíz) beige, nudoso, muy aromático y picante.''', r'''
- Té para náuseas, mareo y resfriado. Se siembra un trozo de rizoma con "ojos".'''),
  Species('limoncillo', 'Limoncillo', 'Cymbopogon citratus', Kind.medicinal, 'Cymbopogon citratus', r'''
- Pasto en macollas grandes, hojas largas y ásperas con olor a limón.''', r'''
- Té relajante y digestivo. Sembrado alrededor de la casa ayuda a repeler mosquitos.'''),
  Species('eucalipto', 'Eucalipto', 'Eucalyptus globulus', Kind.medicinal, 'Eucalyptus globulus', r'''
- Árbol muy alto, corteza que se desprende en tiras.
- Hojas jóvenes redondas y azuladas; adultas largas en forma de hoz. Olor fuerte.''', r'''
- Vapor de hojas hervidas para la congestión y la tos.
! No tragues el aceite de eucalipto: es tóxico, sobre todo en niños.'''),
  Species('llanten', 'Llantén', 'Plantago major', Kind.medicinal, 'Plantago major', r'''
- Roseta de hojas anchas a ras del suelo con 5–7 venas paralelas muy marcadas.
- Espigas delgadas de flores diminutas.''', r'''
- Hoja machacada sobre picaduras, raspones y pequeñas heridas. Hojas tiernas comestibles cocidas.
- Muy común en caminos y potreros.'''),
  Species('toronjil', 'Toronjil', 'Melissa officinalis', Kind.medicinal, 'Melissa officinalis', r'''
- Hierba de tallo cuadrado, hojas dentadas y arrugadas con olor a limón.''', r'''
- Té tranquilizante, para la ansiedad, el insomnio y el estómago nervioso.'''),
  Species('ajo', 'Ajo', 'Allium sativum', Kind.medicinal, 'Allium sativum', r'''
- Hojas planas y largas; bulbo dividido en dientes con fuerte olor.''', r'''
- Antibacteriano suave, condimento. Se siembran los dientes uno por uno.
! No lo pongas crudo directamente sobre heridas o piel: puede quemar.'''),
  Species('romero', 'Romero', 'Salvia rosmarinus', Kind.medicinal, 'Salvia rosmarinus', r'''
- Arbusto de hojas como agujas, verdes arriba y blancas abajo, muy aromáticas.
- Flores pequeñas azul pálido.''', r'''
- Té para la digestión y el cansancio; condimento que ayuda a conservar carnes.'''),

  // ===================================================================
  // PLANTAS Y HONGOS VENENOSOS
  // ===================================================================
  Species('manzanillo', 'Manzanillo de playa', 'Hippomane mancinella', Kind.venenosa, 'Hippomane mancinella', r'''
- Árbol de costas caribe y pacífica, cerca de playas y manglares.
- Hojas brillantes, ovaladas, con tallo amarillo.
- Frutos pequeños verde-amarillos como manzanitas que huelen dulce.''', r'''
! Uno de los árboles más tóxicos del mundo. El fruto quema la boca y la garganta; la savia causa ampollas y puede dejar ciego.
! No te refugies debajo en lluvia (el agua arrastra savia) ni quemes su madera (el humo daña ojos y pulmones).'''),
  Species('borrachero', 'Borrachero / Cacao sabanero', 'Brugmansia', Kind.venenosa, 'Brugmansia', r'''
- Arbusto o árbol pequeño, muy común en jardines y cercas de clima frío.
- Flores enormes en forma de trompeta colgando hacia abajo: blancas, amarillas, rosadas o rojas.''', r'''
! Toda la planta es muy tóxica (escopolamina): delirio, pupilas dilatadas, fiebre, parálisis, muerte. Ni en té ni en humo. No la toques y luego te frotes los ojos.'''),
  Species('higuerilla', 'Higuerilla (ricino)', 'Ricinus communis', Kind.venenosa, 'Ricinus communis', r'''
- Arbusto de crecimiento rápido en lotes y orillas de carretera.
- Hojas enormes palmeadas de 5–11 puntas, a veces rojizas.
- Frutos en racimo con espinas blandas; semillas brillantes jaspeadas.''', r'''
! Las semillas contienen ricina: masticar unas pocas puede matar a un niño. No las comas ni las uses como cuentas de collar.'''),
  Species('adelfa', 'Adelfa / Laurel rosa', 'Nerium oleander', Kind.venenosa, 'Nerium oleander', r'''
- Arbusto ornamental muy común en separadores y parques.
- Hojas largas, angostas, duras, en grupos de 3.
- Flores rosadas, blancas o rojas en racimos.''', r'''
! Todas sus partes afectan el corazón. No uses sus ramas como pinchos para asar ni quemes su madera.'''),
  Species('dieffenbachia', 'Dieffenbachia (millonaria)', 'Dieffenbachia', Kind.venenosa, 'Dieffenbachia', r'''
- Planta de interior de hojas grandes verdes con manchas blancas o crema.
- Tallo grueso y carnoso.''', r'''
! Al morderla hincha la boca y la lengua con un dolor intenso; puede dificultar la respiración. Peligrosa para niños y mascotas.'''),
  Species('chocho', 'Chocho / Ojo de pájaro', 'Abrus precatorius', Kind.venenosa, 'Abrus precatorius', r'''
- Enredadera de hojas compuestas pequeñas.
- Vainas que se abren mostrando semillas rojo brillante con una mancha negra.''', r'''
! Una semilla masticada puede ser mortal (abrina). Se usan en artesanías: mantenlas lejos de niños.'''),
  Species('cicuta', 'Cicuta', 'Conium maculatum', Kind.venenosa, 'Conium maculatum', r'''
- Hierba alta (hasta 2 m) de la familia de la zanahoria.
- Tallo hueco con manchas moradas; hojas como de perejil o helecho.
- Flores blancas en sombrillas. Olor desagradable a ratón.''', r'''
! Mortal: paraliza los músculos de la respiración. Por eso NUNCA comas plantas silvestres parecidas a la zanahoria, el perejil o el cilantro.'''),
  Species('lantana', 'Lantana / Venturosa', 'Lantana camara', Kind.venenosa, 'Lantana camara', r'''
- Arbusto con olor fuerte, tallos ásperos.
- Ramilletes de flores pequeñas que cambian de color (amarillo, naranja, rojo, rosado).
- Bolitas verdes que se vuelven negras.''', r'''
! Los frutos verdes son tóxicos, sobre todo para niños; las hojas intoxican al ganado.'''),
  Species('pringamosa', 'Pringamosa', 'Urera baccifera', Kind.venenosa, 'Urera baccifera', r'''
- Arbusto de hojas grandes con espinas y pelos urticantes.
- Frutos blancos o rosados pequeños.''', r'''
! Su contacto produce ardor intenso que dura horas. Lava con agua y jabón sin frotar, retira pelos con cinta adhesiva.'''),
  Species('amanita_phalloides', 'Oronja verde (hongo mortal)', 'Amanita phalloides', Kind.venenosa, 'Amanita phalloides', r'''
- Sombrero verde oliva a blanquecino, láminas blancas.
- Anillo en el tallo y una "bolsa" (volva) en la base enterrada.''', r'''
! Causa la mayoría de las muertes por hongos. Los síntomas empiezan 6–24 h después, cuando el hígado ya está dañado. Cocinarlo no lo vuelve seguro.'''),
  Species('amanita_muscaria', 'Matamoscas (hongo rojo)', 'Amanita muscaria', Kind.venenosa, 'Amanita muscaria', r'''
- Sombrero rojo brillante con verrugas blancas.
- Común bajo pinos y eucaliptos en clima frío de Colombia.''', r'''
! Tóxico: delirio, vómito, convulsiones. Regla de oro: no comas hongos silvestres.'''),

  // ===================================================================
  // ANIMALES PELIGROSOS
  // ===================================================================
  Species('mapana', 'Mapaná / Talla X', 'Bothrops asper', Kind.peligro, 'Bothrops asper', r'''
- Serpiente de 1,2–2 m, cabeza triangular ancha.
- Color café-oliva con dibujos de triángulos o "X" oscuros en los costados.
- Activa de noche en zonas cálidas, cultivos y cerca de casas.''', r'''
! Causa la mayoría de las mordeduras graves en Colombia. Inmoviliza, calma y busca antiveneno. No cortes, no chupes, no torniquete.
* Usa botas y linterna de noche; no metas las manos en huecos o entre la leña sin mirar.'''),
  Species('cascabel', 'Cascabel', 'Crotalus durissus', Kind.peligro, 'Crotalus durissus', r'''
- Serpiente gruesa con rombos en el lomo y un cascabel en la cola que suena al moverse.
- Sabanas y zonas secas del Caribe y Llanos.''', r'''
! Veneno que afecta nervios y músculos (visión borrosa, párpados caídos). Si oyes el cascabel, aléjate despacio hacia atrás.'''),
  Species('coral', 'Serpiente coral', 'Micrurus', Kind.peligro, 'Micrurus', r'''
- Pequeña y delgada, con anillos completos rojos, negros y amarillos o blancos.
- Cabeza pequeña, no triangular. Tímida.''', r'''
! Veneno neurotóxico muy potente que puede paralizar la respiración horas después, aunque casi no duela. En Colombia, trata TODA serpiente de anillos de colores como peligrosa: las "reglas de los colores" no funcionan aquí.'''),
  Species('verrugosa', 'Verrugosa / Rieca', 'Lachesis muta', Kind.peligro, 'Lachesis muta', r'''
- La víbora más larga de América (hasta 3 m).
- Escamas ásperas como "verrugas", diseño de rombos oscuros sobre fondo crema o café.
- Selvas húmedas (Amazonía, Pacífico, Magdalena Medio).''', r'''
! Inyecta mucho veneno. Evita la selva de noche sin linterna.'''),
  Species('rana_dorada', 'Rana dorada', 'Phyllobates terribilis', Kind.peligro, 'Phyllobates terribilis', r'''
- Rana pequeña (5 cm) amarillo o naranja brillante, a veces verde-menta.
- Selva del Pacífico (Cauca). Otras ranas venenosas tienen colores vivos con manchas.''', r'''
! Su piel tiene una de las toxinas más potentes de la naturaleza. No toques ranas de colores brillantes; si lo haces, no te toques la boca ni los ojos y lávate muy bien.'''),
  Species('viuda_negra', 'Viuda negra', 'Latrodectus', Kind.peligro, 'Latrodectus', r'''
- Araña pequeña negra brillante, abdomen redondo, a veces con una mancha roja en forma de reloj de arena.
- Telarañas desordenadas en rincones, leña, letrinas.''', r'''
! Picadura con calambres y dolor muscular fuerte, sudor. Peligrosa en niños y ancianos. Frío local y vigilancia.
* Sacude ropa, botas y cobijas antes de usarlas.'''),
  Species('alacran', 'Alacrán', 'Tityus', Kind.peligro, 'Tityus', r'''
- Arácnido con pinzas y cola curvada con aguijón.
- Se esconde bajo piedras, troncos, ladrillos y dentro de zapatos.''', r'''
! Las especies de Tityus pueden ser graves en niños pequeños (vómito, sudor, dificultad respiratoria). Frío local y vigilar.'''),
  Species('arana_bananera', 'Araña bananera', 'Phoneutria', Kind.peligro, 'Phoneutria', r'''
- Araña grande y peluda (patas de hasta 15 cm), café.
- No hace telaraña: caza en el suelo. Agresiva: se levanta sobre las patas traseras.
- Común en platanales y racimos.''', r'''
! Picadura muy dolorosa; puede ser grave en niños. Revisa los racimos de plátano antes de cargarlos.'''),
  Species('lonomia', 'Oruga Lonomia (gusano de fuego)', 'Lonomia', Kind.peligro, 'Lonomia', r'''
- Orugas verde-café con espinas ramificadas, en grupos sobre troncos de árboles.
- Se camuflan con la corteza.''', r'''
! Su veneno impide la coagulación: hemorragias en encías, orina y moretones días después. No toques orugas con espinas o pelos. Si hay sangrado tras un contacto, es una emergencia.'''),
  Species('abeja_africanizada', 'Abeja africanizada', 'Apis mellifera scutellata', Kind.peligro, 'Abeja africanizada', r'''
- Igual a la abeja común, pero defiende su colmena en enjambre y persigue cientos de metros.''', r'''
! Si te atacan: corre en línea recta hacia un lugar cerrado (casa, carro) cubriendo cara y cabeza. No te tires al agua: esperan arriba. Raspa los aguijones.'''),
  Species('caiman', 'Babilla / Caimán', 'Caiman crocodilus', Kind.peligro, 'Caiman crocodilus', r'''
- Reptil de 1,5–2,5 m en ciénagas, ríos lentos y caños.
- Ojos y nariz sobresalen del agua; de noche sus ojos brillan rojo con linterna.''', r'''
! Evita bañarte o lavar ropa en aguas turbias y quietas de tierras bajas, sobre todo al anochecer.'''),
  Species('raya', 'Raya de río', 'Potamotrygon', Kind.peligro, 'Potamotrygon', r'''
- Pez plano en forma de disco, se entierra en la arena de ríos y playas de río.
- Cola con un aguijón aserrado.''', r'''
! Al cruzar ríos arrastra los pies: las ahuyentas en lugar de pisarlas. La herida duele mucho: agua lo más caliente que se tolere (sin quemar) 30–90 min.'''),
  Species('hormiga_conga', 'Hormiga conga (bala)', 'Paraponera clavata', Kind.peligro, 'Paraponera clavata', r'''
- Hormiga negra muy grande (2,5 cm), en la base de árboles en selva húmeda.''', r'''
! Su picadura es de las más dolorosas del mundo; el dolor dura horas. Rara vez es mortal. Frío local y analgésico.'''),
  Species('vampiro', 'Murciélago vampiro', 'Desmodus rotundus', Kind.peligro, 'Desmodus rotundus', r'''
- Murciélago pequeño café, de nariz chata. Muerde de noche a ganado y a veces a personas dormidas.''', r'''
! Transmite la rabia. Duerme bajo toldillo o en lugar cerrado. Toda mordedura de murciélago: lavar 15 minutos con agua y jabón y buscar vacuna antirrábica.'''),
  Species('aedes', 'Zancudo del dengue', 'Aedes aegypti', Kind.peligro, 'Aedes aegypti', r'''
- Zancudo negro con rayas blancas en patas y lomo. Pica de día.
- Se cría en agua quieta y limpia: llantas, tarros, floreros, tanques destapados.''', r'''
! Transmite dengue, zika, chikunguña y fiebre amarilla. Tapa el agua almacenada, vacía recipientes cada semana, usa toldillo y ropa larga.'''),
  Species('pito', 'Pito (chinche del Chagas)', 'Rhodnius prolixus', Kind.peligro, 'Rhodnius prolixus', r'''
- Chinche alargada café de 2–3 cm. Vive en techos de palma y grietas de paredes de barro.
- Pica de noche, cerca de la boca y los ojos.''', r'''
! Transmite la enfermedad de Chagas (daña el corazón años después). Revoca grietas, revisa techos de palma, usa toldillo.'''),
  Species('jaguar', 'Jaguar', 'Panthera onca', Kind.peligro, 'Panthera onca', r'''
- El felino más grande de América: amarillo con rosetas negras.
- Selvas y Llanos; rara vez se deja ver.''', r'''
! Los ataques a personas son muy raros. Si lo ves: no corras, no le des la espalda, hazte grande, habla fuerte y retrocede despacio.'''),

  // ===================================================================
  // ANIMALES ÚTILES Y COMESTIBLES
  // ===================================================================
  Species('hormiga_culona', 'Hormiga culona', 'Atta laevigata', Kind.animal, 'Atta laevigata', r'''
- Reinas aladas de hormiga arriera, abdomen grande.
- Salen en masa de los hormigueros al inicio de las lluvias (marzo–mayo).''', r'''
- Tostadas con sal: mucha proteína y grasa. Tradición santandereana.
* Quita alas y patas antes de tostar.'''),
  Species('mojojoy', 'Mojojoy', 'Rhynchophorus palmarum', Kind.animal, 'Rhynchophorus palmarum', r'''
- Larva blanca y gorda (5–7 cm) de cabeza oscura, dentro de troncos de palma caídos o podridos.''', r'''
- Alimento tradicional en la Amazonía: muy rico en grasa y proteína. Asado o frito.
* Se puede "cultivar" cortando un tronco de palma y revisándolo semanas después.'''),
  Species('tilapia', 'Tilapia', 'Oreochromis niloticus', Kind.animal, 'Oreochromis niloticus', r'''
- Pez de agua dulce de cuerpo alto, gris con rayas verticales.''', r'''
- El pez más fácil de criar en estanques de clima cálido; come algas, sobras y concentrado. Crece rápido.'''),
  Species('bocachico', 'Bocachico', 'Prochilodus magdalenae', Kind.animal, 'Prochilodus magdalenae', r'''
- Pez plateado de boca carnosa en forma de ventosa; ríos y ciénagas del Magdalena.''', r'''
- Fuente tradicional de proteína ribereña. Muchas espinas: se hace "sajado" (cortes) al freír.'''),
  Species('cuy', 'Cuy', 'Cavia porcellus', Kind.animal, 'Cavia porcellus', r'''
- Roedor doméstico pequeño sin cola, de varios colores.''', r'''
- Se cría en espacios pequeños con pasto y sobras de cocina. Se reproduce rápido. Carne magra; tradición en Nariño.'''),
  Species('conejo', 'Conejo', 'Oryctolagus cuniculus', Kind.animal, 'Oryctolagus cuniculus', r'''
- Mamífero de orejas largas; se cría en jaulas o corrales.''', r'''
- Carne magra; su estiércol es excelente abono directo para la huerta.
! La carne de conejo sola no basta: necesita grasa de otras fuentes en la dieta.'''),
  Species('gallina', 'Gallina criolla', 'Gallus gallus domesticus', Kind.animal, 'Gallus gallus domesticus', r'''
- Ave doméstica; las criollas son resistentes y buenas madres.''', r'''
- Huevos casi a diario, carne, control de insectos y abono. Encierro seguro de noche contra zarigüeyas y perros.'''),
  Species('iguana', 'Iguana', 'Iguana iguana', Kind.animal, 'Iguana iguana', r'''
- Lagarto verde grande (hasta 1,5 m) con cresta de púas en el lomo; vive en árboles cerca del agua.''', r'''
- Carne y huevos se consumen tradicionalmente en la costa Caribe.
! Puede portar salmonela: cocina muy bien y lávate las manos. En tiempos normales está protegida por ley en épocas de reproducción.'''),
  Species('chiguiro', 'Chigüiro', 'Hydrochoerus hydrochaeris', Kind.animal, 'Hydrochoerus hydrochaeris', r'''
- El roedor más grande del mundo (hasta 60 kg), café, sin cola. Vive en grupos cerca de agua en los Llanos.''', r'''
- Fuente tradicional de carne en los Llanos.'''),
  Species('abeja_miel', 'Abeja de miel', 'Apis mellifera', Kind.animal, 'Apis mellifera', r'''
- Abeja café-dorada con rayas; colmenas en cajas o huecos de árboles.
- En Colombia también hay abejas nativas sin aguijón (angelitas).''', r'''
- Miel: alimento, conservante y uso en heridas. Cera para velas e impermeabilizar. Polinizan los cultivos.'''),
  Species('lombriz', 'Lombriz de tierra', 'Lumbricus terrestris', Kind.animal, 'Lumbricus terrestris', r'''
- Gusano rosado segmentado en suelos húmedos y ricos.''', r'''
- Carnada para pescar; la lombriz roja californiana convierte sobras en abono (lombricompost).
- Comestible en emergencia: purgar en agua y cocinar bien.'''),
  // ===================================================================
  // MÁS PLANTAS MEDICINALES (v3)
  // ===================================================================
  Species('cidron', 'Cidrón', 'Aloysia citrodora', Kind.medicinal, 'Aloysia citrodora', r'''
- Arbusto de 1–3 m, hojas largas y angostas en grupos de 3, ásperas.
- Olor muy fuerte a limón al estrujarlas. Flores diminutas blancas o lilas en espigas.''', r'''
- Té digestivo y calmante: gases, cólicos, nervios, insomnio.
* Muy común en huertas de clima frío y templado.'''),
  Species('prontoalivio', 'Prontoalivio', 'Lippia alba', Kind.medicinal, 'Lippia alba', r'''
- Arbusto de ramas largas y arqueadas, hojas pequeñas rugosas, opuestas, con olor fuerte a menta-limón.
- Flores lilas en cabecitas.''', r'''
- Té para dolor de estómago, cólicos, gases y nervios. Muy usado en el campo colombiano.'''),
  Species('albahaca', 'Albahaca', 'Ocimum basilicum', Kind.medicinal, 'Ocimum basilicum', r'''
- Hierba de tallo cuadrado, hojas ovaladas brillantes muy aromáticas.
- Espigas de flores blancas o moradas.''', r'''
- Té digestivo y para gases. Condimento.
- Sembrada en ventanas y puertas ayuda a alejar zancudos.'''),
  Species('tomillo', 'Tomillo', 'Thymus vulgaris', Kind.medicinal, 'Thymus vulgaris', r'''
- Arbustito bajo y leñoso, hojas diminutas grisáceas muy aromáticas.''', r'''
- Té con miel para la tos y la garganta; vapores para la congestión. Antiséptico suave. Condimento que ayuda a conservar.'''),
  Species('malva', 'Malva', 'Malva sylvestris', Kind.medicinal, 'Malva sylvestris', r'''
- Hierba de hojas redondeadas con 5–7 lóbulos y bordes dentados.
- Flores rosado-moradas con rayas oscuras; frutos como quesitos redondos.''', r'''
- Gárgaras y té para garganta irritada y tos seca. Compresas para inflamaciones de la piel. Hojas tiernas comestibles cocidas.'''),
  Species('sauco', 'Saúco', 'Sambucus nigra', Kind.medicinal, 'Sambucus nigra', r'''
- Arbusto o árbol pequeño de hojas compuestas (5–7 folíolos dentados).
- Ramilletes planos de flores blancas diminutas; luego bayas negras-moradas.''', r'''
- Té de FLORES secas para la tos, resfriado y fiebre (hace sudar).
! Hojas, tallos, corteza y bayas crudas o verdes son tóxicos. Las bayas maduras solo cocidas.'''),
  Species('sangre_drago', 'Sangre de drago', 'Croton lechleri', Kind.medicinal, 'Croton lechleri', r'''
- Árbol de la Amazonía y piedemonte, hojas grandes en forma de corazón.
- Al cortar la corteza sale un látex rojo oscuro como sangre.''', r'''
- Unas gotas del látex sobre heridas pequeñas y raspones forman una capa protectora y ayudan a cicatrizar.
- Tradicionalmente se toman pocas gotas en agua para la diarrea y úlceras; no abuses.'''),
  Species('una_gato', 'Uña de gato', 'Uncaria tomentosa', Kind.medicinal, 'Uncaria tomentosa', r'''
- Liana de selva con espinas curvas como garras de gato en pares.''', r'''
- Cocimiento de la corteza: tradicional para inflamación y dolores de articulaciones.
! No en embarazo ni en personas con trasplantes o enfermedades autoinmunes.'''),
  Species('arnica', 'Árnica', 'Arnica montana', Kind.medicinal, 'Arnica montana', r'''
- Hierba de montaña con flores amarillo-naranja tipo margarita de pétalos desordenados.
- En Colombia se llama "árnica" también a otras plantas; verifica.''', r'''
- Compresas o ungüento SOLO sobre golpes, moretones y torceduras con la piel sana.
! Tóxica si se toma: no la bebas ni la pongas en heridas abiertas.'''),
  Species('valeriana', 'Valeriana', 'Valeriana officinalis', Kind.medicinal, 'Valeriana officinalis', r'''
- Hierba alta de hojas divididas, flores blancas o rosadas en ramilletes.
- La raíz seca huele fuerte y desagradable (a queso o medias).''', r'''
- Cocimiento suave de raíz para insomnio y ansiedad. Da sueño: no la combines con alcohol ni pastillas para dormir.'''),
  Species('achiote', 'Achiote', 'Bixa orellana', Kind.medicinal, 'Bixa orellana', r'''
- Arbusto de hojas en forma de corazón, flores rosadas.
- Cápsulas rojas peludas con semillas cubiertas de pasta rojo-naranja.''', r'''
- Las semillas tiñen y condimentan la comida.
- Pueblos indígenas usan la pasta en la piel como protector solar y repelente de insectos.'''),
  Species('quina', 'Quina', 'Cinchona pubescens', Kind.medicinal, 'Cinchona pubescens', r'''
- Árbol de los Andes (bosques de niebla), hojas grandes ovaladas con venas rojizas.
- Flores rosadas tubulares en racimos; corteza amarga.''', r'''
- De su corteza se obtuvo la quinina, la primera medicina contra la malaria.
! Peligrosa en exceso: zumbido de oídos, sordera, problemas de vista y de corazón. Solo en malaria sin otra opción.'''),
  Species('cola_caballo', 'Cola de caballo', 'Equisetum', Kind.medicinal, 'Equisetum', r'''
- Planta sin hojas verdaderas: tallos verdes huecos con nudos y anillos de ramitas finas, como la cola de un caballo.
- Crece en lugares húmedos y orillas de quebradas.''', r'''
- Té diurético tradicional. Sus tallos ásperos sirven para pulir y lavar ollas.
! No la uses por más de 1–2 semanas seguidas.'''),
  Species('matarraton', 'Matarratón', 'Gliricidia sepium', Kind.medicinal, 'Gliricidia sepium', r'''
- Árbol mediano de cercas vivas en clima cálido, hojas compuestas.
- Flores rosado-lilas en racimos antes de las hojas nuevas.''', r'''
- Baños con hojas maceradas: remedio tradicional para bajar la fiebre y para la piel.
- Excelente forraje y abono verde; fija nitrógeno.
! Solo uso externo. Es tóxico para roedores (de ahí su nombre).'''),
  Species('ruda', 'Ruda', 'Ruta graveolens', Kind.venenosa, 'Ruta graveolens', r'''
- Arbusto pequeño de hojas verde-azuladas divididas, olor muy fuerte y desagradable.
- Flores amarillas de 4–5 pétalos.''', r'''
! Remedio popular peligroso: puede causar aborto, daño al hígado y riñón. Su savia con sol quema la piel (ampollas). Nunca en embarazo.'''),
  Species('paico', 'Paico', 'Dysphania ambrosioides', Kind.venenosa, 'Dysphania ambrosioides', r'''
- Hierba de olor muy fuerte y penetrante, hojas dentadas alargadas.
- Espigas de flores verdes diminutas.''', r'''
! Usado contra parásitos, pero su aceite es tóxico y ha causado muertes, sobre todo de niños. En poca cantidad se usa como condimento.'''),
];

List<Species>? _speciesEnCache;
Map<String, Species>? _byIdEs, _byIdEn;

/// Especies en el idioma actual.
List<Species> get species {
  if (!isEn) return speciesEs;
  return _speciesEnCache ??= [
    for (final s in speciesEs)
      if (speciesEnText[s.id] case final t?) Species(s.id, t.$1, s.sci, s.kind, s.wiki, t.$2, t.$3) else s,
  ];
}

Map<String, Species> get speciesById =>
    isEn ? (_byIdEn ??= {for (final s in species) s.id: s}) : (_byIdEs ??= {for (final s in speciesEs) s.id: s});
