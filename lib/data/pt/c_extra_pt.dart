import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// ANIMAIS
// =====================================================================
const animalesPt = Category(
  id: 'animales',
  name: 'Animais',
  icon: Icons.pets_outlined,
  summary: 'Animais perigosos, doenças que transmitem e fauna útil.',
  articles: [
    Article('ani_serpientes', 'Cobras venenosas', r'''
Só na Colômbia há mais de 50 espécies de cobras venenosas. A maioria das picadas acontece no campo, à noite, ao pisar ou pôr as mãos sem olhar.
@ mapana, cascabel, coral, verrugosa

## Pistas (não infalíveis)
- Víboras (jararaca, cascavel, surucucu): cabeça triangular mais larga que o pescoço, pupila vertical, uma fosseta entre o olho e a narina.
- Corais: pequenas, anéis de cores vivas, cabeça redonda. Muito venenosas mesmo parecendo inofensivas.
! Trate TODA cobra desconhecida como venenosa. Não tente matá-la: a maioria das picadas acontece assim.

## Prevenção
- Botas altas, calça comprida e lanterna à noite.
- Olhe onde pisa e onde põe as mãos (lenha, buracos, pedras).
- Mantenha o mato baixo e sem lixo em volta da casa: atrai ratos, e os ratos atraem cobras.
- Bata no chão com um pau ao andar no capim alto.
'''),
    Article('ani_aracnidos', 'Aranhas, escorpiões e insetos perigosos', r'''
@ viuda_negra, alacran, arana_bananera, lonomia, hormiga_conga, abeja_africanizada

## Regras gerais
- Sacuda roupas, sapatos, cobertores e toalhas antes de usar.
- Use luvas ao mexer em lenha, pedras, telhas ou entulho.
- Não toque em lagartas peludas ou com espinhos.
- Mantenha a cama afastada da parede.

## Se for picado
- Lave com água e sabão.
- Frio no local para a dor.
- Vigie 24 horas: dificuldade para respirar, suor intenso, vômito ou sangramento são sinais de alarme.
'''),
    Article('ani_enfermedades', 'Doenças que os animais transmitem', r'''
Depois de um desastre, as doenças transmitidas por animais matam mais que os próprios animais.
@ aedes, pito, vampiro

## Mosquitos (dengue, malária, zika)
- Elimine a água parada: tampe caixas, vire recipientes, troque a água dos bebedouros a cada 3 dias.
- Mosquiteiro à noite; roupa comprida ao amanhecer e ao entardecer.

## Ratos (leptospirose)
- Transmite-se pela urina de rato na água de enchentes e poças.
- Use botas na água; guarde a comida em recipientes fechados; cace ou espante os ratos.
! Febre alta, dor forte nas panturrilhas e olhos vermelhos depois de andar em água de enchente: pode ser leptospirose.

## Raiva
- Cães, gatos, morcegos e raposas podem transmiti-la.
- Toda mordida: lave 15 minutos com água e sabão em jato. É a medida mais importante.
! Um animal que age de forma estranha (agressivo sem motivo, babando, sem conseguir engolir, muito manso sendo selvagem) pode ter raiva. Afaste-se.

## Parasitas
- Cozinhe bem toda carne e peixe.
- Ande calçado: muitos parasitas entram pelos pés descalços.
'''),
    Article('ani_grandes', 'Animais grandes e cães ferais', r'''
@ jaguar, caiman, raya

## Cães sem dono (o perigo mais comum)
- Num colapso, os cães abandonados formam matilhas.
- Não corra: ativa o instinto de perseguição.
- Fique de lado, sem encará-los nos olhos, e recue devagar.
- Tenha um pau ou algo entre você e eles. Suba num lugar alto se atacarem.
- Proteja pescoço e rosto com o braço enrolado em roupa.

## Gado
- Touros e vacas com bezerros podem investir. Não atravesse pastos com eles.

## Em rios e brejos
- Arraste os pés para espantar as arraias.
- Evite águas turvas e paradas ao anoitecer (jacarés).
'''),
    Article('ani_caza', 'Proteína animal sustentável', r'''
@ gallina, cuy, conejo, tilapia, chiguiro, iguana

- Criar é mais seguro e rende mais que caçar: galinhas, porquinhos-da-índia, coelhos e peixes em tanque.
- Os animais pequenos se reproduzem rápido e comem sobras e capim.
- A pesca com linhas de fundo e covos trabalha sozinha enquanto você faz outras tarefas.

## Limpar um animal pequeno
1. Sangre cortando o pescoço, pendurado de cabeça para baixo.
2. Tire a pele ou as penas (água quente ajuda a depenar).
3. Abra a barriga sem furar os intestinos e tire as vísceras.
4. Guarde coração e fígado sadios (vermelhos, firmes, sem manchas).
5. Lave com água limpa e cozinhe bem.

! Um fígado com manchas brancas ou cistos indica doença: jogue fora o animal inteiro.
* As vísceras e o sangue servem de isca para pescar ou como adubo enterrados.
'''),
  ],
  quiz: [
    Question('O que fazer com uma cobra desconhecida?',
        ['Matá-la', 'Tratá-la como venenosa e afastar-se', 'Pegá-la', 'Segui-la'], 1,
        'Muitas picadas acontecem ao tentar matar ou pegar a cobra.'),
    Question('As corais...',
        ['São inofensivas', 'Se distinguem pela regra das cores', 'São muito venenosas', 'Só vivem no mar'], 2,
        'O veneno pode paralisar a respiração; a regra das cores não é confiável.'),
    Question('A leptospirose se transmite principalmente por...',
        ['Picada de abelha', 'Urina de rato na água', 'Comer fruta', 'O sol'], 1,
        'Água de enchente contaminada com urina de ratos.'),
    Question('Diante de uma mordida de cachorro ou morcego, o primeiro é:',
        ['Lavar 15 minutos com água e sabão', 'Pôr gelo', 'Queimar a ferida', 'Nada'], 0,
        'Lavar em jato reduz muito o risco de raiva.'),
    Question('Se um enxame de abelhas africanizadas atacar:',
        ['Pular na água', 'Correr para um lugar fechado cobrindo o rosto', 'Ficar parado', 'Bater nelas'], 1,
        'Elas esperam você sobre a água; correr para um abrigo fechado é o melhor.'),
    Question('Ao atravessar um rio com arraias convém...',
        ['Pular', 'Arrastar os pés', 'Ir descalço', 'Correr'], 1,
        'Arrastar os pés as espanta em vez de pisar nelas.'),
  ],
);

