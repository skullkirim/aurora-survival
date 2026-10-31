import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// RADIAÇÃO E NUCLEAR
// =====================================================================
const radiacionPt = Category(
  id: 'radiacion',
  name: 'Radiação e nuclear',
  icon: Icons.warning_amber_rounded,
  summary: 'Bombas, acidentes nucleares, abrigo, descontaminação e iodeto.',
  articles: [
    Article('rad_que_es', 'O que é a radiação (explicado fácil)', r'''
A radiação é energia invisível que sai de materiais radioativos. Não se vê, não tem cheiro, não se sente. Em grandes doses danifica as células do corpo.

## Três tipos
- Alfa: é barrada por uma folha de papel ou pela pele. Perigosa só se você a respirar, comer ou entrar por uma ferida.
- Beta: atravessa alguns milímetros; a roupa a barra em parte. Pode queimar a pele se o pó ficar em cima.
- Gama: muito penetrante, como os raios X. Só a barra muita massa: terra, concreto, água, tijolo.

## As 3 defesas
- TEMPO: menos tempo exposto = menos dano. A chuva radioativa perde força muito rápido.
- DISTÂNCIA: cada vez que você dobra a distância da fonte, recebe 4 vezes menos.
- BLINDAGEM: ponha massa entre você e o exterior. Quanto mais pesada, melhor.

## Unidades
A dose se mede em Sievert (Sv). Como referência:
- Uma radiografia: 0,0001 Sv.
- 1 Sv de uma vez: náusea, doença leve por radiação.
- 4–5 Sv de uma vez: metade das pessoas morre sem atendimento médico.
* Um dosímetro ou contador Geiger é a única forma de medi-la. Se conseguir um, guarde como um tesouro.
'''),
    Article('rad_explosion', 'Se houver uma explosão nuclear', r'''
## No momento do clarão
1. NÃO olhe a luz: pode deixar você cego.
2. Jogue-se no chão de bruços atrás de algo sólido (muro, vala, meio-fio). Cubra cabeça e nuca com os braços, boca aberta.
3. A onda de choque chega segundos depois (1 segundo a cada 340 m de distância). Fique no chão até passar o vento e os vidros.

## Depois: ENTRE, FIQUE, INFORME-SE
- Você tem uns 10–20 minutos antes de cair o pó radioativo (parece areia, cinza ou poeira).
- Entre no prédio mais sólido por perto. Vá ao porão ou ao centro do prédio, longe de telhados e paredes externas.
- Fique dentro no mínimo 24 horas, melhor 2–3 dias, salvo se as autoridades disserem outra coisa.
- Ouça um rádio a pilha para receber instruções.

! Não saia para procurar familiares nas primeiras horas: é quando a radiação é mais alta. Combinem antes um ponto de encontro.
* Use a ferramenta "Radiação" para calcular quanto a radiação já baixou.
'''),
    Article('rad_refugio', 'Abrigo contra chuva radioativa', r'''
## O que protege mais
O que importa é a massa entre você e o pó radioativo (no telhado e no chão lá fora).

Espessura que reduz a radiação à METADE:
- Aço: 1,8 cm
- Concreto: 6 cm
- Terra compactada: 9 cm
- Água: 18 cm
- Madeira: 22 cm
Com 10 dessas espessuras (por exemplo 90 cm de terra), a radiação cai umas 1.000 vezes.

## Melhores lugares
- Porões, túneis, estacionamentos subterrâneos, estações de metrô.
- O centro de um prédio grande de concreto, andares intermediários.
- Uma vala coberta com portas ou tábuas e 60–90 cm de terra por cima.

## Melhore um abrigo improvisado
- Ponha caixas de livros, terra, galões de água ou móveis pesados contra as paredes e em cima de uma mesa onde você se abrigar.
- Ventilação: o ar pode ser movido com um abanador; o pó radioativo é pesado e quase não entra se você fechar e vedar as frestas.
- Água: 4 L por pessoa por dia; latrina de balde com sacos e tampa.
'''),
    Article('rad_descontaminar', 'Descontaminação pessoal', r'''
Se você estava lá fora quando caía o pó:
1. Antes de entrar, tire a roupa de cima: elimina até 90 % da contaminação. Coloque num saco fechado longe das pessoas.
2. Tome banho com água e sabão; lave o cabelo com xampu. NÃO use condicionador: gruda o pó no cabelo.
3. Não esfregue forte nem coce a pele.
4. Assoe o nariz, limpe orelhas, pálpebras e unhas.
5. Se não houver chuveiro: limpe a pele com um pano úmido, de cima para baixo, trocando para uma parte limpa.
6. Roupa limpa que estava guardada.
7. Limpe os animais de estimação com água e sabão usando luvas.

! Uma ferida contaminada se lava com bastante água antes de cobrir.
'''),
    Article('rad_comida', 'Água e comida depois da chuva radioativa', r'''
## Seguro
- Comida enlatada, em potes, sacos fechados, geladeira ou despensa fechada.
- Limpe o exterior de latas e potes antes de abrir.
- Água engarrafada, da caixa-d'água coberta ou do encanamento do prédio (encha recipientes no início).

## Com cuidado
- Frutas e verduras de fora: lave e descasque; tire as folhas de fora.
- Água de rios e lagos: deixe repousar para o pó assentar, pegue a de cima e filtre por terra ou areia. Ferver NÃO elimina a radioatividade.
- Leite de animais que comeram pasto contaminado: evite nas primeiras semanas (iodo radioativo).

! A água de poço profundo é das mais seguras porque a terra filtra o pó.
'''),
    Article('rad_yoduro', 'Iodeto de potássio (KI)', r'''
Protege SÓ a tireoide contra o iodo radioativo (típico de acidentes em usinas nucleares). Não protege contra o resto da radiação.

## Quando
Só se as autoridades indicarem, de preferência antes ou logo depois da exposição. Uma dose protege umas 24 horas.

## Doses de referência (comprimidos de iodeto de potássio)
- Adultos: 130 mg.
- Crianças de 3 a 18 anos: 65 mg (adolescentes acima de 68 kg: 130 mg).
- Crianças de 1 mês a 3 anos: 32 mg.
- Bebês com menos de 1 mês: 16 mg.

! NÃO tome sal iodado, tintura de iodo nem iodopovidona: não servem e podem intoxicar.
! Maiores de 40 anos só precisam em exposições muito altas. Pessoas com problemas de tireoide ou alergia ao iodo: consultar.
'''),
    Article('rad_enfermedad', 'Doença por radiação', r'''
## Sintomas
- Náusea e vômito nas primeiras horas: quanto mais cedo começam, maior foi a dose.
- Depois pode haver dias em que a pessoa "parece" melhorar.
- Em seguida: queda de cabelo, sangramento nas gengivas, manchas roxas, infecções, diarreia.

## Cuidados possíveis sem hospital
- Muito líquido com sais (soro oral).
- Higiene extrema: mãos, comida e água limpas. As defesas caem e qualquer infecção é grave.
- Repouso e comida leve e nutritiva.
- Separar a pessoa de quem tiver infecções.

* A doença por radiação não é contagiosa. Cuidar de alguém doente é seguro se a pessoa já foi descontaminada.
'''),
    Article('rad_central', 'Acidente em usina nuclear e pulso eletromagnético', r'''
## Acidente numa usina
- Se você estiver dentro da área indicada pelas autoridades: abrigue-se dentro ou evacue na direção indicada, perpendicular ao vento.
- Feche as janelas e desligue a ventilação.
- Iodeto de potássio só se indicarem.

## Pulso eletromagnético (EMP)
Uma explosão nuclear no alto da atmosfera pode danificar aparelhos eletrônicos numa área enorme.
- Guarde um rádio pequeno, uma lanterna e uma bateria externa dentro de uma caixa metálica fechada (lata ou caixa de biscoitos), embrulhados em pano ou papelão para não tocarem o metal: é uma "gaiola de Faraday".
- Aparelhos desconectados e desligados têm mais chance de sobreviver.
- Tenha mapas, manuais e livros em papel.
'''),
  ],
  quiz: [
    Question('As três defesas contra a radiação são:',
        ['Tempo, distância e blindagem', 'Água, sal e iodo', 'Correr, gritar e pular', 'Pílulas, luvas e óculos'], 0,
        'Menos tempo, mais distância e mais massa entre você e a fonte.'),
    Question('Depois de uma explosão nuclear, o melhor é:',
        ['Sair para ver o que aconteceu', 'Entrar num prédio sólido e ficar 24 h ou mais', 'Ir ao rio', 'Subir no terraço'], 1,
        'Entre, fique dentro, informe-se.'),
    Question('Pela regra 7-10, às 7 horas a radiação é...',
        ['Igual', '10 vezes menor que na hora 1', 'O dobro', '7 vezes maior'], 1,
        'Cada vez que o tempo se multiplica por 7, cai 10 vezes.'),
    Question('Ferver a água elimina a radioatividade?',
        ['Sim', 'Não', 'Só com sal', 'Só à noite'], 1,
        'Ferver mata micróbios mas não elimina partículas radioativas; deixe assentar e filtre.'),
    Question('Ao entrar no abrigo depois de estar lá fora:',
        ['Tirar a roupa de cima e lavar-se com xampu sem condicionador', 'Passar condicionador', 'Dormir assim', 'Coçar a pele forte'], 0,
        'Tirar a roupa de cima elimina até 90 % da contaminação.'),
    Question('O iodeto de potássio protege...',
        ['O corpo todo', 'Só a tireoide', 'Os pulmões', 'A pele'], 1,
        'Só bloqueia o iodo radioativo na tireoide.'),
    Question('Que material blinda mais por centímetro?',
        ['Madeira', 'Água', 'Concreto', 'Tecido'], 2,
        'Concreto: 6 cm reduzem à metade; a madeira precisa de 22 cm.'),
  ],
);

