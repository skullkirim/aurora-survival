import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// PRIMEROS AUXILIOS
// =====================================================================
const primerosAuxilios = Category(
  id: 'auxilios',
  name: 'Primeros auxilios',
  icon: Icons.medical_services_outlined,
  summary: 'Salvar vidas sin hospital: RCP, sangrado, quemaduras, fracturas.',
  articles: [
    Article('aux_prioridades', 'Evaluar una emergencia (PAS y XABCDE)', r'''
## Regla PAS
- Proteger: asegúrate de que la zona es segura para ti y para la víctima. Un rescatista herido es una víctima más.
- Avisar: si existe cualquier forma de pedir ayuda (radio, otras personas), hazlo ya.
- Socorrer: solo después de lo anterior.

## Orden de revisión XABCDE
- X – Hemorragia eXanguinante: un sangrado masivo mata en minutos. Se controla primero.
- A – Vía aérea: ¿habla? ¿hay algo en la boca? Inclina la cabeza y eleva el mentón.
- B – Respiración: mira, escucha y siente durante máximo 10 segundos.
- C – Circulación: busca otros sangrados, piel fría y pálida, pulso débil (shock).
- D – Déficit neurológico: ¿responde? ¿pupilas iguales? ¿mueve brazos y piernas?
- E – Exposición: revisa todo el cuerpo y luego abrígalo para evitar hipotermia.

* Si la persona habla con normalidad, tiene vía aérea y respira. Pasa a buscar sangrados y fracturas.
! No muevas a alguien con posible lesión de columna (caída de altura, golpe fuerte) a menos que su vida corra peligro donde está.
'''),
    Article('aux_rcp', 'RCP: reanimación cardiopulmonar', r'''
## Cuándo hacerla
La persona no responde y NO respira o solo da boqueadas irregulares.

## Adulto
1. Acuéstala boca arriba sobre superficie dura.
2. Talón de una mano en el centro del pecho (mitad inferior del esternón), la otra mano encima, brazos rectos.
3. Comprime 5 a 6 cm de profundidad, a un ritmo de 100 a 120 por minuto (el ritmo de la canción "Stayin' Alive").
4. Deja que el pecho vuelva completamente arriba entre compresiones.
5. Si sabes y puedes: 30 compresiones y 2 ventilaciones (cabeza inclinada, nariz tapada, 1 segundo cada soplo, que se vea subir el pecho).
6. Si no sabes o no quieres ventilar: solo compresiones continuas. Sigue siendo muy útil.

## Niños y bebés
- Niño: una o dos manos, profundidad aprox. 5 cm.
- Bebé: dos dedos en el centro del pecho, aprox. 4 cm.
- En niños, si estás solo, empieza con 5 ventilaciones de rescate.

* Turnaos cada 2 minutos: la calidad de las compresiones cae rápido por el cansancio.
! En un mundo sin hospital, la RCP rara vez revive a alguien sin desfibrilador. Aun así, en ahogados, electrocutados o niños puede funcionar. Hazla hasta que respire, llegue ayuda o estés agotado.
'''),
    Article('aux_hemorragia', 'Hemorragias y torniquete', r'''
## Presión directa (lo primero siempre)
1. Usa guantes o una bolsa plástica si tienes.
2. Presiona fuerte con tela limpia directamente sobre la herida, mínimo 10 minutos sin levantar para mirar.
3. Si la tela se empapa, pon más encima; no retires la primera.
4. Venda apretado para mantener la presión.

## Empaquetar una herida profunda
En heridas profundas de axila, ingle o cuello: mete tela o gasa dentro de la herida hasta llenarla y presiona encima con fuerza.

## Torniquete (solo brazos y piernas)
Úsalo si el sangrado es de un chorro o no para con presión.
- Cinta ancha de 4–5 cm (cinturón, tela). Nunca alambre ni cuerda delgada.
- Colócalo 5–8 cm por encima de la herida, nunca sobre una articulación.
- Gira un palo (molinete) hasta que el sangrado PARE. Asegura el palo.
- Anota la hora en la frente de la persona o en el torniquete.

! Un torniquete duele mucho; eso es normal. Aflojarlo sin atención médica puede causar una nueva hemorragia mortal. Se tolera bien hasta 2 horas; más allá hay riesgo de perder la extremidad.
* El shock (piel pálida, fría, sudorosa, pulso rápido, confusión): acuesta a la persona, abrígala y eleva las piernas si no hay fracturas.
'''),
    Article('aux_heridas', 'Heridas e infecciones', r'''
Sin antibióticos, una herida infectada puede matar. La limpieza es tu mejor medicina.

## Limpiar
- Lava con abundante agua potable (hervida y enfriada) a chorro. Mejor mucho volumen que poca agua "fuerte".
- Retira tierra y restos visibles con pinzas limpias (hervidas).
- Jabón alrededor de la herida, no dentro.
- No uses alcohol ni agua oxigenada dentro de heridas profundas: dañan el tejido.

## Cerrar o no cerrar
- Heridas sucias, mordeduras o de más de 6–8 horas: NO las cierres. Déjalas abiertas, cubiertas y cambia el vendaje a diario.
- Cortes limpios y recientes: puedes acercar los bordes con tiras adhesivas.

## Señales de infección
- Enrojecimiento que se expande, calor, hinchazón, pus, mal olor, fiebre, líneas rojas que suben por la extremidad.

* La miel pura tiene efecto antibacteriano y se ha usado en heridas por siglos: capa fina, cubrir, cambiar a diario.
! Líneas rojas, fiebre alta o confusión = infección extendida. Busca antibióticos o un médico a toda costa.
'''),
    Article('aux_quemaduras', 'Quemaduras', r'''
1. Aleja de la fuente de calor. Si la ropa arde: detente, tírate al suelo y rueda.
2. Enfría con agua corriente fresca (no helada) durante 20 minutos.
3. Quita anillos y relojes antes de que se hinche.
4. Cubre con plástico de cocina limpio o tela limpia húmeda, sin apretar.

## No hagas
- No pongas hielo, crema dental, mantequilla, aceite ni café.
- No revientes las ampollas.
- No despegues ropa pegada a la piel.

! Graves: quemaduras más grandes que la palma de la víctima ×10 en adultos, en cara, manos, genitales, articulaciones, o piel blanca/negra sin dolor. Dale líquidos con sales (suero oral) y vigila el shock.
'''),
    Article('aux_fracturas', 'Fracturas, esguinces y férulas', r'''
## Reconocer una fractura
Dolor intenso en un punto, deformidad, hinchazón, no puede apoyar o mover, crujido.

## Inmovilizar (férula)
- Inmoviliza la articulación de arriba y la de abajo del hueso roto.
- Rellena con tela entre la férula y la piel.
- Materiales: palos rectos, revistas enrolladas, cartón, una pierna sana atada a la herida.
- Revisa después: dedos rosados, calientes y que los sienta. Si se ponen azules o fríos, afloja.

## Fractura abierta (hueso visible)
Controla el sangrado sin presionar el hueso, cubre con tela limpia y NO intentes meterlo.

## Esguince: regla RICE
- Reposo, hielo o frío (20 min cada 2–3 h), compresión con venda, elevación.

! Solo intenta alinear una extremidad si no hay pulso más abajo de la fractura y no hay ayuda posible; tira suave y constante en línea recta.
'''),
    Article('aux_temperatura', 'Hipotermia y golpe de calor', r'''
## Hipotermia
Tiritona, torpeza, confusión, habla arrastrada. Si deja de tiritar estando frío, es grave.
- Sácalo del viento y la humedad. Quita la ropa mojada.
- Aísla del suelo (ramas, cartón, mochila).
- Abriga cabeza, cuello y tronco. Comparte calor corporal en un saco.
- Si está consciente: bebidas tibias y dulces.
! No frotes las extremidades ni lo calientes de golpe con fuego directo.

## Golpe de calor
Piel muy caliente, confusión, dolor de cabeza, vómito, puede dejar de sudar.
- Sombra inmediata, quita ropa, moja todo el cuerpo y abanica.
- Paños fríos en cuello, axilas e ingles.
- Si está consciente, agua a sorbos con un poco de sal.
! El golpe de calor es mortal. Enfriar rápido es la prioridad.
'''),
    Article('aux_suero', 'Deshidratación, diarrea y suero oral', r'''
La diarrea por agua contaminada es una de las mayores causas de muerte tras un desastre.

## Suero de rehidratación oral casero (OMS)
- 1 litro de agua potable
- 6 cucharaditas rasas de azúcar
- ½ cucharadita rasa de sal
Mezcla bien. Prueba: no debe saber más salado que las lágrimas.

## Cómo darlo
- Sorbos pequeños y frecuentes, incluso si vomita (espera 10 min y sigue).
- Adulto: después de cada deposición, 1 a 2 vasos.
- Sigue comiendo alimentos suaves (arroz, plátano cocido, caldo).

## Señales de alarma
Boca seca, no orina en 8+ horas, ojos hundidos, mareo al pararse, letargo. En bebés: fontanela hundida.

* Lávate las manos con jabón antes de comer y después del baño: corta la mayoría de contagios.
'''),
    Article('aux_mordeduras', 'Mordeduras de serpiente y picaduras', r'''
## Serpiente
@ mapana, cascabel, coral, verrugosa
1. Aléjate de la serpiente. No intentes atraparla.
2. Mantén a la persona calmada y quieta: el movimiento acelera el veneno.
3. Retira anillos, relojes y ropa apretada antes de la hinchazón.
4. Inmoviliza la extremidad a la altura del corazón o un poco por debajo.
5. Marca el borde de la hinchazón con la hora cada 30 minutos.
6. Traslado a un centro con antiveneno es lo único curativo.

## NO hagas
- No cortes, no succiones, no pongas torniquete, no hielo, no alcohol, no remedios de "rezanderos".

## Picaduras (abejas, avispas, alacranes)
- Retira el aguijón raspando con una tarjeta, no apretando.
- Frío local.
! Dificultad para respirar, hinchazón de cara/labios o desmayo tras una picadura = anafilaxia. Si hay adrenalina autoinyectable, úsala en el muslo.
'''),
    Article('aux_atragantamiento', 'Atragantamiento', r'''
## Si puede toser
Anímale a toser fuerte. No le golpees todavía.

## Si no puede hablar, toser ni respirar (adulto y niño > 1 año)
1. Ponte detrás, inclínalo hacia adelante.
2. 5 golpes fuertes entre los omóplatos con el talón de la mano.
3. 5 compresiones abdominales (Heimlich): puño entre el ombligo y el esternón, otra mano encima, tirón hacia adentro y arriba.
4. Alterna 5 y 5 hasta que salga o pierda la conciencia (entonces: RCP).

## Bebé
Boca abajo sobre tu antebrazo, 5 golpes en la espalda; luego boca arriba, 5 compresiones en el pecho con 2 dedos.
'''),
    Article('aux_botiquin', 'Botiquín de supervivencia', r'''
## Lo básico
- Gasas, vendas elásticas, esparadrapo, curitas.
- Guantes, tijeras, pinzas, termómetro.
- Torniquete o cinta ancha de 4 cm.
- Sobres de suero oral, jabón, antiséptico (yodo povidona o clorhexidina).
- Analgésicos (paracetamol, ibuprofeno), antihistamínicos, antidiarreico.
- Manta térmica, linterna, libreta y lápiz.
- Tus medicamentos personales para varias semanas.

* Revisa vencimientos cada 6 meses. Registra el botiquín en el inventario de esta app.
! Nunca tomes medicamentos de otros sin saber para qué sirven y su dosis.
'''),
  ],
  quiz: [
    Question('¿Qué se atiende primero en una víctima con un sangrado a chorro en la pierna?',
        ['La respiración', 'El sangrado', 'Las fracturas', 'La temperatura'], 1,
        'En XABCDE la X (hemorragia masiva) va primero: puede matar en minutos.'),
    Question('Ritmo correcto de compresiones en RCP:',
        ['60 por minuto', '80 por minuto', '100 a 120 por minuto', '150 por minuto'], 2,
        'Entre 100 y 120 por minuto, unos 5–6 cm de profundidad en adultos.'),
    Question('Una quemadura se enfría con...',
        ['Hielo directo', 'Crema dental', 'Agua corriente fresca 20 min', 'Aceite'], 2,
        'Agua fresca 20 minutos. Hielo, pasta dental y aceites dañan más la piel.'),
    Question('El suero oral casero lleva por litro de agua:',
        ['6 cdtas azúcar y ½ cdta sal', '1 cdta azúcar y 3 de sal', 'Solo sal', 'Solo azúcar'], 0,
        'Fórmula de la OMS: 6 cucharaditas rasas de azúcar y media de sal.'),
    Question('Ante una mordedura de serpiente debes...',
        ['Cortar y chupar', 'Poner torniquete', 'Inmovilizar y mantener calma', 'Poner hielo'], 2,
        'Inmovilizar, calmar y trasladar. Cortar, chupar o torniquete empeoran el daño.'),
    Question('¿Dónde se pone un torniquete?',
        ['Sobre la rodilla', '5–8 cm arriba de la herida', 'Justo en la herida', 'En el cuello'], 1,
        'Entre 5 y 8 cm por encima de la herida, nunca sobre una articulación.'),
  ],
);

