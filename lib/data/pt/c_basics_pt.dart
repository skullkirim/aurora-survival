import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// PRIMEIROS SOCORROS
// =====================================================================
const auxiliosPt = Category(
  id: 'auxilios',
  name: 'Primeiros socorros',
  icon: Icons.medical_services_outlined,
  summary: 'Salvar vidas sem hospital: RCP, sangramento, queimaduras, fraturas.',
  articles: [
    Article('aux_prioridades', 'Avaliar uma emergência (PAS e XABCDE)', r'''
## Regra PAS
- Proteger: garanta que a área é segura para você e para a vítima. Um socorrista ferido é mais uma vítima.
- Avisar: se houver qualquer forma de pedir ajuda (rádio, outras pessoas), faça isso já.
- Socorrer: só depois do anterior.

## Ordem de avaliação XABCDE
- X – Hemorragia eXsanguinante: um sangramento maciço mata em minutos. Controla-se primeiro.
- A – Vias aéreas: fala? Tem algo na boca? Incline a cabeça e levante o queixo.
- B – Respiração: olhe, escute e sinta por no máximo 10 segundos.
- C – Circulação: procure outros sangramentos, pele fria e pálida, pulso fraco (choque).
- D – Déficit neurológico: responde? Pupilas iguais? Mexe braços e pernas?
- E – Exposição: examine todo o corpo e depois agasalhe para evitar hipotermia.

* Se a pessoa fala normalmente, tem via aérea e respira. Passe a procurar sangramentos e fraturas.
! Não mova alguém com possível lesão na coluna (queda de altura, pancada forte) a menos que a vida dela corra perigo onde está.
'''),
    Article('aux_rcp', 'RCP: reanimação cardiopulmonar', r'''
## Quando fazer
A pessoa não responde e NÃO respira ou só dá suspiros irregulares.

## Adulto
1. Deite-a de barriga para cima sobre superfície dura.
2. Base de uma mão no centro do peito (metade inferior do esterno), a outra mão por cima, braços retos.
3. Comprima 5 a 6 cm de profundidade, num ritmo de 100 a 120 por minuto (o ritmo da música "Stayin' Alive").
4. Deixe o peito voltar totalmente entre as compressões.
5. Se souber e puder: 30 compressões e 2 ventilações (cabeça inclinada, nariz tapado, 1 segundo cada sopro, vendo o peito subir).
6. Se não souber ou não quiser ventilar: só compressões contínuas. Continua sendo muito útil.

## Crianças e bebês
- Criança: uma ou duas mãos, profundidade de cerca de 5 cm.
- Bebê: dois dedos no centro do peito, cerca de 4 cm.
- Em crianças, se estiver sozinho, comece com 5 ventilações de resgate.

* Revezem a cada 2 minutos: a qualidade das compressões cai rápido com o cansaço.
! Num mundo sem hospital, a RCP raramente reanima alguém sem desfibrilador. Mesmo assim, em afogados, eletrocutados ou crianças pode funcionar. Faça até respirar, chegar ajuda ou você ficar exausto.
'''),
    Article('aux_hemorragia', 'Hemorragias e torniquete', r'''
## Pressão direta (sempre primeiro)
1. Use luvas ou um saco plástico se tiver.
2. Pressione forte com pano limpo diretamente sobre a ferida, no mínimo 10 minutos sem levantar para olhar.
3. Se o pano encharcar, coloque mais por cima; não tire o primeiro.
4. Enfaixe apertado para manter a pressão.

## Tamponar uma ferida funda
Em feridas fundas da axila, virilha ou pescoço: coloque pano ou gaze dentro da ferida até enchê-la e pressione forte por cima.

## Torniquete (só braços e pernas)
Use se o sangramento sai em jato ou não para com pressão.
- Faixa larga de 4–5 cm (cinto, pano). Nunca arame nem corda fina.
- Coloque 5–8 cm acima da ferida, nunca sobre uma articulação.
- Gire um pau (molinete) até o sangramento PARAR. Prenda o pau.
- Anote a hora na testa da pessoa ou no torniquete. Use o alarme de torniquete do app.

! O torniquete dói muito; isso é normal. Afrouxá-lo sem atendimento médico pode causar nova hemorragia mortal. É bem tolerado até 2 horas; além disso há risco de perder o membro.
* Choque (pele pálida, fria, suada, pulso rápido, confusão): deite a pessoa, agasalhe e levante as pernas se não houver fraturas.
'''),
    Article('aux_heridas', 'Feridas e infecções', r'''
Sem antibióticos, uma ferida infeccionada pode matar. A limpeza é o seu melhor remédio.

## Limpar
- Lave com bastante água potável (fervida e fria) em jato. Melhor muito volume do que pouca água "forte".
- Tire terra e restos visíveis com pinça limpa (fervida).
- Sabão em volta da ferida, não dentro.
- Não use álcool nem água oxigenada dentro de feridas fundas: danificam o tecido.

## Fechar ou não fechar
- Feridas sujas, mordidas ou com mais de 6–8 horas: NÃO feche. Deixe abertas, cobertas, e troque o curativo todo dia.
- Cortes limpos e recentes: pode aproximar as bordas com tiras adesivas.

## Sinais de infecção
- Vermelhidão que se espalha, calor, inchaço, pus, mau cheiro, febre, linhas vermelhas subindo pelo membro.

* O mel puro tem efeito antibacteriano e é usado em feridas há séculos: camada fina, cobrir, trocar todo dia.
! Linhas vermelhas, febre alta ou confusão = infecção espalhada. Procure antibióticos ou um médico a qualquer custo.
'''),
    Article('aux_quemaduras', 'Queimaduras', r'''
1. Afaste da fonte de calor. Se a roupa pegar fogo: pare, deite no chão e role.
2. Esfrie com água corrente fresca (não gelada) por 20 minutos.
3. Tire anéis e relógios antes que inche.
4. Cubra com filme plástico de cozinha limpo ou pano limpo úmido, sem apertar.

## Não faça
- Não ponha gelo, pasta de dente, manteiga, óleo nem café.
- Não estoure as bolhas.
- Não arranque roupa grudada na pele.

! Graves: queimaduras maiores que 10 palmas da mão da vítima em adultos, no rosto, mãos, genitais, articulações, ou pele branca/preta sem dor. Dê líquidos com sais (soro oral) e vigie o choque.
'''),
    Article('aux_fracturas', 'Fraturas, entorses e talas', r'''
## Reconhecer uma fratura
Dor intensa num ponto, deformidade, inchaço, não consegue apoiar ou mexer, estalo.

## Imobilizar (tala)
- Imobilize a articulação de cima e a de baixo do osso quebrado.
- Acolchoe com pano entre a tala e a pele.
- Materiais: paus retos, revistas enroladas, papelão, a perna sã amarrada à ferida.
- Confira depois: dedos rosados, quentes e com sensibilidade. Se ficarem azuis ou frios, afrouxe.

## Fratura exposta (osso visível)
Controle o sangramento sem pressionar o osso, cubra com pano limpo e NÃO tente colocá-lo para dentro.

## Entorse: regra RICE
- Repouso, gelo ou frio (20 min a cada 2–3 h), compressão com faixa, elevação.

! Só tente alinhar um membro se não houver pulso abaixo da fratura e não houver ajuda possível; puxe suave e constante em linha reta.
'''),
    Article('aux_temperatura', 'Hipotermia e insolação', r'''
## Hipotermia
Tremores, falta de jeito, confusão, fala arrastada. Se para de tremer estando frio, é grave.
- Tire do vento e da umidade. Tire a roupa molhada.
- Isole do chão (galhos, papelão, mochila).
- Agasalhe cabeça, pescoço e tronco. Compartilhe calor corporal num saco de dormir.
- Se estiver consciente: bebidas mornas e doces.
! Não esfregue os membros nem aqueça de repente com fogo direto.

## Insolação (golpe de calor)
Pele muito quente, confusão, dor de cabeça, vômito, pode parar de suar.
- Sombra imediata, tire a roupa, molhe todo o corpo e abane.
- Panos frios no pescoço, axilas e virilhas.
- Se estiver consciente, água em goles com um pouco de sal.
! O golpe de calor é mortal. Esfriar rápido é a prioridade.
'''),
    Article('aux_suero', 'Desidratação, diarreia e soro oral', r'''
A diarreia por água contaminada é uma das maiores causas de morte depois de um desastre.

## Soro de reidratação oral caseiro (OMS)
- 1 litro de água potável
- 6 colheres de chá rasas de açúcar
- ½ colher de chá rasa de sal
Misture bem. Teste: não deve ser mais salgado que lágrimas.

## Como dar
- Goles pequenos e frequentes, mesmo se vomitar (espere 10 min e continue).
- Adulto: depois de cada evacuação, 1 a 2 copos.
- Continue comendo alimentos leves (arroz, banana cozida, caldo).

## Sinais de alarme
Boca seca, não urina há 8+ horas, olhos fundos, tontura ao levantar, letargia. Em bebês: moleira afundada.

* Lave as mãos com sabão antes de comer e depois do banheiro: corta a maioria dos contágios.
'''),
    Article('aux_mordeduras', 'Picadas de cobra e de insetos', r'''
## Cobra
@ mapana, cascabel, coral, verrugosa
1. Afaste-se da cobra. Não tente pegá-la.
2. Mantenha a pessoa calma e quieta: o movimento acelera o veneno.
3. Tire anéis, relógios e roupa apertada antes do inchaço.
4. Imobilize o membro na altura do coração ou um pouco abaixo.
5. Marque a borda do inchaço com a hora a cada 30 minutos.
6. Levar a um centro com soro antiofídico é a única cura.

## NÃO faça
- Não corte, não chupe, não faça torniquete, nada de gelo, álcool nem remédios de "benzedeiros".

## Picadas (abelhas, vespas, escorpiões)
- Tire o ferrão raspando com um cartão, não apertando.
- Frio no local.
! Dificuldade para respirar, inchaço no rosto/lábios ou desmaio depois de uma picada = anafilaxia. Se houver adrenalina autoinjetável, use na coxa.
'''),
    Article('aux_atragantamiento', 'Engasgo', r'''
## Se consegue tossir
Incentive a tossir forte. Ainda não bata.

## Se não consegue falar, tossir nem respirar (adulto e criança > 1 ano)
1. Fique atrás, incline a pessoa para frente.
2. 5 golpes fortes entre as escápulas com a base da mão.
3. 5 compressões abdominais (Heimlich): punho entre o umbigo e o esterno, a outra mão por cima, puxão para dentro e para cima.
4. Alterne 5 e 5 até sair ou perder a consciência (então: RCP).

## Bebê
De bruços sobre seu antebraço, 5 golpes nas costas; depois de barriga para cima, 5 compressões no peito com 2 dedos.
'''),
    Article('aux_botiquin', 'Kit de primeiros socorros de sobrevivência', r'''
## O básico
- Gazes, ataduras elásticas, esparadrapo, curativos adesivos.
- Luvas, tesoura, pinça, termômetro.
- Torniquete ou faixa larga de 4 cm.
- Envelopes de soro oral, sabão, antisséptico (iodopovidona ou clorexidina).
- Analgésicos (paracetamol, ibuprofeno), anti-histamínicos, antidiarreico.
- Manta térmica, lanterna, caderno e lápis.
- Seus remédios pessoais para várias semanas.

* Confira as validades a cada 6 meses. Registre o kit no inventário deste app.
! Nunca tome remédios de outras pessoas sem saber para que servem e a dose.
'''),
  ],
  quiz: [
    Question('O que se atende primeiro numa vítima com sangramento em jato na perna?',
        ['A respiração', 'O sangramento', 'As fraturas', 'A temperatura'], 1,
        'No XABCDE o X (hemorragia maciça) vem primeiro: pode matar em minutos.'),
    Question('Ritmo correto das compressões na RCP:',
        ['60 por minuto', '80 por minuto', '100 a 120 por minuto', '150 por minuto'], 2,
        'Entre 100 e 120 por minuto, uns 5–6 cm de profundidade em adultos.'),
    Question('Uma queimadura se esfria com...',
        ['Gelo direto', 'Pasta de dente', 'Água corrente fresca 20 min', 'Óleo'], 2,
        'Água fresca 20 minutos. Gelo, pasta de dente e óleos danificam mais a pele.'),
    Question('O soro oral caseiro leva por litro de água:',
        ['6 colheres de chá de açúcar e ½ de sal', '1 de açúcar e 3 de sal', 'Só sal', 'Só açúcar'], 0,
        'Fórmula da OMS: 6 colheres de chá rasas de açúcar e meia de sal.'),
    Question('Diante de uma picada de cobra você deve...',
        ['Cortar e chupar', 'Fazer torniquete', 'Imobilizar e manter a calma', 'Pôr gelo'], 2,
        'Imobilizar, acalmar e levar. Cortar, chupar ou torniquete pioram o dano.'),
    Question('Onde se coloca um torniquete?',
        ['Sobre o joelho', '5–8 cm acima da ferida', 'Bem na ferida', 'No pescoço'], 1,
        'Entre 5 e 8 cm acima da ferida, nunca sobre uma articulação.'),
  ],
);

