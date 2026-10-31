import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// COMIDA
// =====================================================================
const comida = Category(
  id: 'comida',
  name: 'Comida',
  icon: Icons.restaurant_outlined,
  summary: 'Raciones, pesca, insectos y conservación de alimentos.',
  articles: [
    Article('com_raciones', 'Raciones y nutrición', r'''
## Calorías
- Adulto en reposo: unas 1.800–2.000 kcal/día. Con trabajo físico: 2.500–3.500.
- Se puede sobrevivir semanas con mucho menos, pero la fuerza y el juicio caen.

## Prioriza
- Carbohidratos: arroz, panela, plátano, yuca, papa, avena, maíz.
- Proteína: fríjol, lenteja, garbanzo, huevo, pescado, atún enlatado.
- Grasa (más energía por gramo): aceite, maní, coco, aguacate.
- Sal: imprescindible con calor y sudor.

## Despensa de emergencia (dura años)
Arroz blanco, lentejas, fríjoles secos, panela, sal, miel, avena, aceite, enlatados, maní. Gira lo que compras: lo viejo primero.

* Combinar arroz + fríjol o maíz + fríjol da proteína completa.
! Si tienes poca agua, come poco y evita alimentos salados o ricos en proteína: aumentan la sed.
'''),
    Article('com_insectos', 'Insectos comestibles', r'''
Los insectos son una de las proteínas más abundantes y fáciles de obtener. En Colombia la hormiga culona (Santander) es un manjar tradicional.

## Generalmente seguros (siempre cocinados)
@ hormiga_culona, mojojoy, lombriz
- Hormigas culonas, saltamontes y grillos (quita patas y alas).
- Larvas de escarabajo de troncos podridos (mojojoy en la Amazonía).
- Termitas.
- Lombrices (purga en agua limpia unas horas antes).

## Evita
- Insectos de colores brillantes o que huelen mal.
- Insectos peludos (orugas).
- Moscas, garrapatas, mosquitos (portan enfermedades).
- Arañas, ciempiés y alacranes.

! Cocina siempre los insectos: tostados o hervidos. Eliminas parásitos.
'''),
    Article('com_pesca', 'Pesca de supervivencia', r'''
## Anzuelo improvisado
Alfiler doblado, espina de pescado, clip, lata de gaseosa recortada.

## Línea de fondo
Varios anzuelos con carnada en una cuerda atada a una rama flexible en la orilla. Revísala mañana y tarde: pesca mientras haces otra cosa.

## Nasa o trampa de botella
Corta una botella grande, invierte la parte del pico dentro del cuerpo, pon carnada. Los peces entran y no encuentran la salida.

## Dónde
- Amanecer y atardecer.
- Pozos sombreados, debajo de troncos, remansos tras piedras.

* Carnada: lombrices, insectos, vísceras de otros peces, frutas maduras.
! Nunca comas pescado de agua contaminada por mina o fábrica, ni pescado que huela mal o tenga ojos hundidos y agallas grises.
'''),
    Article('com_conservar', 'Conservar alimentos sin nevera', r'''
## Secado
- Corta tiras finas de carne magra (sin grasa) o fruta.
- Al sol con buena ventilación y protegido de moscas (malla), o sobre el humo.
- Está lista cuando se dobla y se quiebra, sin humedad.

## Ahumado
Humo de maderas no resinosas (guayabo, por ejemplo) durante muchas horas sobre fuego bajo. Seca y protege la carne.

## Salado
Cubre la carne o el pescado completamente de sal. La sal saca el agua y frena las bacterias. Desala en agua antes de cocinar.

## Otros
- Encurtidos en vinagre.
- Mermeladas: mucha azúcar conserva la fruta.
- Tubérculos (papa, yuca sin pelar) en lugar fresco y oscuro; la yuca se daña en 2–3 días después de cosechada, así que cosecha lo que vas a comer.
- Granos secos en recipientes cerrados contra gorgojos y ratones.

! Latas hinchadas, que chorrean, abolladas en la costura o que huelen mal: bótalas. El botulismo es mortal.
'''),
    Article('com_cocinar', 'Cocinar con poco combustible', r'''
- Remoja granos (fríjol, lenteja) desde la noche anterior: reduce a la mitad el tiempo de cocción.
- Tapa siempre la olla.
- "Caja de calor": hierve 5–10 minutos, luego mete la olla tapada en una caja o hueco rodeada de cobijas, paja o ropa. Se termina de cocinar sola durante horas.
- Cocina solar: caja forrada con papel aluminio, olla negra, tapa de vidrio.
- Estufa "rocket": tubo en L que quema poca leña con mucha eficiencia.
'''),
  ],
  quiz: [
    Question('Qué combinación da proteína completa:',
        ['Arroz + fríjol', 'Azúcar + sal', 'Agua + panela', 'Papa + yuca'], 0,
        'Cereales + legumbres se complementan en aminoácidos.'),
    Question('¿Cuál insecto evitar?',
        ['Grillo', 'Hormiga culona', 'Oruga peluda de colores', 'Termita'], 2,
        'Colores brillantes y pelos suelen indicar toxinas o irritantes.'),
    Question('Una lata hinchada debe...',
        ['Hervirse más tiempo', 'Botarse', 'Comerse rápido', 'Guardarse'], 1,
        'Puede tener botulismo, que es mortal.'),
    Question('La "caja de calor" sirve para...',
        ['Enfriar comida', 'Terminar de cocinar sin gastar combustible', 'Guardar agua', 'Secar ropa'], 1,
        'El calor retenido sigue cocinando sin fuego.'),
  ],
);