// =====================================================================
// AGUA
// =====================================================================
const agua = Category(
  id: 'agua',
  name: 'Agua',
  icon: Icons.water_drop_outlined,
  summary: 'Encontrar, purificar y almacenar agua segura.',
  articles: [
    Article('agua_regla3', 'La regla de los 3', r'''
Una persona promedio puede sobrevivir aproximadamente:
- 3 minutos sin aire
- 3 horas sin refugio en clima extremo
- 3 días sin agua
- 3 semanas sin comida

Por eso el orden de prioridades casi siempre es: seguridad → refugio/temperatura → agua → fuego → comida.

## Cuánta agua necesitas
- Mínimo para beber: 2–3 litros por persona al día; más con calor o esfuerzo.
- Para beber + cocinar + higiene básica: unos 4 litros por persona al día.
* Usa la calculadora de raciones en Herramientas.
'''),
    Article('agua_encontrar', 'Cómo encontrar agua', r'''
## Fuentes, de mejor a peor
1. Lluvia recogida directamente en recipientes limpios (la más segura).
2. Manantiales que brotan de la roca.
3. Ríos y quebradas con corriente (toma agua arriba de cualquier asentamiento).
4. Lagos y lagunas.
5. Charcos y agua estancada (último recurso, siempre purificar).

## Pistas en el terreno
- Vegetación verde y espesa en zonas secas.
- Insectos (abejas, moscas, mosquitos) y huellas de animales convergiendo.
- Aves volando bajo y recto al amanecer o atardecer.
- Fondos de valles y la parte exterior de las curvas secas de los ríos: excava ahí.

## En la ciudad
- Tanque del sanitario (la caja de atrás, NO la taza) si no tiene químicos.
- Calentador de agua, tuberías del edificio (abre el grifo más bajo).
- Piscinas: solo para lavar, a menos que la destiles.

* El rocío de la mañana se recoge pasando un trapo por el pasto y exprimiéndolo.
'''),
    Article('agua_purificar', 'Purificar agua', r'''
## 1. Filtra primero
Pasa el agua turbia por una tela doblada o déjala reposar para que se asiente el sedimento. Las partículas protegen a los microbios.

## 2. Hervir (el método más seguro)
- Hierve a borbotones 1 minuto.
- Por encima de 2.000 m de altura (Bogotá está a 2.600 m): hierve 3 minutos.
- Deja enfriar tapada.

## 3. Cloro (blanqueador)
Usa blanqueador sin aroma, de hipoclorito de sodio al 5–6 %:
- 2 gotas por litro de agua clara.
- 4 gotas por litro si está turbia o fría.
- Mezcla y espera 30 minutos. Debe oler ligeramente a cloro. Si no, repite y espera 15 min más.

## 4. Desinfección solar (SODIS)
- Botella PET transparente de máximo 2 litros, agua clara.
- Al sol directo 6 horas (2 días si está nublado).
- Funciona bien en el trópico.

## 5. Tabletas o filtros comerciales
Sigue las instrucciones del fabricante.

! Ningún método elimina químicos, combustibles o metales pesados excepto la destilación. Evita agua cerca de minas, fábricas o con olor a combustible.
'''),
    Article('agua_filtro', 'Filtro casero de capas', r'''
Un filtro de capas aclara el agua, pero NO la vuelve potable. Después debes hervir o clorar.

## Construcción (botella cortada boca abajo)
De abajo hacia arriba:
1. Tela o algodón en el pico.
2. Carbón vegetal triturado (de tu fogata, no briquetas) — retiene olores y algunos químicos.
3. Arena fina.
4. Arena gruesa.
5. Gravilla.
6. Piedras pequeñas.

Desecha los primeros litros, que saldrán negros por el carbón.

## Destilador solar
- Cava un hoyo, pon un recipiente en el centro.
- Pon hojas verdes o agua sucia alrededor.
- Cubre con plástico, sella los bordes con tierra y pon una piedra en el centro sobre el recipiente.
- El agua evaporada se condensa y gotea limpia. Produce poco (medio litro al día aprox.), pero sirve con agua salada o contaminada.
'''),
    Article('agua_almacenar', 'Almacenar agua', r'''
- Recipientes de grado alimentario, limpios y con tapa. Nunca envases de químicos.
- Lugar fresco y oscuro: la luz favorece las algas.
- Agua del acueducto tratada dura unos 6 meses; renuévala.
- Etiqueta la fecha.
- Usa siempre un cucharón limpio: no metas las manos ni vasos usados.

* Para desinfectar el recipiente: 1 cucharadita de blanqueador por litro de agua, agita, deja 30 segundos y enjuaga.
'''),
  ],
  quiz: [
    Question('¿Cuánto tiempo hay que hervir el agua a más de 2.000 m de altura?',
        ['10 segundos', '1 minuto', '3 minutos', '30 minutos'], 2,
        'A nivel del mar basta 1 minuto; en altura el agua hierve a menor temperatura, así que se hierve 3.'),
    Question('Gotas de blanqueador al 5–6 % por litro de agua clara:',
        ['2 gotas', '10 gotas', 'Media taza', '1 cucharada'], 0,
        '2 gotas por litro (4 si está turbia o fría) y esperar 30 minutos.'),
    Question('¿Un filtro de arena y carbón deja el agua potable?',
        ['Sí, siempre', 'No, después hay que hervir o clorar', 'Solo si es de río', 'Solo de noche'], 1,
        'Aclara el agua pero no elimina todos los microbios.'),
    Question('La fuente de agua más segura en general es:',
        ['Charco', 'Lluvia recogida en recipiente limpio', 'Laguna', 'Tanque de piscina'], 1,
        'La lluvia recogida directamente es la más limpia.'),
    Question('SODIS consiste en dejar botellas PET al sol durante:',
        ['15 minutos', '6 horas', '1 semana', '1 hora'], 1,
        'Seis horas al sol directo; dos días si está nublado.'),
  ],
);