// =====================================================================
// ÁGUA
// =====================================================================
const aguaPt = Category(
  id: 'agua',
  name: 'Água',
  icon: Icons.water_drop_outlined,
  summary: 'Encontrar, purificar e armazenar água segura.',
  articles: [
    Article('agua_regla3', 'A regra dos 3', r'''
Uma pessoa comum pode sobreviver aproximadamente:
- 3 minutos sem ar
- 3 horas sem abrigo em clima extremo
- 3 dias sem água
- 3 semanas sem comida

Por isso a ordem de prioridades quase sempre é: segurança → abrigo/temperatura → água → fogo → comida.

## Quanta água você precisa
- Mínimo para beber: 2–3 litros por pessoa por dia; mais com calor ou esforço.
- Para beber + cozinhar + higiene básica: uns 4 litros por pessoa por dia.
* Use a calculadora de rações em Ferramentas.
'''),
    Article('agua_encontrar', 'Como encontrar água', r'''
## Fontes, da melhor à pior
1. Chuva coletada diretamente em recipientes limpos (a mais segura).
2. Nascentes que brotam da rocha.
3. Rios e córregos com correnteza (pegue água acima de qualquer povoado).
4. Lagos e lagoas.
5. Poças e água parada (último recurso, sempre purificar).

## Pistas no terreno
- Vegetação verde e densa em áreas secas.
- Insetos (abelhas, moscas, mosquitos) e pegadas de animais convergindo.
- Aves voando baixo e reto ao amanhecer ou entardecer.
- Fundos de vales e a parte externa das curvas de rios secos: cave ali.

## Na cidade
- Caixa da descarga (a caixa de trás, NÃO o vaso) se não tiver produtos químicos.
- Aquecedor de água, canos do prédio (abra a torneira mais baixa).
- Piscinas: só para lavar, a menos que destile.

* O orvalho da manhã se coleta passando um pano no capim e torcendo.
'''),
    Article('agua_purificar', 'Purificar água', r'''
## 1. Filtre primeiro
Passe a água turva por um pano dobrado ou deixe repousar para o sedimento assentar. As partículas protegem os micróbios.

## 2. Ferver (o método mais seguro)
- Ferva com borbulhas fortes por 1 minuto.
- Acima de 2.000 m de altitude: ferva 3 minutos.
- Deixe esfriar tampada.

## 3. Cloro (água sanitária)
Use água sanitária sem perfume, de hipoclorito de sódio a 5–6 %:
- 2 gotas por litro de água limpa.
- 4 gotas por litro se estiver turva ou fria.
- Misture e espere 30 minutos. Deve cheirar levemente a cloro. Se não, repita e espere mais 15 min.

## 4. Desinfecção solar (SODIS)
- Garrafa PET transparente de no máximo 2 litros, água limpa.
- Ao sol direto por 6 horas (2 dias se estiver nublado).
- Funciona bem nos trópicos.

## 5. Pastilhas ou filtros comerciais
Siga as instruções do fabricante.

! Nenhum método elimina produtos químicos, combustíveis ou metais pesados, exceto a destilação. Evite água perto de minas, fábricas ou com cheiro de combustível.
'''),
    Article('agua_filtro', 'Filtro caseiro em camadas', r'''
Um filtro em camadas clareia a água, mas NÃO a torna potável. Depois você deve ferver ou clorar.

## Montagem (garrafa cortada de cabeça para baixo)
De baixo para cima:
1. Pano ou algodão no gargalo.
2. Carvão vegetal triturado (da sua fogueira, não briquetes) — retém cheiros e alguns químicos.
3. Areia fina.
4. Areia grossa.
5. Cascalho.
6. Pedras pequenas.

Descarte os primeiros litros, que sairão pretos por causa do carvão.

## Destilador solar
- Cave um buraco e ponha um recipiente no centro.
- Coloque folhas verdes ou água suja em volta.
- Cubra com plástico, vede as bordas com terra e ponha uma pedra no centro sobre o recipiente.
- A água evaporada se condensa e pinga limpa. Produz pouco (cerca de meio litro por dia), mas serve com água salgada ou contaminada.
'''),
    Article('agua_almacenar', 'Armazenar água', r'''
- Recipientes de grau alimentício, limpos e com tampa. Nunca embalagens de produtos químicos.
- Lugar fresco e escuro: a luz favorece as algas.
- Água tratada da rede dura uns 6 meses; renove.
- Etiquete a data.
- Use sempre uma concha limpa: não ponha as mãos nem copos usados.

* Para desinfetar o recipiente: 1 colher de chá de água sanitária por litro de água, agite, deixe 30 segundos e enxágue.
'''),
  ],
  quiz: [
    Question('Quanto tempo se deve ferver a água acima de 2.000 m de altitude?',
        ['10 segundos', '1 minuto', '3 minutos', '30 minutos'], 2,
        'Ao nível do mar basta 1 minuto; na altitude a água ferve a menor temperatura, então ferva 3.'),
    Question('Gotas de água sanitária a 5–6 % por litro de água limpa:',
        ['2 gotas', '10 gotas', 'Meia xícara', '1 colher de sopa'], 0,
        '2 gotas por litro (4 se estiver turva ou fria) e esperar 30 minutos.'),
    Question('Um filtro de areia e carvão deixa a água potável?',
        ['Sim, sempre', 'Não, depois é preciso ferver ou clorar', 'Só se for de rio', 'Só à noite'], 1,
        'Clareia a água, mas não elimina todos os micróbios.'),
    Question('A fonte de água mais segura em geral é:',
        ['Poça', 'Chuva coletada em recipiente limpo', 'Lagoa', 'Piscina'], 1,
        'A chuva coletada diretamente é a mais limpa.'),
    Question('SODIS consiste em deixar garrafas PET ao sol durante:',
        ['15 minutos', '6 horas', '1 semana', '1 hora'], 1,
        'Seis horas ao sol direto; dois dias se estiver nublado.'),
  ],
);