// =====================================================================
// PLANTAS Y FRUTAS
// =====================================================================
const plantas = Category(
  id: 'plantas',
  name: 'Frutas y plantas',
  icon: Icons.eco_outlined,
  summary: 'Qué se come, qué mata y cómo reconocerlo (Colombia y trópico).',
  articles: [
    Article('pla_reglas', 'Reglas de oro con plantas silvestres', r'''
! Si no estás 100 % seguro de qué planta es, NO te la comas. Muchas plantas mortales se parecen a plantas comestibles.

## Señales de peligro (evitar)
- Savia lechosa o blanca (con excepciones conocidas como la papaya o el higo).
- Olor a almendras amargas o a durazno al romperla.
- Hojas en grupos de tres.
- Frutos de colores muy brillantes que no conoces.
- Semillas dentro de vainas desconocidas.
- Hongos: NUNCA los comas sin un experto. Los más mortales parecen inocentes.

## Prioriza lo que conoces
Frutas cultivadas abandonadas (fincas, solares, parques) son mucho más seguras que plantas silvestres desconocidas.

## Prueba de comestibilidad universal (último recurso)
Solo si no hay otra opción y la planta es abundante. Tarda casi un día por cada parte de la planta:
1. Ayuna 8 horas. Prueba una sola parte (hoja, raíz, fruto) de una sola planta.
2. Frota en la muñeca 15 min. Si hay ardor o sarpullido, descarta.
3. Pon un trozo en el labio 3 min, luego en la lengua 15 min sin tragar.
4. Mastica y mantén en la boca 15 min sin tragar.
5. Traga un poco y espera 8 horas sin comer nada más.
6. Si no hay síntomas, come ¼ de taza cocida y espera otras 8 horas.
! Esta prueba NO es segura contra todas las toxinas (algunas actúan días después). Es un último recurso.
'''),
    Article('pla_frutas', 'Frutas comunes de Colombia', r'''
Estas frutas son fáciles de identificar y aparecen en fincas, solares y orillas de caminos.

## Clima cálido (0–1.000 m)
@ mango, guayaba, papaya, guanabana, coco, platano, maracuya, mamoncillo, borojo, chontaduro
- Mango: árbol grande, frutos colgantes. La cáscara puede irritar la piel de algunas personas.
- Guayaba: corteza lisa que se descascara, color canela. Fruto verde/amarillo con olor fuerte. Las hojas en té ayudan con la diarrea.
- Papaya: tronco sin ramas, hojas grandes en la copa, frutos pegados al tronco.
- Guanábana: fruto verde con "espinas" blandas, pulpa blanca. No comas las semillas.
- Coco: agua estéril dentro del coco verde; pulpa rica en grasa.
- Plátano y banano: también se come la flor (bellota) cocida.
- Maracuyá: enredadera, fruto amarillo, pulpa ácida con semillas.
- Mamoncillo: racimos de bolitas verdes. Cuidado: los niños se atoran con la semilla.
- Borojó (Pacífico): fruto marrón muy nutritivo.
- Chontaduro (palma con espinas): siempre COCIDO; crudo irrita.

## Clima templado y frío (1.000–3.000 m)
@ mora, lulo, tomate_arbol, uchuva, granadilla, aguacate
- Mora de Castilla: zarza con espinas, frutos negros/rojos.
- Lulo: hojas grandes con espinas moradas, fruto naranja peludo.
- Tomate de árbol: arbusto, frutos rojos/naranjas ovalados.
- Uchuva: arbusto, fruto amarillo dentro de un "capuchón" de papel. ¡Solo el fruto maduro!
- Curuba y granadilla: enredaderas del género pasiflora.
- Feijoa, aguacate, cítricos (naranja, mandarina, limón).

* Las frutas maduras tienen más azúcar y menos toxinas que las verdes.
'''),
    Article('pla_toxicas', 'Plantas peligrosas en Colombia', r'''
! Aprende a reconocer estas plantas. Pueden matar o dejar lesiones graves.
@ manzanillo, borrachero, higuerilla, adelfa, chocho, cicuta, dieffenbachia, amanita_phalloides

- Manzanillo de playa (costa Caribe y Pacífica): árbol con frutos que parecen manzanitas verdes. Fruto, savia y hasta la lluvia que gotea de sus hojas causan quemaduras graves. Nunca te refugies debajo ni quemes su madera.
- Borrachero o cacao sabanero (Brugmansia): flores grandes en forma de trompeta colgando, blancas, amarillas o rosadas. Muy tóxico: delirios, parálisis, muerte.
- Higuerilla (ricino): hojas grandes palmeadas, frutos con espinas blandas. Sus semillas contienen ricina, mortal.
- Yuca brava: contiene cianuro. La yuca dulce se puede comer cocida, pero si no sabes cuál es, pélala, rállala, remójala y cocínala muy bien. Nunca la comas cruda.
- Semillas de durazno, manzana, cereza: contienen compuestos de cianuro; no las tritures ni comas en cantidad.
- Hojas y tallos de papa, tomate y papas verdes o germinadas: solanina. Quita lo verde.
- Dieffenbachia (planta de jardín de hojas manchadas): inflama la boca y la garganta.
- Hongos silvestres: muchos son mortales. No.

## Si alguien se envenena
- No induzcas el vómito si está somnoliento o tragó algo corrosivo.
- Guarda una muestra de la planta.
- Si hay carbón activado y está consciente, puede ayudar.
- Hidratación y vigilancia de la respiración.
'''),
    Article('pla_medicinales', 'Plantas medicinales tradicionales', r'''
Estas plantas se usan tradicionalmente para molestias leves. No reemplazan a un médico.
@ manzanilla, hierbabuena, sabila, calendula, jengibre, limoncillo, llanten, toronjil, eucalipto

- Manzanilla: té para nervios, cólicos y digestión.
- Hierbabuena / menta: dolor de estómago, gases, náuseas.
- Sábila (aloe vera): el gel interior calma quemaduras leves y raspones.
- Caléndula: en compresas para pequeñas heridas e irritaciones de piel.
- Jengibre: náuseas y mareo.
- Ajo: antibacteriano suave.
- Hojas de guayaba: té para la diarrea.
- Limoncillo: té relajante.
- Eucalipto: vapor para la congestión (no tragar el aceite).

! Ninguna planta cura infecciones graves, neumonía o fiebres altas. Embarazadas y niños pequeños: evita remedios sin consejo experto.
'''),
  ],
  quiz: [
    Question('¿Qué árbol de la costa causa quemaduras incluso con el agua que gotea de sus hojas?',
        ['Mango', 'Manzanillo', 'Guayabo', 'Coco'], 1,
        'El manzanillo (Hippomane mancinella) es uno de los árboles más tóxicos del mundo.'),
    Question('El chontaduro se debe comer...',
        ['Crudo', 'Cocido', 'Con la semilla', 'Verde'], 1,
        'Crudo irrita; cocido es nutritivo.'),
    Question('Flores grandes de trompeta colgantes (borrachero) son...',
        ['Comestibles', 'Medicinales seguras', 'Muy tóxicas', 'Buenas para té'], 2,
        'Brugmansia causa delirio, parálisis y puede matar.'),
    Question('¿Qué hacer con hongos silvestres que no conoces?',
        ['Cocinarlos bien', 'Probar uno pequeño', 'No comerlos', 'Comerlos con sal'], 2,
        'Los hongos mortales no se vuelven seguros al cocinarlos.'),
    Question('El agua de un coco verde es...',
        ['Peligrosa', 'Prácticamente estéril y potable', 'Salada', 'Venenosa'], 1,
        'El agua dentro de un coco sano está sellada y es segura.'),
  ],
);