// =====================================================================
// FUEGO
// =====================================================================
const fuego = Category(
  id: 'fuego',
  name: 'Fuego',
  icon: Icons.local_fire_department_outlined,
  summary: 'Calor, luz, cocinar y purificar: encenderlo y mantenerlo.',
  articles: [
    Article('fuego_basico', 'Cómo encender un fuego', r'''
## El triángulo del fuego
Calor + combustible + oxígeno. Si falta uno, se apaga.

## Prepara TODO antes de encender
1. Yesca: material muy fino y seco que prende con una chispa (algodón, pelusa de secadora, corteza fina, hojas secas, nido de pasto seco, viruta).
2. Astillas: palitos del grosor de un fósforo a un lápiz.
3. Leña pequeña: del grosor de un dedo al de una muñeca.
4. Leña grande: para mantener.
Ten el doble de lo que crees que necesitas.

## Encender
- Haz una base seca (ramas o corteza) si el suelo está húmedo.
- Nido de yesca, enciéndela y sopla suave por la base.
- Agrega astillas en forma de tipi, luego leña progresivamente.

## Estructuras
- Tipi: rápido y caliente, ideal para empezar y hervir agua.
- Cabaña (troncos cruzados): estable, buenas brasas para cocinar.
- Estrella: troncos que se empujan al centro; ahorra leña toda la noche.

! Nunca enciendas fuego dentro de una carpa o lugar cerrado: el monóxido de carbono mata sin olor.
'''),
    Article('fuego_sinfosforos', 'Fuego sin fósforos', r'''
## Ferrocerio (pedernal moderno)
Raspa con fuerza con el lomo de un cuchillo directamente sobre la yesca. El método más confiable: funciona mojado.

## Lupa, gafas o fondo de lata
Concentra el sol en el punto más pequeño posible sobre yesca oscura. Un fondo de lata pulido con pasta dental o chocolate sirve como espejo.

## Batería y lana de acero
Frota una batería de 9 V (o dos pilas en serie) contra lana de acero fina: se pone incandescente al instante.

## Fricción (arco)
- Base de madera blanda y seca con una muesca en V.
- Eje recto de madera seca, un arco con cordón y una piedra o pieza de madera dura para presionar arriba.
- Gira rápido hasta que salga humo y se forme una brasa en la muesca; pásala al nido de yesca.
Requiere práctica: hazlo antes de necesitarlo.

* Guarda yesca seca en una bolsa hermética: algodón con vaselina arde varios minutos.
'''),
    Article('fuego_lluvia', 'Fuego con lluvia', r'''
- Busca madera muerta que aún está en los árboles (no la del suelo).
- Divide los troncos: el interior suele estar seco.
- Corteza de abedul, resina de pino y "ocote" arden aunque estén húmedos.
- Haz el fuego bajo un techo natural o una lona alta.
- Pon la leña húmeda cerca del fuego para que se seque mientras arde.
'''),
  ],
  quiz: [
    Question('Los tres elementos del triángulo del fuego son:',
        ['Calor, combustible, oxígeno', 'Leña, agua, sal', 'Sol, viento, tierra', 'Chispa, humo, ceniza'], 0,
        'Sin uno de los tres no hay fuego.'),
    Question('¿Qué se prepara antes de encender?',
        ['Solo la leña gruesa', 'Yesca, astillas y leña de varios tamaños', 'Nada', 'Agua'], 1,
        'Tener todo listo evita que la llama inicial se apague.'),
    Question('El método más confiable si todo está mojado es:',
        ['Lupa', 'Ferrocerio', 'Arco de fricción', 'Frotar piedras'], 1,
        'El ferrocerio produce chispas muy calientes incluso mojado.'),
    Question('¿Por qué no se enciende fuego dentro de la carpa?',
        ['Por el olor', 'Por el monóxido de carbono e incendio', 'No pasa nada', 'Se gasta la leña'], 1,
        'El monóxido no huele y mata; además hay riesgo de incendio.'),
  ],
);