// =====================================================================
// FOGO
// =====================================================================
const fuegoPt = Category(
  id: 'fuego',
  name: 'Fogo',
  icon: Icons.local_fire_department_outlined,
  summary: 'Calor, luz, cozinhar e purificar: acendê-lo e mantê-lo.',
  articles: [
    Article('fuego_basico', 'Como acender um fogo', r'''
## O triângulo do fogo
Calor + combustível + oxigênio. Se faltar um, apaga.

## Prepare TUDO antes de acender
1. Isca: material muito fino e seco que pega com uma faísca (algodão, fiapos de secadora, casca fina, folhas secas, ninho de capim seco, maravalha).
2. Gravetos: da grossura de um fósforo a um lápis.
3. Lenha pequena: da grossura de um dedo à de um pulso.
4. Lenha grande: para manter.
Tenha o dobro do que acha que precisa.

## Acender
- Faça uma base seca (galhos ou casca) se o chão estiver úmido.
- Ninho de isca, acenda e sopre suave pela base.
- Acrescente gravetos em forma de cone (tipi) e depois lenha aos poucos.

## Estruturas
- Tipi: rápido e quente, ideal para começar e ferver água.
- Cabana (troncos cruzados): estável, boas brasas para cozinhar.
- Estrela: troncos que vão sendo empurrados para o centro; economiza lenha a noite toda.

! Nunca acenda fogo dentro de uma barraca ou lugar fechado: o monóxido de carbono mata sem cheiro.
'''),
    Article('fuego_sinfosforos', 'Fogo sem fósforos', r'''
## Ferrocério (pederneira moderna)
Raspe com força com o dorso de uma faca diretamente sobre a isca. O método mais confiável: funciona molhado.

## Lupa, óculos ou fundo de lata
Concentre o sol no menor ponto possível sobre isca escura. Um fundo de lata polido com pasta de dente ou chocolate serve como espelho.

## Bateria e palha de aço
Esfregue uma bateria de 9 V (ou duas pilhas em série) contra palha de aço fina: fica incandescente na hora.

## Fricção (arco)
- Base de madeira macia e seca com um entalhe em V.
- Eixo reto de madeira seca, um arco com cordão e uma pedra ou peça de madeira dura para pressionar em cima.
- Gire rápido até sair fumaça e formar uma brasa no entalhe; passe-a para o ninho de isca.
Exige prática: treine antes de precisar.

* Guarde isca seca num saco hermético: algodão com vaselina arde vários minutos.
'''),
    Article('fuego_lluvia', 'Fogo com chuva', r'''
- Procure madeira morta que ainda está nas árvores (não a do chão).
- Divida os troncos: o interior costuma estar seco.
- Casca de bétula, resina de pinheiro e madeira resinosa ardem mesmo úmidas.
- Faça o fogo sob um teto natural ou uma lona alta.
- Ponha a lenha úmida perto do fogo para secar enquanto ele arde.
'''),
  ],
  quiz: [
    Question('Os três elementos do triângulo do fogo são:',
        ['Calor, combustível, oxigênio', 'Lenha, água, sal', 'Sol, vento, terra', 'Faísca, fumaça, cinza'], 0,
        'Sem um dos três não há fogo.'),
    Question('O que se prepara antes de acender?',
        ['Só a lenha grossa', 'Isca, gravetos e lenha de vários tamanhos', 'Nada', 'Água'], 1,
        'Ter tudo pronto evita que a chama inicial apague.'),
    Question('O método mais confiável se tudo estiver molhado é:',
        ['Lupa', 'Ferrocério', 'Arco de fricção', 'Esfregar pedras'], 1,
        'O ferrocério produz faíscas muito quentes mesmo molhado.'),
    Question('Por que não se acende fogo dentro da barraca?',
        ['Pelo cheiro', 'Pelo monóxido de carbono e incêndio', 'Não acontece nada', 'Gasta a lenha'], 1,
        'O monóxido não tem cheiro e mata; além disso há risco de incêndio.'),
  ],
);

