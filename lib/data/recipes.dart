import 'package:flutter/material.dart';

import '../core/i18n.dart';
import 'library.dart' show norm;

/// Texto en los tres idiomas.
typedef T3 = (String, String, String);
String t3(T3 t) => tr(t.$1, t.$2, t.$3);

class Ingredient {
  final T3 name;

  /// Palabras (sin tildes, minúsculas) que la identifican en el nombre de una provisión.
  final List<String> keys;
  const Ingredient(this.name, this.keys);
}

const ingredients = <String, Ingredient>{
  'agua': Ingredient(('agua', 'water', 'água'), ['agua', 'water']),
  'arroz': Ingredient(('arroz', 'rice', 'arroz'), ['arroz', 'rice']),
  'frijol': Ingredient(('fríjol', 'beans', 'feijão'), ['frijol', 'frejol', 'poroto', 'caraota', 'habichuela', 'alubia', 'bean', 'feijao']),
  'lenteja': Ingredient(('lenteja o garbanzo', 'lentils or chickpeas', 'lentilha ou grão-de-bico'),
      ['lenteja', 'lentil', 'lentilha', 'garbanzo', 'chickpea', 'grao', 'arveja', 'ervilha', 'split pea']),
  'maiz': Ingredient(('harina de maíz', 'corn flour', 'farinha de milho'),
      ['harina de maiz', 'harina pan', 'masarepa', 'arepa', 'cornmeal', 'corn flour', 'fuba', 'polenta', 'flocao', 'farinha de milho']),
  'harina': Ingredient(('harina de trigo', 'wheat flour', 'farinha de trigo'), ['harina', 'flour', 'farinha']),
  'avena': Ingredient(('avena', 'oats', 'aveia'), ['avena', 'oat', 'oats', 'oatmeal', 'aveia']),
  'pasta': Ingredient(('pasta', 'pasta', 'macarrão'), ['pasta', 'fideo', 'espagueti', 'spaghetti', 'macarron', 'noodle', 'macarrao', 'tallarin']),
  'aceite': Ingredient(('aceite o grasa', 'oil or fat', 'óleo ou gordura'),
      ['aceite', 'oil', 'oleo', 'manteca', 'mantequilla', 'butter', 'lard', 'banha', 'manteiga', 'margarina', 'ghee']),
  'sal': Ingredient(('sal', 'salt', 'sal'), ['sal', 'salt']),
  'azucar': Ingredient(('azúcar, panela o miel', 'sugar or honey', 'açúcar, rapadura ou mel'),
      ['azucar', 'panela', 'sugar', 'acucar', 'miel', 'honey', 'mel', 'rapadura', 'bocadillo']),
  'lata': Ingredient(('lata de atún, sardina o carne', 'canned tuna, sardines or meat', 'lata de atum, sardinha ou carne'),
      ['atun', 'sardina', 'tuna', 'sardine', 'atum', 'sardinha', 'caballa', 'mackerel', 'salchicha', 'spam', 'corned', 'salsicha', 'jamonilla', 'enlatad', 'canned']),
  'pescado': Ingredient(('pescado fresco', 'fresh fish', 'peixe fresco'),
      ['pescado', 'pez', 'peces', 'fish', 'peixe', 'tilapia', 'trucha', 'bocachico', 'mojarra', 'bagre', 'cachama', 'trout', 'catfish']),
  'ave': Ingredient(('pollo o gallina', 'chicken or hen', 'frango ou galinha'),
      ['pollo', 'gallina', 'chicken', 'hen', 'frango', 'galinha', 'pato', 'duck', 'pavo', 'codorniz']),
  'carne': Ingredient(('carne fresca', 'fresh meat', 'carne fresca'),
      ['carne', 'meat', 'res', 'cerdo', 'pollo', 'chicken', 'beef', 'pork', 'frango', 'porco', 'venado', 'conejo']),
  'papa': Ingredient(('papa', 'potato', 'batata'), ['papa', 'papas', 'patata', 'potato', 'batata']),
  'yuca': Ingredient(('yuca', 'cassava', 'mandioca'), ['yuca', 'mandioca', 'cassava', 'aipim', 'macaxeira']),
  'platano': Ingredient(('plátano', 'plantain', 'banana-da-terra'), ['platano', 'plantain', 'banano', 'banana']),
  'huevo': Ingredient(('huevos', 'eggs', 'ovos'), ['huevo', 'egg', 'eggs', 'ovo', 'ovos']),
  'leche': Ingredient(('leche (o en polvo)', 'milk (or powdered)', 'leite (ou em pó)'), ['leche', 'milk', 'leite']),
  'verdura': Ingredient(('verduras', 'vegetables', 'verduras'),
      ['cebolla', 'ajo', 'tomate', 'zanahoria', 'repollo', 'ahuyama', 'onion', 'garlic', 'tomato', 'carrot', 'cabbage', 'pumpkin', 'cebola', 'alho', 'cenoura', 'abobora', 'verdura', 'vegetal', 'vegetable', 'legume']),
  'caldo': Ingredient(('cubo de caldo', 'stock cube', 'caldo em cubo'), ['caldo', 'cubo', 'bouillon', 'stock']),
  'limon': Ingredient(('limón o naranja', 'lemon or orange', 'limão ou laranja'), ['limon', 'lemon', 'lime', 'limao', 'naranja', 'orange', 'laranja']),
};

class Recipe {
  final String id;
  final IconData icon;
  final T3 name;
  final T3 time;

  /// Ingredientes necesarios; 'a|b' = sirve cualquiera de los dos.
  final List<String> needs;
  final List<String> optional;
  final List<T3> steps;
  final T3? tip;
  const Recipe(this.id, this.icon, this.name, this.time, this.needs, this.steps, {this.optional = const [], this.tip});

  String get cat => recipeCat[id] ?? 'otros';
}

