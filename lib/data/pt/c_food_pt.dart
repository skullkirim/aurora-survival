import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// COMIDA
// =====================================================================
const comidaPt = Category(
  id: 'comida',
  name: 'Comida',
  icon: Icons.restaurant_outlined,
  summary: 'Rações, pesca, insetos e conservação de alimentos.',
  articles: [
    Article('com_raciones', 'Rações e nutrição', r'''
## Calorias
- Adulto em repouso: umas 1.800–2.000 kcal/dia. Com trabalho físico: 2.500–3.500.
- Dá para sobreviver semanas com muito menos, mas a força e o juízo caem.

## Priorize
- Carboidratos: arroz, rapadura, banana-da-terra, mandioca, batata, aveia, milho.
- Proteína: feijão, lentilha, grão-de-bico, ovo, peixe, atum em lata.
- Gordura (mais energia por grama): óleo, amendoim, coco, abacate.
- Sal: indispensável com calor e suor.

## Despensa de emergência (dura anos)
Arroz branco, lentilha, feijão seco, rapadura, sal, mel, aveia, óleo, enlatados, amendoim. Faça rodízio: o mais velho primeiro.

* Combinar arroz + feijão ou milho + feijão dá proteína completa.
! Se tiver pouca água, coma pouco e evite alimentos salgados ou ricos em proteína: aumentam a sede.
'''),
    Article('com_insectos', 'Insetos comestíveis', r'''
Os insetos são uma das proteínas mais abundantes e fáceis de obter. Na Colômbia a formiga tanajura (hormiga culona) é uma iguaria tradicional.

## Geralmente seguros (sempre cozidos)
@ hormiga_culona, mojojoy, lombriz
- Tanajuras, gafanhotos e grilos (tire patas e asas).
- Larvas de besouro de troncos podres (como o "mojojoy" amazônico).
- Cupins.
- Minhocas (deixe purgando em água limpa algumas horas antes).

## Evite
- Insetos de cores muito vivas ou com mau cheiro.
- Insetos peludos (lagartas).
- Moscas, carrapatos, mosquitos (transmitem doenças).
- Aranhas, centopeias e escorpiões.

! Cozinhe sempre os insetos: torrados ou fervidos. Você elimina parasitas.
'''),
    Article('com_pesca', 'Pesca de sobrevivência', r'''
## Anzol improvisado
Alfinete dobrado, espinha de peixe, clipe, lata de refrigerante recortada.

## Linha de fundo
Vários anzóis com isca numa corda amarrada a um galho flexível na margem. Confira de manhã e à tarde: pesca enquanto você faz outra coisa.

## Covo ou armadilha de garrafa
Corte uma garrafa grande, inverta a parte do gargalo dentro do corpo e ponha isca. Os peixes entram e não acham a saída.

## Onde
- Amanhecer e entardecer.
- Poços sombreados, debaixo de troncos, remansos atrás de pedras.

* Isca: minhocas, insetos, vísceras de outros peixes, frutas maduras.
! Nunca coma peixe de água contaminada por mina ou fábrica, nem peixe com mau cheiro, olhos fundos e guelras cinzentas.
'''),
    Article('com_conservar', 'Conservar alimentos sem geladeira', r'''
## Secagem
- Corte tiras finas de carne magra (sem gordura) ou fruta.
- Ao sol com boa ventilação e protegido de moscas (tela), ou sobre a fumaça.
- Está pronta quando dobra e racha, sem umidade.

## Defumação
Fumaça de madeiras não resinosas (goiabeira, por exemplo) durante muitas horas sobre fogo baixo. Seca e protege a carne.

## Salga
Cubra a carne ou o peixe completamente com sal. O sal tira a água e freia as bactérias. Dessalgue na água antes de cozinhar.

## Outros
- Conservas em vinagre.
- Geleias: muito açúcar conserva a fruta.
- Tubérculos (batata, mandioca sem descascar) em lugar fresco e escuro; a mandioca estraga 2–3 dias após a colheita, então colha o que vai comer.
- Grãos secos em recipientes fechados contra carunchos e ratos.

! Latas estufadas, vazando, amassadas na costura ou com mau cheiro: jogue fora. O botulismo é mortal.
'''),
    Article('com_cocinar', 'Cozinhar com pouco combustível', r'''
- Deixe os grãos (feijão, lentilha) de molho desde a noite anterior: corta pela metade o tempo de cozimento.
- Tampe sempre a panela.
- "Caixa térmica": ferva 5–10 minutos, depois coloque a panela tampada numa caixa ou buraco rodeada de cobertores, palha ou roupa. Termina de cozinhar sozinha durante horas.
- Fogão solar: caixa forrada com papel-alumínio, panela preta, tampa de vidro.
- Fogão "rocket": tubo em L que queima pouca lenha com muita eficiência.
'''),
  ],
  quiz: [
    Question('Que combinação dá proteína completa:',
        ['Arroz + feijão', 'Açúcar + sal', 'Água + rapadura', 'Batata + mandioca'], 0,
        'Cereais + leguminosas se complementam em aminoácidos.'),
    Question('Que inseto evitar?',
        ['Grilo', 'Tanajura', 'Lagarta peluda colorida', 'Cupim'], 2,
        'Cores vivas e pelos costumam indicar toxinas ou irritantes.'),
    Question('Uma lata estufada deve...',
        ['Ser fervida mais tempo', 'Ser jogada fora', 'Ser comida rápido', 'Ser guardada'], 1,
        'Pode ter botulismo, que é mortal.'),
    Question('A "caixa térmica" serve para...',
        ['Esfriar comida', 'Terminar de cozinhar sem gastar combustível', 'Guardar água', 'Secar roupa'], 1,
        'O calor retido continua cozinhando sem fogo.'),
  ],
);