// =====================================================================
// ABRIGO
// =====================================================================
const refugioPt = Category(
  id: 'refugio',
  name: 'Abrigo',
  icon: Icons.cabin_outlined,
  summary: 'Proteger-se do frio, da chuva, do sol e do vento.',
  articles: [
    Article('ref_ubicacion', 'Escolher onde se abrigar', r'''
## Procure
- Terreno um pouco elevado e plano, com drenagem.
- Perto (não ao lado) da água: 50–100 m.
- Proteção natural do vento: rochas, árvores.
- Materiais por perto: galhos, folhas.

## Evite
- Leitos de rios e córregos secos: enchentes repentinas.
- Debaixo de árvores com galhos mortos ("fazedores de viúvas").
- Base de encostas instáveis (deslizamentos) e topos expostos (raios).
- Perto de formigueiros ou vespeiros.

* Num prédio: escolha cômodos pequenos, internos e em andares baixos; são mais fáceis de aquecer e defender.
'''),
    Article('ref_tipos', 'Abrigos simples', r'''
## Lean-to (meia-água inclinada)
- Uma vara horizontal entre duas árvores na altura do peito.
- Galhos apoiados de um lado formando o telhado.
- Cubra com folhas, palmas ou lona de baixo para cima, como telhas.
- Ponha a fogueira na frente; uma parede de troncos atrás do fogo reflete o calor.

## Abrigo de folhagem (A-frame)
- Uma vara comprida apoiada num toco: só um pouco mais longa que você.
- Costelas de galhos dos lados.
- Cubra com 60–90 cm de folhas secas. Mais grosso = mais quente.
- Encha também o interior. Mantém você aquecido sem fogo.

## Com lona ou plástico
- Corda entre duas árvores, lona por cima em forma de A, cantos amarrados.
- Isole-se sempre do chão: o chão rouba calor mais rápido que o ar.

! Abrigo pequeno é mais quente. Só um pouco maior que o seu corpo.
'''),
    Article('ref_ropa', 'Roupa e temperatura', r'''
## Sistema de camadas
- Camada base: sintética ou lã, afasta o suor. Evite algodão no frio: molhado não aquece.
- Camada média: isolante (fleece, lã, plumas).
- Camada externa: corta vento e chuva.

## Regras
- Tire camadas antes de suar; o suor depois esfria você.
- Cubra cabeça, pescoço e mãos.
- Dormir com a roupa do dia seguinte dentro do saco de dormir a mantém seca e morna.
* Jornal entre camadas de roupa serve de isolante de emergência.
'''),
  ],
  quiz: [
    Question('Onde você NÃO deve montar um abrigo?',
        ['Terreno elevado', 'No leito de um córrego seco', 'Protegido do vento', 'Perto de materiais'], 1,
        'As enchentes repentinas podem arrastar você.'),
    Question('Por que é preciso se isolar do chão?',
        ['Só por causa dos insetos', 'O chão rouba calor rapidamente', 'É mais confortável', 'Não importa'], 1,
        'A condução com o chão frio esfria o corpo muito rápido.'),
    Question('No frio, que tecido evitar como camada base?',
        ['Lã', 'Sintético', 'Algodão', 'Fleece'], 2,
        'O algodão molhado perde quase todo o poder isolante.'),
  ],
);