const recipes = <Recipe>[
  Recipe('arroz_grano', Icons.rice_bowl, ('Arroz con fríjol o lenteja', 'Rice with beans or lentils', 'Arroz com feijão ou lentilha'),
      ('1–2 h (lenteja: 40 min)', '1–2 h (lentils: 40 min)', '1–2 h (lentilha: 40 min)'), [
    'arroz', 'frijol|lenteja', 'agua'
  ], [
    ('Remoja el fríjol en agua toda la noche (la lenteja no lo necesita). Bota esa agua.',
        'Soak the beans in water overnight (lentils don\'t need it). Throw that water away.',
        'Deixe o feijão de molho a noite toda (a lentilha não precisa). Jogue essa água fora.'),
    ('Cocina el fríjol tapado en agua nueva hasta que esté blando (1–2 h). Lenteja: 25 minutos. Sal al final.',
        'Cook the beans covered in fresh water until soft (1–2 h). Lentils: 25 minutes. Salt at the end.',
        'Cozinhe o feijão tampado em água nova até ficar macio (1–2 h). Lentilha: 25 minutos. Sal no final.'),
    ('Arroz: 1 taza de arroz por 2 de agua y sal. Cuando hierva, fuego mínimo y tapado 20 minutos.',
        'Rice: 1 cup of rice to 2 of water and salt. When it boils, lowest heat and covered for 20 minutes.',
        'Arroz: 1 xícara de arroz para 2 de água e sal. Quando ferver, fogo mínimo e tampado por 20 minutos.'),
    ('Sirve juntos. Con aceite y verduras, mejor.', 'Serve together. With oil and vegetables, even better.', 'Sirva juntos. Com óleo e verduras, melhor.'),
  ], optional: [
    'sal', 'aceite', 'verdura'
  ], tip: (
    'Arroz + legumbre = proteína completa, casi como la carne.',
    'Rice + legumes = complete protein, almost like meat.',
    'Arroz + leguminosa = proteína completa, quase como carne.'
  )),
  Recipe('arepas', Icons.circle, ('Arepas', 'Arepas (corn cakes)', 'Arepas (bolinhos de milho)'), ('20 min', '20 min', '20 min'), [
    'maiz', 'agua'
  ], [
    ('2 tazas de harina de maíz precocida, 2 ½ de agua tibia y una pizca de sal.', '2 cups of precooked corn flour, 2 ½ of warm water and a pinch of salt.',
        '2 xícaras de farinha de milho pré-cozida, 2 ½ de água morna e uma pitada de sal.'),
    ('Amasa 2 minutos y deja reposar 5.', 'Knead for 2 minutes and let it rest 5.', 'Amasse por 2 minutos e deixe descansar 5.'),
    ('Haz bolas, aplástalas a 1 cm de grosor.', 'Make balls and flatten them to 1 cm thick.', 'Faça bolas e achate-as até 1 cm de espessura.'),
    ('Sartén, lata o piedra plana caliente: 6–8 minutos por lado hasta que suenen huecas.',
        'Hot pan, tin or flat stone: 6–8 minutes per side until they sound hollow.', 'Frigideira, lata ou pedra plana quente: 6–8 minutos de cada lado até soarem ocas.'),
  ], optional: [
    'sal', 'aceite'
  ]),
  Recipe('pan_sarten', Icons.bakery_dining, ('Pan de sartén (tortillas)', 'Skillet flatbread', 'Pão de frigideira'), ('20 min', '20 min', '20 min'), [
    'harina', 'agua'
  ], [
    ('2 tazas de harina, ¾ de taza de agua y sal. Una cucharada de aceite si hay.', '2 cups of flour, ¾ cup of water and salt. A spoonful of oil if you have it.',
        '2 xícaras de farinha, ¾ de xícara de água e sal. Uma colher de óleo se tiver.'),
    ('Amasa hasta que no se pegue y deja reposar 10 minutos tapado.', 'Knead until it doesn\'t stick and let it rest 10 minutes covered.',
        'Amasse até não grudar e deixe descansar 10 minutos coberto.'),
    ('Divide en bolitas y estíralas delgadas con una botella.', 'Divide into small balls and roll them thin with a bottle.', 'Divida em bolinhas e abra fino com uma garrafa.'),
    ('Sartén seca y caliente: 1–2 minutos por lado, hasta que se infle con manchas doradas.',
        'Dry hot pan: 1–2 minutes per side, until it puffs up with golden spots.', 'Frigideira seca e quente: 1–2 minutos de cada lado, até inflar com manchas douradas.'),
  ], optional: [
    'sal', 'aceite'
  ], tip: (
    'No necesita horno ni levadura y gasta muy poco combustible.',
    'Needs no oven or yeast and uses very little fuel.',
    'Não precisa de forno nem fermento e gasta pouquíssimo combustível.'
  )),
  Recipe('pan_palo', Icons.local_fire_department, ('Pan de fogata (en palo o brasas)', 'Campfire bread (on a stick or embers)', 'Pão de fogueira (no palito ou brasas)'),
      ('15 min', '15 min', '15 min'), [
    'harina', 'agua'
  ], [
    ('Masa firme: harina, poca agua, sal y algo de azúcar o aceite si hay.', 'Firm dough: flour, a little water, salt and some sugar or oil if you have it.',
        'Massa firme: farinha, pouca água, sal e um pouco de açúcar ou óleo se tiver.'),
    ('Enrolla una tira de masa en un palo verde sin corteza (no uses ramas venenosas como el baladre).',
        'Wrap a strip of dough around a green stick without bark (don\'t use poisonous branches like oleander).',
        'Enrole uma tira de massa num palito verde sem casca (não use galhos venenosos como a espirradeira).'),
    ('Ásalo sobre BRASAS, no sobre llama, girando, 10–15 minutos.', 'Roast it over EMBERS, not flame, turning, 10–15 minutes.',
        'Asse sobre BRASAS, não na chama, girando, 10–15 minutos.'),
    ('O ponla aplanada directo sobre las brasas y sacude la ceniza.', 'Or lay it flat right on the embers and shake off the ash.',
        'Ou coloque achatada direto nas brasas e sacuda a cinza.'),
  ], optional: [
    'sal', 'azucar', 'aceite'
  ]),
  Recipe('galleta_dura', Icons.cookie, ('Galleta de supervivencia (dura años)', 'Hardtack (lasts years)', 'Biscoito de sobrevivência (dura anos)'),
      ('3 h a fuego bajo', '3 h on low heat', '3 h em fogo baixo'), [
    'harina', 'agua', 'sal'
  ], [
    ('3 tazas de harina, 1 taza de agua y 1 cucharadita de sal. Masa muy dura y seca.', '3 cups of flour, 1 cup of water and 1 teaspoon of salt. Very stiff, dry dough.',
        '3 xícaras de farinha, 1 de água e 1 colher de chá de sal. Massa muito dura e seca.'),
    ('Estira a 1 cm, corta cuadros de 8 cm y hazles huecos con un clavo o tenedor.', 'Roll to 1 cm, cut 8 cm squares and poke holes with a nail or fork.',
        'Abra a 1 cm, corte quadrados de 8 cm e fure com um prego ou garfo.'),
    ('Hornea a fuego bajo 3 horas, volteando a la mitad (o en olla tapada sobre brasas).', 'Bake on low heat for 3 hours, flipping halfway (or in a covered pot over embers).',
        'Asse em fogo baixo por 3 horas, virando na metade (ou em panela tampada sobre brasas).'),
    ('Deben quedar secas por completo. Guárdalas en un recipiente cerrado.', 'They must be completely dry. Store them in a closed container.',
        'Devem ficar totalmente secos. Guarde num recipiente fechado.'),
  ], tip: (
    'Muy duras: remójalas en sopa, café o agua antes de comer.',
    'Very hard: soak them in soup, coffee or water before eating.',
    'Muito duros: amoleça em sopa, café ou água antes de comer.'
  )),
  Recipe('avena', Icons.breakfast_dining, ('Avena caliente', 'Hot oatmeal', 'Mingau de aveia'), ('10 min', '10 min', '10 min'), [
    'avena', 'agua|leche'
  ], [
    ('1 taza de avena por 2 de agua o leche.', '1 cup of oats to 2 of water or milk.', '1 xícara de aveia para 2 de água ou leite.'),
    ('Cocina revolviendo 5–10 minutos.', 'Cook while stirring for 5–10 minutes.', 'Cozinhe mexendo por 5–10 minutos.'),
    ('Endulza con panela, azúcar o miel; una pizca de sal.', 'Sweeten with sugar or honey; a pinch of salt.', 'Adoce com rapadura, açúcar ou mel; uma pitada de sal.'),
  ], optional: [
    'azucar', 'sal'
  ], tip: (
    'Para ahorrar combustible: déjala en remojo desde la noche y solo caliéntala.',
    'To save fuel: soak it overnight and just warm it up.',
    'Para economizar combustível: deixe de molho desde a noite e só esquente.'
  )),
  Recipe('sopa_pasta', Icons.soup_kitchen, ('Sopa de pasta con lata', 'Pasta soup with canned food', 'Sopa de macarrão com enlatado'), ('20 min', '20 min', '20 min'), [
    'pasta', 'lata', 'agua'
  ], [
    ('Hierve 1 litro de agua por cada 2 personas, con sal o cubo de caldo.', 'Boil 1 liter of water per 2 people, with salt or a stock cube.',
        'Ferva 1 litro de água para cada 2 pessoas, com sal ou caldo em cubo.'),
    ('Agrega verduras picadas si hay (primero las más duras).', 'Add chopped vegetables if you have them (hardest first).', 'Junte verduras picadas se tiver (as mais duras primeiro).'),
    ('Echa la pasta y cocina 10 minutos.', 'Add the pasta and cook for 10 minutes.', 'Coloque o macarrão e cozinhe 10 minutos.'),
    ('Al final, la lata con su líquido (tiene grasa y sabor).', 'At the end, add the can with its liquid (it has fat and flavor).', 'No final, a lata com o líquido (tem gordura e sabor).'),
  ], optional: [
    'sal', 'caldo', 'verdura'
  ]),
  Recipe('arroz_lata', Icons.set_meal, ('Arroz con atún o sardina', 'Rice with tuna or sardines', 'Arroz com atum ou sardinha'), ('25 min', '25 min', '25 min'), [
    'arroz', 'lata', 'agua'
  ], [
    ('Si hay aceite, sofríe la verdura picada 2 minutos.', 'If you have oil, fry chopped vegetables for 2 minutes.', 'Se tiver óleo, refogue a verdura picada por 2 minutos.'),
    ('Agrega el arroz, 2 veces su volumen de agua y sal.', 'Add the rice, twice its volume of water and salt.', 'Junte o arroz, o dobro do volume de água e sal.'),
    ('Fuego mínimo, tapado, 20 minutos.', 'Lowest heat, covered, 20 minutes.', 'Fogo mínimo, tampado, 20 minutos.'),
    ('Mezcla la lata al final y deja tapado 5 minutos.', 'Mix in the can at the end and leave covered 5 minutes.', 'Misture a lata no final e deixe tampado 5 minutos.'),
  ], optional: [
    'aceite', 'verdura', 'sal'
  ]),
  Recipe('sopa_lenteja', Icons.ramen_dining, ('Sopa espesa de lentejas', 'Thick lentil soup', 'Sopa grossa de lentilha'), ('40 min', '40 min', '40 min'), [
    'lenteja', 'agua'
  ], [
    ('Lava la lenteja y quita piedritas.', 'Wash the lentils and remove small stones.', 'Lave a lentilha e tire as pedrinhas.'),
    ('1 taza por 4 de agua; con verdura y papa si hay.', '1 cup to 4 of water; with vegetables and potato if you have them.', '1 xícara para 4 de água; com verdura e batata se tiver.'),
    ('Cocina tapado 25–35 minutos. Sal al final.', 'Cook covered for 25–35 minutes. Salt at the end.', 'Cozinhe tampado 25–35 minutos. Sal no final.'),
  ], optional: [
    'sal', 'verdura', 'papa', 'aceite'
  ]),
  Recipe('sancocho', Icons.local_dining, ('Sancocho / cocido de lo que haya', 'Stew of whatever you have', 'Cozido do que tiver'), ('45 min', '45 min', '45 min'), [
    'papa|yuca|platano', 'agua'
  ], [
    ('Pela y corta en trozos papa, yuca o plátano verde.', 'Peel and chop potato, cassava or green plantain.', 'Descasque e corte batata, mandioca ou banana-da-terra verde.'),
    ('Ponlos en agua fría con sal (y la carne si hay, que va primero).', 'Put them in cold water with salt (and the meat if any, which goes first).',
        'Coloque em água fria com sal (e a carne se tiver, que vai primeiro).'),
    ('Cocina tapado hasta que estén blandos: 30–40 minutos.', 'Cook covered until soft: 30–40 minutes.', 'Cozinhe tampado até amolecer: 30–40 minutos.'),
    ('Agrega verduras y caldo los últimos 10 minutos.', 'Add vegetables and stock for the last 10 minutes.', 'Junte verduras e caldo nos últimos 10 minutos.'),
  ], optional: [
    'sal', 'carne', 'verdura', 'caldo'
  ], tip: (
    '⚠ La yuca siempre bien cocida: cruda puede ser tóxica.',
    '⚠ Always cook cassava well: raw it can be toxic.',
    '⚠ A mandioca sempre bem cozida: crua pode ser tóxica.'
  )),
  Recipe('platano_asado', Icons.outdoor_grill, ('Plátano asado', 'Roasted plantain', 'Banana-da-terra assada'), ('20 min', '20 min', '20 min'), [
    'platano'
  ], [
    ('Con cáscara, ponlo sobre las brasas.', 'With the peel on, put it on the embers.', 'Com casca, coloque sobre as brasas.'),
    ('Voltea cada 5 minutos hasta que la cáscara esté negra: 15–20 minutos.', 'Turn every 5 minutes until the peel is black: 15–20 minutes.',
        'Vire a cada 5 minutos até a casca ficar preta: 15–20 minutos.'),
    ('Ábrelo y come la pulpa con sal o queso.', 'Open it and eat the flesh with salt or cheese.', 'Abra e coma a polpa com sal ou queijo.'),
  ], optional: [
    'sal'
  ], tip: (
    'No gasta olla ni agua: ideal cuando el agua escasea.',
    'Needs no pot or water: ideal when water is scarce.',
    'Não gasta panela nem água: ideal quando falta água.'
  )),
  Recipe('huevos', Icons.egg, ('Huevos revueltos con lo que haya', 'Scrambled eggs with whatever you have', 'Ovos mexidos com o que tiver'), ('10 min', '10 min', '10 min'), [
    'huevo'
  ], [
    ('Calienta un poco de grasa. Sofríe verdura o lata si hay.', 'Heat a little fat. Fry vegetables or canned food if you have it.', 'Aqueça um pouco de gordura. Refogue verdura ou enlatado se tiver.'),
    ('Bate los huevos con sal, échalos y revuelve hasta que cuajen bien.', 'Beat the eggs with salt, pour them in and stir until fully set.',
        'Bata os ovos com sal, coloque e mexa até firmarem bem.'),
    ('Sirve con arroz, arepa o pan.', 'Serve with rice, arepa or bread.', 'Sirva com arroz, arepa ou pão.'),
  ], optional: [
    'aceite', 'sal', 'verdura', 'lata'
  ], tip: (
    'Sin nevera: un huevo que flota en agua está dañado.',
    'No fridge: an egg that floats in water has gone bad.',
    'Sem geladeira: ovo que boia na água está estragado.'
  )),
  Recipe('pure', Icons.dinner_dining, ('Puré de papa', 'Mashed potatoes', 'Purê de batata'), ('30 min', '30 min', '30 min'), [
    'papa', 'agua'
  ], [
    ('Cocina la papa en trozos con sal 20 minutos.', 'Boil the potato in chunks with salt for 20 minutes.', 'Cozinhe a batata em pedaços com sal por 20 minutos.'),
    ('Escurre y aplasta con un tenedor o botella.', 'Drain and mash with a fork or bottle.', 'Escorra e amasse com um garfo ou garrafa.'),
    ('Mezcla leche, aceite o mantequilla si hay.', 'Mix in milk, oil or butter if you have it.', 'Misture leite, óleo ou manteiga se tiver.'),
  ], optional: [
    'sal', 'leche', 'aceite'
  ]),
  Recipe('arroz_leche', Icons.icecream, ('Arroz con leche (energía)', 'Rice pudding (energy)', 'Arroz-doce (energia)'), ('40 min', '40 min', '40 min'), [
    'arroz', 'leche', 'azucar'
  ], [
    ('1 taza de arroz en 2 de agua, 10 minutos.', '1 cup of rice in 2 of water, 10 minutes.', '1 xícara de arroz em 2 de água, 10 minutos.'),
    ('Agrega 4 tazas de leche (o leche en polvo con agua) y cocina a fuego bajo revolviendo 25 minutos.',
        'Add 4 cups of milk (or powdered milk with water) and cook on low heat, stirring, for 25 minutes.',
        'Junte 4 xícaras de leite (ou leite em pó com água) e cozinhe em fogo baixo mexendo por 25 minutos.'),
    ('Endulza al final. Canela o clavos si hay.', 'Sweeten at the end. Cinnamon or cloves if you have them.', 'Adoce no final. Canela ou cravo se tiver.'),
  ], optional: [
    'agua'
  ]),
  Recipe('charqui', Icons.kebab_dining, ('Carne seca (charqui)', 'Dried meat (jerky)', 'Carne-seca (charque)'), ('2–3 días', '2–3 days', '2–3 dias'), [
    'carne', 'sal'
  ], [
    ('Quita TODA la grasa y corta tiras delgadas (½ cm) a lo largo de la fibra.', 'Remove ALL the fat and cut thin strips (½ cm) along the grain.',
        'Tire TODA a gordura e corte tiras finas (½ cm) no sentido da fibra.'),
    ('Cubre bien con sal y deja 2–4 horas. Sacude el exceso.', 'Cover well with salt and leave 2–4 hours. Shake off the excess.', 'Cubra bem com sal e deixe 2–4 horas. Sacuda o excesso.'),
    ('Cuelga al sol y al viento, o sobre humo de fogata, protegida de moscas, 2–3 días.',
        'Hang in sun and wind, or over campfire smoke, protected from flies, for 2–3 days.',
        'Pendure ao sol e ao vento, ou sobre fumaça de fogueira, protegida das moscas, por 2–3 dias.'),
    ('Está lista cuando se dobla y se quiebra sin estar húmeda por dentro.', 'It is ready when it bends and cracks without being moist inside.',
        'Está pronta quando dobra e racha sem estar úmida por dentro.'),
  ], tip: (
    'Así la carne dura semanas sin nevera. Si huele mal o tiene moho, no la comas.',
    'This way meat lasts weeks without a fridge. If it smells bad or has mold, don\'t eat it.',
    'Assim a carne dura semanas sem geladeira. Se cheirar mal ou tiver mofo, não coma.'
  )),
  Recipe('suero', Icons.local_drink, ('Suero oral (diarrea, calor, deshidratación)', 'Oral rehydration (diarrhea, heat, dehydration)', 'Soro caseiro (diarreia, calor, desidratação)'),
      ('5 min', '5 min', '5 min'), [
    'agua', 'azucar', 'sal'
  ], [
    ('1 litro de agua potable (hervida y fría).', '1 liter of safe water (boiled and cooled).', '1 litro de água potável (fervida e fria).'),
    ('6 cucharaditas rasas de azúcar y ½ cucharadita rasa de sal.', '6 level teaspoons of sugar and ½ level teaspoon of salt.', '6 colheres de chá rasas de açúcar e ½ colher de chá rasa de sal.'),
    ('Mezcla y bebe a sorbos frecuentes. Un poco de limón mejora el sabor.', 'Mix and drink in frequent sips. A little lemon improves the taste.',
        'Misture e beba em goles frequentes. Um pouco de limão melhora o sabor.'),
  ], optional: [
    'limon'
  ], tip: (
    'Debe saber como lágrimas, no más salado. Desecha lo que sobre a las 24 h.',
    'It should taste like tears, not saltier. Throw away what\'s left after 24 h.',
    'Deve ter gosto de lágrima, não mais salgado. Descarte o que sobrar após 24 h.'
  )),
  // ------------------------- PESCADOS -------------------------
  Recipe('pescado_brasa', Icons.set_meal, ('Pescado a la brasa', 'Fish over embers', 'Peixe na brasa'), ('25 min', '25 min', '25 min'), [
    'pescado'
  ], [
    ('Quita las escamas raspando de la cola a la cabeza con el lomo del cuchillo.', 'Scrape off the scales from tail to head with the back of the knife.',
        'Tire as escamas raspando da cauda para a cabeça com o dorso da faca.'),
    ('Abre la panza desde el ano hasta las agallas, saca las tripas y las agallas, y lava por dentro.',
        'Slit the belly from the vent to the gills, remove guts and gills, and rinse inside.',
        'Abra a barriga do ânus até as guelras, tire as tripas e as guelras e lave por dentro.'),
    ('Haz 2–3 cortes en cada lado, frota sal (y limón si hay).', 'Make 2–3 cuts on each side and rub with salt (and lemon if you have it).',
        'Faça 2–3 cortes de cada lado e esfregue sal (e limão se tiver).'),
    ('Sobre una parrilla de palos verdes o una piedra, encima de BRASAS: 5–8 minutos por lado según el grosor.',
        'On a grill of green sticks or a stone, over EMBERS: 5–8 minutes per side depending on thickness.',
        'Numa grelha de paus verdes ou numa pedra, sobre BRASAS: 5–8 minutos de cada lado conforme a espessura.'),
    ('Está listo cuando la carne es blanca, opaca y se separa del hueso con un tenedor.', 'It is done when the flesh is white, opaque and comes off the bone with a fork.',
        'Está pronto quando a carne fica branca, opaca e solta do osso com um garfo.'),
  ], optional: [
    'sal', 'limon', 'aceite'
  ], tip: (
    'Pescado fresco: ojos brillantes, agallas rojas y carne firme. Si huele a amoníaco o está blando, NO lo comas.',
    'Fresh fish: bright eyes, red gills and firm flesh. If it smells of ammonia or is mushy, do NOT eat it.',
    'Peixe fresco: olhos brilhantes, guelras vermelhas e carne firme. Se cheirar a amoníaco ou estiver mole, NÃO coma.'
  )),
  Recipe('pescado_hoja', Icons.eco, ('Pescado envuelto en hojas', 'Fish wrapped in leaves', 'Peixe embrulhado em folhas'), ('30 min', '30 min', '30 min'), [
    'pescado'
  ], [
    ('Limpia el pescado (escamas y tripas) y sálalo.', 'Clean the fish (scales and guts) and salt it.', 'Limpe o peixe (escamas e tripas) e salgue.'),
    ('Rellena la panza con verdura picada o hierbas si hay.', 'Stuff the belly with chopped vegetables or herbs if you have them.', 'Recheie a barriga com verdura picada ou ervas se tiver.'),
    ('Envuélvelo en 2–3 capas de hoja de plátano o bijao (o papel aluminio) y amarra.', 'Wrap it in 2–3 layers of banana leaf (or foil) and tie it.',
        'Embrulhe em 2–3 camadas de folha de bananeira (ou papel-alumínio) e amarre.'),
    ('Entiérralo en las brasas 20–25 minutos.', 'Bury it in the embers for 20–25 minutes.', 'Enterre nas brasas por 20–25 minutos.'),
  ], optional: [
    'sal', 'verdura', 'limon'
  ], tip: (
    'Se cocina en su propio jugo: no se quema ni se pega y no gasta olla.',
    'It cooks in its own juices: it doesn\'t burn or stick and needs no pot.',
    'Cozinha no próprio suco: não queima, não gruda e não gasta panela.'
  )),
  Recipe('sopa_pescado', Icons.soup_kitchen, ('Caldo de pescado (no se bota nada)', 'Fish broth (nothing wasted)', 'Caldo de peixe (nada se perde)'),
      ('40 min', '40 min', '40 min'), [
    'pescado', 'agua'
  ], [
    ('Usa cabezas, espinas y colas (sin agallas ni tripas): tienen mucho sabor y grasa.', 'Use heads, bones and tails (no gills or guts): they have lots of flavor and fat.',
        'Use cabeças, espinhas e caudas (sem guelras nem tripas): têm muito sabor e gordura.'),
    ('Hierve en agua con sal 20 minutos y cuela.', 'Boil in salted water for 20 minutes and strain.', 'Ferva em água com sal por 20 minutos e coe.'),
    ('Agrega papa, yuca o plátano en trozos y cocina 20 minutos más.', 'Add chunks of potato, cassava or plantain and cook 20 more minutes.',
        'Junte pedaços de batata, mandioca ou banana-da-terra e cozinhe mais 20 minutos.'),
    ('Al final, los trozos de pescado: 5 minutos bastan.', 'At the end, the fish pieces: 5 minutes is enough.', 'No final, os pedaços de peixe: 5 minutos bastam.'),
  ], optional: [
    'sal', 'papa', 'yuca', 'platano', 'verdura'
  ]),
  Recipe('pescado_seco', Icons.wb_sunny, ('Pescado salado y ahumado (para guardar)', 'Salted and smoked fish (to store)', 'Peixe salgado e defumado (para guardar)'),
      ('1–3 días', '1–3 days', '1–3 dias'), [
    'pescado', 'sal'
  ], [
    ('Limpia y abre el pescado en mariposa (plano), quitando la espina central.', 'Clean and butterfly the fish (open flat), removing the backbone.',
        'Limpe e abra o peixe em borboleta (aberto), tirando a espinha central.'),
    ('Cúbrelo de sal por ambos lados y déjalo 6–12 horas. Sacude la sal.', 'Cover both sides with salt and leave 6–12 hours. Shake off the salt.',
        'Cubra os dois lados com sal e deixe 6–12 horas. Sacuda o sal.'),
    ('Cuélgalo sobre humo frío de leña (no llama) o al sol y viento, protegido de moscas, hasta que esté duro y seco.',
        'Hang it over cool wood smoke (not flame) or in sun and wind, protected from flies, until hard and dry.',
        'Pendure sobre fumaça fria de lenha (não chama) ou ao sol e vento, protegido de moscas, até ficar duro e seco.'),
    ('Antes de comer, remójalo en agua 12 horas cambiando el agua.', 'Before eating, soak it in water for 12 hours, changing the water.',
        'Antes de comer, deixe de molho por 12 horas trocando a água.'),
  ], tip: (
    'Bien seco dura semanas. Si aparece moho o mal olor, se bota.',
    'Well dried it lasts weeks. If mold or a bad smell appears, throw it out.',
    'Bem seco dura semanas. Se aparecer mofo ou mau cheiro, jogue fora.'
  )),
  // ------------------------- PASTAS -------------------------
  Recipe('pasta_casera', Icons.ramen_dining, ('Pasta casera (fideos a mano)', 'Homemade pasta (hand-made noodles)', 'Massa caseira (macarrão à mão)'),
      ('1 h', '1 h', '1 h'), [
    'harina', 'huevo|agua'
  ], [
    ('Con huevo: 1 taza de harina por cada huevo. Sin huevo: 2 tazas de harina, ½ taza de agua y una cucharada de aceite.',
        'With egg: 1 cup of flour per egg. Without egg: 2 cups of flour, ½ cup of water and a spoonful of oil.',
        'Com ovo: 1 xícara de farinha por ovo. Sem ovo: 2 xícaras de farinha, ½ xícara de água e uma colher de óleo.'),
    ('Haz un volcán de harina, pon el huevo o el agua en el centro y mezcla con un tenedor. Amasa 8–10 minutos hasta que esté lisa.',
        'Make a flour well, put the egg or water in the center and mix with a fork. Knead 8–10 minutes until smooth.',
        'Faça um vulcão de farinha, coloque o ovo ou a água no centro e misture com um garfo. Amasse 8–10 minutos até ficar lisa.'),
    ('Tápala y déjala reposar 30 minutos.', 'Cover it and let it rest 30 minutes.', 'Cubra e deixe descansar 30 minutos.'),
    ('Estírala muy delgada con una botella, enharina, enróllala y córtala en tiras.', 'Roll it very thin with a bottle, flour it, roll it up and cut into strips.',
        'Abra bem fino com uma garrafa, polvilhe farinha, enrole e corte em tiras.'),
    ('Cocina en agua hirviendo con sal 2–4 minutos. Seca al aire lo que sobre para guardarlo.', 'Cook in boiling salted water for 2–4 minutes. Air-dry the rest to store it.',
        'Cozinhe em água fervente com sal por 2–4 minutos. Seque ao ar o que sobrar para guardar.'),
  ], optional: [
    'sal', 'aceite'
  ]),
  Recipe('pasta_salsa', Icons.dinner_dining, ('Pasta con salsa de lo que haya', 'Pasta with whatever-you-have sauce', 'Macarrão com molho do que tiver'),
      ('20 min', '20 min', '20 min'), [
    'pasta', 'agua'
  ], [
    ('Hierve bastante agua con sal; echa la pasta y revuelve. 8–12 minutos (prueba un fideo).', 'Boil plenty of salted water; add the pasta and stir. 8–12 minutes (taste one).',
        'Ferva bastante água com sal; coloque o macarrão e mexa. 8–12 minutos (prove um).'),
    ('Antes de escurrir, guarda una taza del agua de cocción.', 'Before draining, save a cup of the cooking water.', 'Antes de escorrer, guarde uma xícara da água do cozimento.'),
    ('Salsa: sofríe en aceite cebolla, ajo y tomate picados; agrega la lata (atún, sardina, salchicha) si hay.',
        'Sauce: fry chopped onion, garlic and tomato in oil; add the can (tuna, sardines, sausage) if you have it.',
        'Molho: refogue no óleo cebola, alho e tomate picados; junte a lata (atum, sardinha, salsicha) se tiver.'),
    ('Mezcla la pasta con la salsa y un poco del agua guardada para que quede jugosa.', 'Mix the pasta with the sauce and a little of the saved water so it stays moist.',
        'Misture o macarrão com o molho e um pouco da água guardada para ficar suculento.'),
  ], optional: [
    'sal', 'aceite', 'verdura', 'lata'
  ], tip: (
    'Para ahorrar gas: hierve 2 minutos, apaga, tapa y deja 10 minutos; la pasta se cocina sola.',
    'To save fuel: boil 2 minutes, turn off, cover and leave 10 minutes; the pasta cooks by itself.',
    'Para economizar gás: ferva 2 minutos, desligue, tampe e deixe 10 minutos; o macarrão cozinha sozinho.'
  )),
  // ------------------------- CARNES -------------------------
  Recipe('carne_brasa', Icons.outdoor_grill, ('Carne asada en brasas', 'Meat grilled over embers', 'Carne assada na brasa'), ('20–40 min', '20–40 min', '20–40 min'), [
    'carne'
  ], [
    ('Corta trozos de 2–3 cm de grosor; sálalos justo antes de asar.', 'Cut 2–3 cm thick pieces; salt them just before grilling.', 'Corte pedaços de 2–3 cm de espessura; salgue logo antes de assar.'),
    ('Espera a que el fuego sea BRASA blanca (sin llama): la llama quema por fuera y deja crudo por dentro.',
        'Wait until the fire is white EMBERS (no flame): flame burns the outside and leaves the inside raw.',
        'Espere o fogo virar BRASA branca (sem chama): a chama queima por fora e deixa cru por dentro.'),
    ('Parrilla o palos verdes a un palmo de las brasas. Voltea pocas veces.', 'Grill or green sticks a hand-span above the embers. Turn only a few times.',
        'Grelha ou paus verdes a um palmo das brasas. Vire poucas vezes.'),
    ('Cerdo, pollo y carne de monte: hasta que el jugo salga claro, sin nada rosado. Res: puede quedar algo rosada si es fresca.',
        'Pork, chicken and wild game: until the juice runs clear, no pink. Beef: can stay a little pink if fresh.',
        'Porco, frango e caça: até o suco sair claro, sem nada rosado. Boi: pode ficar um pouco rosado se for fresca.'),
  ], optional: [
    'sal', 'limon'
  ], tip: (
    'La carne de monte (caza) SIEMPRE bien cocida: puede tener parásitos.',
    'Wild game ALWAYS well done: it can carry parasites.',
    'Carne de caça SEMPRE bem passada: pode ter parasitas.'
  )),
  Recipe('carne_guisada', Icons.local_dining, ('Carne guisada (ablanda cortes duros)', 'Braised meat (softens tough cuts)', 'Carne ensopada (amacia cortes duros)'),
      ('1–2 h', '1–2 h', '1–2 h'), [
    'carne', 'agua'
  ], [
    ('Corta en cubos. Dóralos en poca grasa a fuego fuerte, por tandas.', 'Cut into cubes. Brown them in a little fat over high heat, in batches.',
        'Corte em cubos. Doure em pouca gordura em fogo alto, aos poucos.'),
    ('Agrega cebolla, tomate o lo que haya y sofríe 3 minutos.', 'Add onion, tomato or whatever you have and fry 3 minutes.', 'Junte cebola, tomate ou o que tiver e refogue 3 minutos.'),
    ('Cubre con agua, tapa y cocina a fuego bajo 1–2 horas hasta que se deshaga con el tenedor.', 'Cover with water, put the lid on and simmer 1–2 hours until it falls apart with a fork.',
        'Cubra com água, tampe e cozinhe em fogo baixo 1–2 horas até desmanchar com o garfo.'),
    ('Papa o yuca en los últimos 30 minutos. Sal al final.', 'Potato or cassava in the last 30 minutes. Salt at the end.', 'Batata ou mandioca nos últimos 30 minutos. Sal no final.'),
  ], optional: [
    'aceite', 'verdura', 'papa', 'yuca', 'sal', 'caldo'
  ], tip: (
    'Usa la caja de calor (olla envuelta en mantas) después del hervor: ahorra 2/3 del combustible.',
    'Use a heat-retention box (pot wrapped in blankets) after it boils: saves 2/3 of the fuel.',
    'Use a caixa térmica (panela enrolada em cobertores) depois de ferver: economiza 2/3 do combustível.'
  )),
  Recipe('gallina', Icons.restaurant, ('Pollo o gallina: limpiar y hacer caldo', 'Chicken or hen: cleaning and broth', 'Frango ou galinha: limpar e fazer caldo'),
      ('1–3 h', '1–3 h', '1–3 h'), [
    'ave', 'agua'
  ], [
    ('Sumérgela 30–60 segundos en agua muy caliente (que no hierva) y las plumas salen fácil.', 'Dip it 30–60 seconds in very hot (not boiling) water and the feathers come off easily.',
        'Mergulhe 30–60 segundos em água bem quente (sem ferver) e as penas saem fácil.'),
    ('Pela, quema los pelitos con una llama y lava.', 'Pluck, singe off the fine hairs with a flame and rinse.', 'Depene, queime os pelinhos numa chama e lave.'),
    ('Corta alrededor de la cola, saca las vísceras con cuidado de no romper la hiel (bolsita verde) ni el intestino. Guarda hígado, corazón y molleja.',
        'Cut around the tail and pull out the innards carefully without breaking the gall bladder (green sac) or the gut. Keep liver, heart and gizzard.',
        'Corte em volta da cauda e tire as vísceras com cuidado para não romper o fel (bolsinha verde) nem o intestino. Guarde fígado, coração e moela.'),
    ('Cocina en presas con agua y sal: pollo 1 hora, gallina vieja 2–3 horas. Agrega papa, yuca y verduras al final.',
        'Cook in pieces with water and salt: chicken 1 hour, old hen 2–3 hours. Add potato, cassava and vegetables at the end.',
        'Cozinhe em pedaços com água e sal: frango 1 hora, galinha velha 2–3 horas. Junte batata, mandioca e verduras no final.'),
  ], optional: [
    'sal', 'papa', 'yuca', 'verdura', 'caldo'
  ], tip: (
    'Lava manos, cuchillo y tabla con jabón después de tocar pollo crudo.',
    'Wash hands, knife and board with soap after handling raw chicken.',
    'Lave mãos, faca e tábua com sabão depois de mexer em frango cru.'
  )),
];