// =====================================================================
// COMUNICAÇÃO
// =====================================================================
const comunicacionPt = Category(
  id: 'comunicacion',
  name: 'Comunicação e rádio',
  icon: Icons.settings_input_antenna,
  summary: 'Rádios, alfabeto fonético, mensagens e sinais em grupo.',
  articles: [
    Article('com_radio', 'Rádios para emergências', r'''
## Receber informação
- Um rádio AM/FM a pilha, solar ou de manivela é o mais importante: as emissoras locais informam sobre abrigos, água e perigos.
- AM chega mais longe à noite.

## Falar com outros
- Walkie-talkies (rádios PMR/FRS): fáceis, alcance de 1–5 km em terreno aberto, menos na cidade ou na montanha.
- Rádios de radioamador (VHF/UHF e HF): alcance de dezenas a milhares de km; em emergências os radioamadores formam redes de ajuda.

## Aumentar o alcance
- Fique num lugar alto e aberto.
- Antena vertical e longe de metal.
- Fale curto, claro, perto do microfone sem gritar.

## Protocolo
- Escute antes de falar. Diga para quem chama e quem é: "Base, aqui Patrulha Um, câmbio".
- "Câmbio" = terminei, sua vez. "Desligo" = terminei a comunicação.
- Horários fixos de contato (por exemplo 5 minutos a cada hora cheia) economizam bateria.
'''),
    Article('com_fonetico', 'Alfabeto fonético e mensagens claras', r'''
Para soletrar nomes ou coordenadas sem erros:
- A Alfa · B Bravo · C Charlie · D Delta · E Echo · F Foxtrot
- G Golf · H Hotel · I India · J Juliet · K Kilo · L Lima
- M Mike · N November · O Oscar · P Papa · Q Quebec · R Romeo
- S Sierra · T Tango · U Uniform · V Victor · W Whiskey
- X X-ray · Y Yankee · Z Zulu

## Mensagem de emergência (formato curto)
1. Quem você é e quantas pessoas são.
2. Onde está (coordenadas da aba Mapa, ou um lugar conhecido).
3. O que está acontecendo (feridos, água, perigo).
4. Do que precisa.
5. O que vai fazer e quando volta a chamar.

* Para a emergência internacional no rádio: "MAYDAY, MAYDAY, MAYDAY" (perigo de vida). "PAN-PAN" para urgências sem perigo imediato.
'''),
    Article('com_grupo', 'Coordenação do grupo sem sinal', r'''
- Combine um ponto de encontro principal e outro alternativo antes que algo aconteça.
- Plano familiar escrito: telefones em papel, contato em outra cidade, pontos de encontro.
- Deixe bilhetes visíveis com data e hora: "Estamos bem, fomos para X, 29/10 15:00".
- Marcas na porta depois de revisar uma casa (sistema de resgate): um X com a data em cima, equipe à esquerda, perigos à direita e número de vítimas embaixo.
- Apito: 1 = onde você está? / atenção, 2 = venha aqui, 3 = socorro.
- Sinais com os braços à distância: braços em "Y" = sim / preciso de ajuda, um braço para cima e outro para baixo = não.
* No Modo comunidade do app, os telefones próximos trocam mensagens sem internet.
'''),
  ],
  quiz: [
    Question('O aparelho mais importante para receber informação num desastre é:',
        ['Televisão', 'Rádio AM/FM a pilha ou manivela', 'Videogame', 'Impressora'], 1,
        'Funciona sem rede elétrica nem internet.'),
    Question('No rádio, "câmbio" significa...',
        ['Terminei, sua vez de falar', 'Mudar de canal', 'Fim da comunicação', 'Socorro'], 0,
        '"Desligo" é terminar a comunicação.'),
    Question('Três apitos significam...',
        ['Tudo bem', 'Venha aqui', 'Socorro', 'Comida pronta'], 2,
        'O número três é o sinal universal de socorro.'),
    Question('A palavra "MAYDAY" é usada quando...',
        ['Há perigo de vida', 'Se pergunta a hora', 'O tempo está bom', 'É de noite'], 0,
        'Perigo grave e iminente.'),
  ],
);
