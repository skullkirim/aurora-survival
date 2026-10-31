import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// HIGIENE Y BOTIQUÍN CASERO
// =====================================================================
const higiene = Category(
  id: 'higiene',
  name: 'Higiene y botiquín casero',
  icon: Icons.sanitizer_outlined,
  summary: 'Jabón, desinfectantes, gel, suero, esterilizar y vacunas: lo que sí se puede hacer en casa.',
  articles: [
    Article('hig_manos', 'Higiene que salva vidas', r'''
La diarrea y las infecciones matan más gente en los desastres que el hambre. Casi todas se evitan con agua limpia, jabón y una letrina lejos del agua.

## Lavarse las manos
- Con agua y jabón 20 segundos (lo que dura cantar "Feliz cumpleaños" dos veces): palmas, dorso, entre dedos, uñas.
- Siempre: después del baño, antes de cocinar y comer, después de tocar carne cruda, heridas, basura o animales.
- Sin jabón: ceniza de leña frotada con agua también limpia.
* Haz un "grifo de lata": un bidón colgado con un hueco tapado con un palito. Gasta poquísima agua.

## Agua y comida
- Agua para beber y cepillarse: hervida, clorada o filtrada.
- Tapa la comida y el agua: moscas y cucarachas llevan microbios.
- La basura lejos y tapada o enterrada.

## Dientes y cuerpo
- Cepillo de ramita masticada (guayabo, limón) si no hay cepillo; bicarbonato o sal en lugar de crema.
- Toallas higiénicas de tela: lavarlas con jabón, secarlas al sol y guardarlas limpias.
- Ropa interior y medias secas cada día: evitan hongos.
! Una sola persona con diarrea puede contagiar a todo el grupo: que use su propio vaso y lave muy bien sus manos.
'''),
    Article('hig_jabon', 'Jabón casero con ceniza y grasa', r'''
Es el jabón de las abuelas: lejía de ceniza + grasa. Sirve para manos, ropa y lavar heridas por fuera.

## 1. Lejía de ceniza
- Usa ceniza BLANCA de madera dura (no de papel, plástico ni carbón comprado).
- Balde con huecos abajo, una capa de piedritas y paja, y encima la ceniza.
- Echa agua de lluvia caliente poco a poco y recoge el líquido que gotea (marrón).
- Vuelve a pasarlo por la ceniza hasta que una pluma de gallina se deshaga o un huevo flote en él: ya es fuerte.
! La lejía QUEMA piel y ojos. Guantes, gafas o tela en la cara, y lejos de niños. Si salpica: mucha agua 15 minutos.

## 2. Cocinar el jabón
- Derrite y cuela grasa (sebo de res, manteca de cerdo o aceite). Cantidad aproximada: 2 partes de grasa por 1 de lejía.
- En olla de hierro o barro (no aluminio), mezcla y hierve a fuego bajo revolviendo con palo durante 1–3 horas.
- Está listo cuando espesa como natilla y una gota se enfría firme.
- Un puñado de sal al final ayuda a que endurezca.

## 3. Curar
- Vierte en moldes (cajas, cáscaras de coco) y deja 4 semanas en lugar seco.
* Prueba: si arde o pica en la piel, aún tiene mucha lejía. Déjalo más tiempo o úsalo solo para ropa.
'''),
    Article('hig_desinfectar', 'Desinfectantes: cloro, alcohol y vinagre', r'''
## Cloro (blanqueador común, 5 %)
- Superficies, baños, utensilios: 1 cucharada (10 ml) por litro de agua.
- Sangre, vómito, diarrea: 1 parte de cloro por 9 de agua.
- Agua para beber: 2 gotas por litro (4 si está turbia), espera 30 minutos.
- Prepara la mezcla cada día: con el tiempo y el sol pierde fuerza.
- Primero limpia la suciedad con agua y jabón; el cloro no funciona sobre mugre.
! NUNCA mezcles cloro con amoníaco, vinagre, ácidos ni alcohol: se forman gases tóxicos que pueden matar. Úsalo solo con agua y en lugares ventilados.

## Alcohol
- Funciona al 60–80 %. El alcohol de 96° se rebaja: 3 partes de alcohol por 1 de agua hervida.
- Para manos, termómetros, tijeras y pinzas limpias.
! Arde con mucha facilidad: lejos del fuego y de velas.

## Vinagre y limón
- Sirven para quitar grasa y sarro, pero NO desinfectan bien. No los uses para heridas ni para el agua de beber.

## Sol
- Ropa, sábanas y vendas lavadas y secadas al sol directo quedan mucho más limpias: la luz ultravioleta mata muchos microbios.
'''),
    Article('hig_gel', 'Gel o líquido antibacterial (fórmula de la OMS)', r'''
La Organización Mundial de la Salud publicó esta receta para lugares sin acceso a gel comercial.

## Para 1 litro
- 833 ml de alcohol etílico de 96°.
- 42 ml de agua oxigenada al 3 % (mata esporas que caigan en la botella).
- 15 ml de glicerina (protege la piel; si no hay, se puede omitir).
- Completa hasta 1 litro con agua hervida y fría.

## Cómo
- Mezcla en una botella limpia con tapa y agita.
- Deja reposar 72 horas antes de usar.
- Usa unos 3 ml y frota las manos hasta que sequen (20–30 segundos).
* Con alcohol isopropílico al 99 %: 751 ml en vez de los 833 ml.
! No sirve si las manos están sucias de tierra o grasa: ahí lava con agua y jabón. Inflamable. No se bebe.
'''),
    Article('hig_suero', 'Suero salino para lavar heridas, ojos y nariz', r'''
## Suero fisiológico casero
- 1 litro de agua hervida 1 minuto (3 minutos en tierra alta).
- 9 gramos de sal: una cucharadita colmada o cucharadita y media rasa. Sin yodo es mejor, pero sirve la común.
- Disuelve con el agua aún caliente, tapa y deja enfriar.
- Úsalo el mismo día; lo que sobre a las 24 horas se bota.

## Usos
- Lavar heridas: echa a chorro con una botella o jeringa sin aguja para arrastrar la tierra.
- Ojos con polvo o ceniza: lava desde la nariz hacia afuera.
- Nariz tapada o con polvo: unas gotas o lavado suave.
! No es para beber en lugar de agua. Para deshidratación usa el suero oral (agua, azúcar y sal) de la sección de Recetas.
* La mayoría de heridas solo necesitan lavarse muy bien con agua limpia abundante. Es lo que más evita infecciones.
'''),
    Article('hig_esterilizar', 'Esterilizar instrumentos y hacer vendas', r'''
## Instrumentos (pinzas, tijeras, agujas, cuchillo)
- Lávalos con agua y jabón y un cepillo.
- Hiérvelos 20 minutos tapados, totalmente cubiertos de agua.
- Mejor: olla a presión 15–20 minutos desde que suena (es casi un autoclave).
- Sácalos con una pinza también hervida y déjalos sobre una tela limpia, tapados.
* Pasar por llama sirve para la punta de una aguja o pinza en una emergencia, pero no esteriliza todo el instrumento.

## Vendas y gasas
- Usa sábanas o camisetas de algodón: córtalas en tiras de 5–10 cm.
- Hiérvelas 20 minutos, sécalas al sol y plánchalas con plancha bien caliente (o en olla tapada al horno).
- Guárdalas en bolsas plásticas o frascos limpios y cerrados.
- Gasas: dobla cuadros de tela de algodón en 4–8 capas.

## Botiquín improvisado
- Vendas y gasas hervidas, cinta adhesiva, tijeras, pinzas.
- Férulas: cartón, revistas enrolladas o palos.
- Torniquete: tela ancha (4–5 cm) y un palo para girar.
- Termómetro, guantes o bolsas plásticas limpias para las manos.
- Miel de abejas pura: en heridas superficiales ayuda a cicatrizar (no en bebés menores de 1 año).
! Herida roja, caliente, hinchada, con pus o rayas rojas que suben, o con fiebre: infección. Necesita antibiótico y un médico.
'''),
    Article('hig_vacunas', 'Vacunas: por qué no se hacen en casa y qué sí hacer', r'''
! Una vacuna NO se puede fabricar en casa. Hacerla necesita laboratorios estériles, cultivos controlados y pruebas de seguridad. Un intento casero no protege y puede causar infecciones graves, abscesos o la muerte. No inyectes nada hecho en casa.

## Lo que sí puedes hacer AHORA
- Ponte al día con el esquema de vacunas en tu centro de salud (en Colombia el Programa Ampliado de Inmunizaciones es gratuito).
- Tétanos (Td): un refuerzo cada 10 años. Es la más importante para heridas con tierra, clavos u óxido.
- Pregunta por: hepatitis A y B, sarampión, fiebre amarilla (zonas cálidas de Colombia), influenza, y rabia si trabajas con animales.
- Guarda el carné de vacunas de toda la familia en una bolsa plástica con los documentos.

## Si tienes vacunas guardadas
- Casi todas se conservan entre 2 °C y 8 °C. Sin nevera: olla de barro dentro de otra con arena mojada (se enfría al evaporar), a la sombra.
- No se congelan, no al sol. Si cambian de color o tienen grumos, no sirven.

## Sin vacuna, prevención
- Tétanos: lava toda herida con agua y jabón a fondo y quita la tierra. Las heridas profundas y sucias necesitan médico.
- Rabia: si un animal muerde o araña, lava 15 minutos con agua y jabón y busca atención; la vacuna después de la mordida salva la vida.
- Sarampión, gripe y covid: aislar al enfermo, ventilar y lavar manos.
- Hepatitis A, cólera y tifoidea: agua hervida o clorada y comida bien cocida.
'''),
  ],
  quiz: [
    Question('¿Qué NUNCA se mezcla con cloro?', ['Agua', 'Amoníaco o vinagre', 'Agua de lluvia', 'Nada, todo se puede'], 1,
        'Se forman gases tóxicos. El cloro solo se mezcla con agua.'),
    Question('¿Cuánta sal lleva 1 litro de suero salino para heridas?', ['Una pizca', 'Unos 9 gramos', 'Medio paquete', 'Nada'], 1,
        'Unos 9 g (una cucharadita colmada) por litro de agua hervida.'),
    Question('¿Cómo se esterilizan unas pinzas?', ['Soplándolas', 'Con vinagre', 'Hirviéndolas 20 minutos', 'Al sol 5 minutos'], 2,
        'Lavar y hervir 20 minutos (u olla a presión).'),
    Question('¿Se puede fabricar una vacuna en casa?', ['Sí, con suero', 'Sí, con ajo', 'No: es peligroso y no protege', 'Solo la del tétanos'], 2,
        'Se necesitan laboratorios estériles. Lo que sí sirve: vacunarse antes y lavar bien las heridas.'),
  ],
);