/// Grupo de cada receta (para filtrar).
const recipeCat = <String, String>{
  'arroz_grano': 'granos', 'sopa_lenteja': 'granos', 'arroz_lata': 'granos', 'arroz_leche': 'granos',
  'arepas': 'masas', 'pan_sarten': 'masas', 'pan_palo': 'masas', 'galleta_dura': 'masas', 'avena': 'masas',
  'sopa_pasta': 'pastas', 'pasta_casera': 'pastas', 'pasta_salsa': 'pastas',
  'carne_brasa': 'carnes', 'carne_guisada': 'carnes', 'gallina': 'carnes', 'charqui': 'carnes', 'huevos': 'carnes',
  'pescado_brasa': 'pescados', 'pescado_hoja': 'pescados', 'sopa_pescado': 'pescados', 'pescado_seco': 'pescados',
  'sancocho': 'tuberculos', 'platano_asado': 'tuberculos', 'pure': 'tuberculos',
  'suero': 'otros',
};

const recipeCats = ['granos', 'masas', 'pastas', 'carnes', 'pescados', 'tuberculos', 'otros'];

String recipeCatLabel(String c) => switch (c) {
      'granos' => tr('Granos', 'Grains', 'Grãos'),
      'masas' => tr('Panes y masas', 'Breads', 'Pães e massas'),
      'pastas' => tr('Pastas', 'Pasta', 'Massas'),
      'carnes' => tr('Carnes y huevos', 'Meat and eggs', 'Carnes e ovos'),
      'pescados' => tr('Pescados', 'Fish', 'Peixes'),
      'tuberculos' => tr('Papa, yuca, plátano', 'Potato, cassava, plantain', 'Batata, mandioca, banana'),
      _ => tr('Salud', 'Health', 'Saúde'),
    };