// =====================================================================
// REFUGIO
// =====================================================================
const refugio = Category(
  id: 'refugio',
  name: 'Refugio',
  icon: Icons.cabin_outlined,
  summary: 'Protegerse del frío, la lluvia, el sol y el viento.',
  articles: [
    Article('ref_ubicacion', 'Elegir dónde refugiarse', r'''
## Busca
- Terreno algo elevado y plano, con drenaje.
- Cerca (no al lado) del agua: 50–100 m.
- Protección natural del viento: rocas, árboles.
- Materiales cerca: ramas, hojas.

## Evita
- Lechos de ríos y quebradas secas: crecidas súbitas.
- Debajo de árboles con ramas muertas ("hacedores de viudas").
- Bases de laderas inestables (derrumbes) y cimas expuestas (rayos).
- Cerca de nidos de hormigas o avispas.

* En un edificio: elige habitaciones pequeñas, interiores y en pisos bajos; son más fáciles de calentar y defender.
'''),
    Article('ref_tipos', 'Refugios sencillos', r'''
## Lean-to (cobertizo inclinado)
- Una vara horizontal entre dos árboles a la altura del pecho.
- Ramas apoyadas a un lado formando el techo.
- Cubre con hojas, palmas o lona de abajo hacia arriba, como tejas.
- Pon la fogata enfrente; una pared de troncos detrás del fuego refleja el calor.

## Refugio de hojarasca (A-frame)
- Una vara larga apoyada en un tocón: solo un poco más larga que tú.
- Costillas de ramas a los lados.
- Cubre con 60–90 cm de hojas secas. Más grueso = más caliente.
- Rellena también el interior. Te mantiene caliente sin fuego.

## Con lona o plástico
- Cuerda entre dos árboles, lona encima en forma de A, esquinas amarradas.
- Siempre aíslate del suelo: el suelo roba calor más rápido que el aire.

! Un refugio pequeño es más caliente. Solo un poco más grande que tu cuerpo.
'''),
    Article('ref_ropa', 'Ropa y temperatura', r'''
## Sistema de capas
- Capa base: sintética o lana, aleja el sudor. Evita el algodón en frío: mojado no abriga.
- Capa media: aislante (polar, lana, plumas).
- Capa externa: corta viento y lluvia.

## Reglas
- Quítate capas antes de sudar; el sudor luego te enfría.
- Cubre cabeza, cuello y manos.
- Dormir con la ropa del día siguiente dentro del saco la mantiene seca y tibia.
* Papel periódico entre capas de ropa sirve como aislante de emergencia.
'''),
  ],
  quiz: [
    Question('¿Dónde NO debes montar un refugio?',
        ['Terreno elevado', 'En el lecho de una quebrada seca', 'Protegido del viento', 'Cerca de materiales'], 1,
        'Las crecidas súbitas pueden arrastrarte.'),
    Question('¿Por qué hay que aislarse del suelo?',
        ['Por los insectos solamente', 'El suelo roba calor rápidamente', 'Es más cómodo', 'No importa'], 1,
        'La conducción con el suelo frío enfría el cuerpo muy rápido.'),
    Question('En clima frío, ¿qué tela evitar como capa base?',
        ['Lana', 'Sintética', 'Algodón', 'Polar'], 2,
        'El algodón mojado pierde casi todo su poder aislante.'),
  ],
);