// =====================================================================
// PLANTAS MEDICINAIS
// =====================================================================
const medicinaNaturalPt = Category(
  id: 'medicina_natural',
  name: 'Plantas medicinais',
  icon: Icons.spa_outlined,
  summary: 'Que plantas colher, para que servem e como prepará-las.',
  articles: [
    Article('med_reglas', 'Antes de usar uma planta medicinal', r'''
! As plantas medicinais TÊM efeitos e também podem intoxicar. Use para incômodos leves; doenças graves precisam de remédio.

- Identifique a planta com segurança: olhe a foto, as folhas, flores, cheiro e onde cresce. Na dúvida, não use.
- Colha longe de estradas, lixões, minas e plantações pulverizadas.
- Comece com pouca quantidade e observe 24 horas.
- Uma planta de cada vez: assim você sabe qual funcionou ou qual fez mal.
- Grávidas, bebês, crianças pequenas e pessoas com doenças do fígado ou rim: evitem os remédios ou usem os mais suaves (camomila, hortelã) em pouca quantidade.
- Suspenda se aparecer irritação na pele, vômito, tontura ou dor.
'''),
    Article('med_preparar', 'Como preparar remédios', r'''
## Infusão (chá) — folhas e flores
1 colher de sopa de planta seca (ou 2 de fresca) por xícara de água recém-fervida. Tampe 5–10 minutos e coe. No máximo 3 xícaras por dia.
@ manzanilla, hierbabuena, toronjil, cidron

## Decocção — raízes, cascas e sementes
Ferva 10–20 minutos em fogo baixo com a panela tampada. Coe.
@ jengibre, una_gato

## Compressa
Molhe um pano limpo numa infusão morna e coloque sobre a área (pancadas, inflamação, olhos irritados).

## Cataplasma (emplastro)
Amasse a planta fresca até virar uma pasta, coloque sobre a pele e cubra com um pano. Para picadas, arranhões e espinhas.
@ llanten, sabila, calendula

## Vapores
Ferva folhas aromáticas, cubra a cabeça com uma toalha e respire o vapor a uma distância segura. Para a congestão.
@ eucalipto, tomillo

## Gargarejos
Infusão morna com uma pitada de sal, várias vezes ao dia, para a garganta.
@ malva, manzanilla

## Pomada caseira
Aqueça em fogo bem baixo 1 xícara de óleo com um punhado de planta seca por 1–2 horas, coe, junte 2 colheres de sopa de cera de abelha derretida e deixe esfriar.

## Secar e guardar
- Colha de manhã, depois que o orvalho secar.
- Seque à sombra em maços pendurados, em lugar ventilado, por 1–2 semanas.
- Guarde em potes fechados com etiqueta (planta e data). Duram cerca de um ano.
'''),
    Article('med_botiquin', 'Farmácia verde: que planta para quê', r'''
## Diarreia
Primeiro soro oral. Chá de folhas de goiabeira (um punhado de folhas novas fervidas 10 min).
@ guayaba

## Náusea e enjoo
@ jengibre, hierbabuena

## Gases, cólicas e digestão pesada
@ manzanilla, hierbabuena, cidron, prontoalivio, albahaca

## Tosse e dor de garganta
Chá de tomilho ou flores de sabugueiro com mel; gargarejos de malva.
@ tomillo, sauco, malva, eucalipto

## Feridas pequenas e arranhões
Lave primeiro. Depois sangue-de-dragão, calêndula ou tanchagem.
@ sangre_drago, calendula, llanten

## Queimaduras leves e de sol
@ sabila

## Pancadas e manchas roxas (pele sem ferida)
@ arnica

## Nervos, ansiedade e insônia
@ valeriana, toronjil, manzanilla, cidron

## Picadas de insetos
@ llanten, sabila

## Dor nas articulações e inflamação
@ una_gato, jengibre

## Repelir insetos
@ limoncillo, achiote, albahaca

! Febre alta que não baixa, sangue nas fezes, dificuldade para respirar, confusão ou feridas infeccionadas precisam de remédios e atendimento médico.
'''),
    Article('med_peligrosas', 'Remédios tradicionais perigosos', r'''
Algumas plantas são usadas na medicina popular, mas podem intoxicar gravemente.
@ ruda, paico, quina, cola_caballo, matarraton

- Arruda: usada em "benzeduras" e cólicas, mas pode causar aborto, dano ao fígado e queimaduras na pele com o sol. Nunca na gravidez.
- Erva-de-santa-maria (mastruz): tradicional contra vermes; seu óleo é tóxico e já causou mortes, sobretudo em crianças.
- Quina: sua casca deu o quinino contra a malária, mas em excesso causa surdez e problemas no coração e na visão. Só se não houver outra opção e com dose prudente.
- Cavalinha: diurética; não use por semanas seguidas.
- Gliricídia (matarratón): tradicional em banhos para a febre; só uso externo.
- Trombeteira, mamona e comigo-ninguém-pode: nunca como remédio.
'''),
  ],
  quiz: [
    Question('Como se prepara uma infusão?',
        ['Ferver a planta 1 hora', 'Água recém-fervida sobre a planta, tampar 5–10 min', 'Planta em água fria', 'Queimar a planta'], 1,
        'Folhas e flores em infusão; raízes e cascas em decocção.'),
    Question('Para queimaduras leves se usa o gel de:',
        ['Arruda', 'Babosa', 'Mastruz', 'Mamona'], 1,
        'O gel interno da babosa acalma a pele.'),
    Question('A arnica se usa...',
        ['Tomada em chá', 'Só por fora em pancadas sem ferida', 'Nos olhos', 'Em feridas abertas'], 1,
        'A arnica é tóxica se ingerida.'),
    Question('Que planta tradicional uma grávida NÃO deve usar?',
        ['Arruda', 'Camomila em pouca quantidade', 'Babosa na pele', 'Tanchagem em cataplasma'], 0,
        'A arruda pode provocar aborto e intoxicação.'),
    Question('Para a diarreia, além do soro oral, usa-se chá de folhas de...',
        ['Goiabeira', 'Mamona', 'Trombeteira', 'Espirradeira'], 0,
        'As folhas de goiabeira são adstringentes.'),
    Question('Onde você NÃO deve colher plantas medicinais?',
        ['Na sua horta', 'Junto a estradas e plantações pulverizadas', 'No mato limpo', 'No seu quintal'], 1,
        'Elas absorvem fumaça, metais e agrotóxicos.'),
  ],
);