/// ¿Tengo este ingrediente en la despensa (cantidad > 0)?
bool hasIngredient(String id, List<Map<String, dynamic>> pantry) {
  final ing = ingredients[id];
  if (ing == null) return false;
  for (final it in pantry) {
    final q = it['qty'];
    if (q is num && q <= 0) continue;
    if (id == 'agua' && it['cat'] == 'Agua') return true;
    final name = norm('${it['name'] ?? ''}');
    final words = name.split(RegExp(r'[^a-z0-9]+')).where((w) => w.isNotEmpty).toList();
    for (final k in ing.keys) {
      if (k.contains(' ')) {
        if (name.contains(k)) return true;
      } else if (words.any((w) => w == k || (k.length >= 4 && w.startsWith(k)))) {
        return true;
      }
    }
  }
  return false;
}

String groupLabel(String g) => g.split('|').map((e) => ingredients[e] == null ? e : t3(ingredients[e]!.name)).join(tr(' o ', ' or ', ' ou '));

/// Recetas ordenadas: primero las que puedes hacer con lo que tienes.
List<(Recipe, List<String>, List<String>)> rankRecipes(List<Map<String, dynamic>> pantry) {
  final out = <(Recipe, List<String>, List<String>)>[];
  for (final r in recipes) {
    final have = <String>[], miss = <String>[];
    for (final g in r.needs) {
      (g.split('|').any((e) => hasIngredient(e, pantry)) ? have : miss).add(g);
    }
    out.add((r, have, miss));
  }
  out.sort((a, b) => a.$3.length != b.$3.length ? a.$3.length.compareTo(b.$3.length) : b.$2.length.compareTo(a.$2.length));
  return out;
}