// =====================================================================
// FRUTAS E PLANTAS
// =====================================================================
const plantasPt = Category(
  id: 'plantas',
  name: 'Frutas e plantas',
  icon: Icons.eco_outlined,
  summary: 'O que se come, o que mata e como reconhecer (trópico).',
  articles: [
    Article('pla_reglas', 'Regras de ouro com plantas silvestres', r'''
! Se não tiver 100 % de certeza de qual planta é, NÃO coma. Muitas plantas mortais se parecem com plantas comestíveis.

## Sinais de perigo (evitar)
- Seiva leitosa ou branca (com exceções conhecidas como o mamão ou o figo).
- Cheiro de amêndoa amarga ou de pêssego ao quebrar.
- Folhas em grupos de três.
- Frutos de cores muito vivas que você não conhece.
- Sementes dentro de vagens desconhecidas.
- Cogumelos: NUNCA coma sem um especialista. Os mais mortais parecem inocentes.

## Priorize o que você conhece
Frutas cultivadas abandonadas (sítios, quintais, parques) são muito mais seguras que plantas silvestres desconhecidas.

## Teste universal de comestibilidade (último recurso)
Só se não houver outra opção e a planta for abundante. Leva quase um dia para cada parte da planta:
1. Jejue 8 horas. Teste uma só parte (folha, raiz, fruto) de uma só planta.
2. Esfregue no pulso 15 min. Se arder ou der irritação, descarte.
3. Ponha um pedaço no lábio 3 min, depois na língua 15 min sem engolir.
4. Mastigue e mantenha na boca 15 min sem engolir.
5. Engula um pouco e espere 8 horas sem comer mais nada.
6. Se não houver sintomas, coma ¼ de xícara cozida e espere mais 8 horas.
! Este teste NÃO é seguro contra todas as toxinas (algumas agem dias depois). É um último recurso.
'''),
    Article('pla_frutas', 'Frutas comuns da Colômbia e do trópico', r'''
Estas frutas são fáceis de identificar e aparecem em sítios, quintais e beiras de estrada.

## Clima quente (0–1.000 m)
@ mango, guayaba, papaya, guanabana, coco, platano, maracuya, mamoncillo, borojo, chontaduro
- Manga: árvore grande, frutos pendurados. A casca pode irritar a pele de algumas pessoas.
- Goiaba: casca lisa que descasca, cor canela. Fruto verde/amarelo de cheiro forte. As folhas em chá ajudam na diarreia.
- Mamão: tronco sem galhos, folhas grandes na copa, frutos grudados ao tronco.
- Graviola: fruto verde com "espinhos" moles, polpa branca. Não coma as sementes.
- Coco: água estéril dentro do coco verde; polpa rica em gordura.
- Banana e banana-da-terra: também se come a flor (o "coração") cozida.
- Maracujá: trepadeira, fruto amarelo, polpa ácida com sementes.
- Pitomba-das-antilhas (mamoncillo): cachos de bolinhas verdes. Cuidado: as crianças engasgam com o caroço.
- Borojó (Pacífico): fruto marrom muito nutritivo.
- Pupunha (palmeira com espinhos): sempre COZIDA; crua irrita.

## Clima temperado e frio (1.000–3.000 m)
@ mora, lulo, tomate_arbol, uchuva, granadilla, aguacate
- Amora-silvestre: arbusto com espinhos, frutos pretos/vermelhos.
- Lulo (naranjilla): folhas grandes com espinhos roxos, fruto laranja peludo.
- Tamarilho (tomate-de-árvore): arbusto, frutos vermelhos/laranja ovais.
- Fisális: arbusto, fruto amarelo dentro de um "capuz" de papel. Só o fruto maduro!
- Curuba e granadilha: trepadeiras do gênero passiflora.
- Feijoa, abacate, cítricos (laranja, tangerina, limão).

* As frutas maduras têm mais açúcar e menos toxinas que as verdes.
'''),
    Article('pla_toxicas', 'Plantas perigosas', r'''
! Aprenda a reconhecer estas plantas. Podem matar ou deixar lesões graves.
@ manzanillo, borrachero, higuerilla, adelfa, chocho, cicuta, dieffenbachia, amanita_phalloides

- Mancenilheira (costas do Caribe e Pacífico): árvore com frutos que parecem maçãzinhas verdes. Fruto, seiva e até a chuva que pinga das folhas causam queimaduras graves. Nunca se abrigue embaixo dela nem queime sua madeira.
- Trombeteira (Brugmansia): flores grandes em forma de trombeta penduradas, brancas, amarelas ou rosadas. Muito tóxica: delírios, paralisia, morte.
- Mamona (rícino): folhas grandes palmadas, frutos com espinhos moles. As sementes contêm ricina, mortal.
- Mandioca-brava: contém cianeto. A mandioca mansa (aipim) se come cozida, mas se não souber qual é, descasque, rale, deixe de molho e cozinhe muito bem. Nunca coma crua.
- Sementes de pêssego, maçã, cereja: contêm compostos de cianeto; não triture nem coma em quantidade.
- Folhas e talos de batata, tomate e batatas verdes ou brotadas: solanina. Tire o verde.
- Comigo-ninguém-pode (Dieffenbachia, planta de jardim de folhas manchadas): inflama a boca e a garganta.
- Cogumelos silvestres: muitos são mortais. Não.

## Se alguém se envenenar
- Não provoque vômito se estiver sonolento ou engoliu algo corrosivo.
- Guarde uma amostra da planta.
- Se houver carvão ativado e a pessoa estiver consciente, pode ajudar.
- Hidratação e vigilância da respiração.
'''),
    Article('pla_medicinales', 'Plantas medicinais tradicionais', r'''
Estas plantas são usadas tradicionalmente para incômodos leves. Não substituem um médico.
@ manzanilla, hierbabuena, sabila, calendula, jengibre, limoncillo, llanten, toronjil, eucalipto

- Camomila: chá para nervos, cólicas e digestão.
- Hortelã / menta: dor de estômago, gases, náusea.
- Babosa (aloe vera): o gel interno acalma queimaduras leves e arranhões.
- Calêndula: em compressas para pequenas feridas e irritações de pele.
- Gengibre: náusea e enjoo.
- Alho: antibacteriano suave.
- Folhas de goiabeira: chá para a diarreia.
- Capim-limão: chá relaxante.
- Eucalipto: vapor para a congestão (não engolir o óleo).

! Nenhuma planta cura infecções graves, pneumonia ou febres altas. Grávidas e crianças pequenas: evitem remédios sem conselho especializado.
'''),
  ],
  quiz: [
    Question('Que árvore da costa causa queimaduras até com a água que pinga das folhas?',
        ['Mangueira', 'Mancenilheira', 'Goiabeira', 'Coqueiro'], 1,
        'A mancenilheira (Hippomane mancinella) é uma das árvores mais tóxicas do mundo.'),
    Question('A pupunha deve ser comida...',
        ['Crua', 'Cozida', 'Com a semente', 'Verde'], 1,
        'Crua irrita; cozida é nutritiva.'),
    Question('Flores grandes de trombeta penduradas (trombeteira) são...',
        ['Comestíveis', 'Medicinais seguras', 'Muito tóxicas', 'Boas para chá'], 2,
        'A Brugmansia causa delírio, paralisia e pode matar.'),
    Question('O que fazer com cogumelos silvestres que você não conhece?',
        ['Cozinhar bem', 'Provar um pequeno', 'Não comer', 'Comer com sal'], 2,
        'Os cogumelos mortais não ficam seguros ao cozinhar.'),
    Question('A água de um coco verde é...',
        ['Perigosa', 'Praticamente estéril e potável', 'Salgada', 'Venenosa'], 1,
        'A água dentro de um coco são está selada e é segura.'),
  ],
);
