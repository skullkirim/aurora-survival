import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// ORIENTAÇÃO E SINAIS
// =====================================================================
const orientacionPt = Category(
  id: 'orientacion',
  name: 'Orientação e sinais',
  icon: Icons.explore_outlined,
  summary: 'Localizar-se sem GPS e pedir resgate.',
  articles: [
    Article('ori_sol', 'Orientar-se pelo sol e pelas estrelas', r'''
## O sol
- Nasce aproximadamente no Leste e se põe no Oeste.
- Perto do equador, ao meio-dia o sol fica quase em cima de você; use a manhã ou a tarde para se orientar.

## Método da sombra (o mais confiável)
1. Finque um pau reto no chão.
2. Marque a ponta da sombra com uma pedra.
3. Espere 15–20 minutos e marque a nova ponta.
4. A linha da primeira marca para a segunda aponta de Oeste para Leste.

## À noite
- Hemisfério norte: a estrela Polar marca o Norte (perto do equador aparece bem baixa no horizonte).
- Cruzeiro do Sul: prolongue 4,5 vezes o eixo longo da cruz; dali desça até o horizonte: é o Sul.
- Órion: a estrela da espada nasce quase exatamente no Leste.

## Calcular horas de luz
Estique o braço, mão na horizontal sob o sol: cada dedo entre o sol e o horizonte ≈ 15 minutos de luz.
'''),
    Article('ori_brujula', 'Usar bússola e coordenadas', r'''
## Bússola
- Afaste de metais, ímãs e do celular carregando.
- A agulha (ou o app) marca o Norte magnético; a diferença para o Norte verdadeiro costuma ser pequena.
- Para andar em linha reta: escolha um rumo, fixe um ponto visível nessa direção (árvore, rocha), ande até ele, repita.

## Coordenadas GPS
- Latitude: Norte/Sul do equador.
- Longitude: Leste/Oeste.
- 0,001° ≈ 111 metros.

* A aba Mapa deste app salva pontos (água, abrigo, perigo) e guia você até eles com a bússola, sem internet.
'''),
    Article('ori_perdido', 'Se estiver perdido: S.T.O.P.', r'''
- S – Sente-se: pare. Andar em pânico piora tudo.
- T – Pense: de onde eu vim? Quanto tempo andei?
- O – Observe: terreno, água, sol, recursos, perigos.
- P – Planeje: decida ficar ou se mover.

## Ficar ou se mover
- Se alguém sabe onde você está, fique e faça sinais.
- Se precisar se mover: siga a água morro abaixo; os rios levam a povoados.
- Marque o caminho (galhos quebrados, pedras empilhadas) para poder voltar.
'''),
    Article('ori_senales', 'Sinais de resgate', r'''
## Número três = socorro
Três fogueiras em triângulo, três apitos, três tiros, três flashes.

## SOS em código Morse
· · · — — — · · ·  (3 curtos, 3 longos, 3 curtos). Use com lanterna, espelho, batidas ou apito. O app tem SOS com flash.

## Sinais terra–ar (faça grandes, no mínimo 3 m, com contraste)
- V: preciso de ajuda.
- X: preciso de assistência médica.
- Seta →: vou nesta direção.
- N: não / negativo.  Y: sim / afirmativo.

## Espelho de sinalização
Reflita o sol para um avião ou barco: é visto a dezenas de quilômetros. Mire estendendo a outra mão com dois dedos em V e ponha o reflexo entre eles.

## Fumaça
- De dia: fumaça branca (capim verde sobre o fogo) contra fundo escuro.
- Fumaça preta (borracha, óleo) contra fundo claro ou neve.
- À noite: fogo brilhante.
'''),
    Article('ori_morse', 'Código Morse', r'''
Unidade: ponto = 1, traço = 3, espaço entre sinais = 1, entre letras = 3, entre palavras = 7.

- A ·—   B —···   C —·—·   D —··
- E ·   F ··—·   G ——·   H ····
- I ··   J ·———   K —·—   L ·—··
- M ——   N —·   O ———   P ·——·
- Q ——·—   R ·—·   S ···   T —
- U ··—   V ···—   W ·——   X —··—
- Y —·——   Z ——··
- 1 ·————   2 ··———   3 ···——   4 ····—   5 ·····
- 6 —····   7 ——···   8 ———··   9 ————·   0 —————

* Use o tradutor Morse em Ferramentas para enviar qualquer mensagem com a lanterna.
'''),
  ],
  quiz: [
    Question('O SOS em Morse é:',
        ['3 longos, 3 curtos, 3 longos', '3 curtos, 3 longos, 3 curtos', '1 longo', '5 curtos'], 1,
        '· · · — — — · · ·'),
    Question('No método da sombra, a primeira marca indica o...',
        ['Leste', 'Norte', 'Oeste', 'Sul'], 2,
        'O sol vai para o Oeste, então a sombra vai para o Leste: a primeira marca é o Oeste.'),
    Question('Um grande X no chão para um avião significa:',
        ['Tudo bem', 'Preciso de assistência médica', 'Vou para lá', 'Sim'], 1,
        'V = ajuda, X = assistência médica.'),
    Question('Perdido no mato e ninguém sabe onde você está. O que seguir?',
        ['Subir sempre', 'A água morro abaixo', 'Andar à noite', 'Andar em círculos'], 1,
        'Rios e córregos costumam levar a povoados.'),
    Question('Cada dedo entre o sol e o horizonte equivale a uns...',
        ['5 min', '15 min', '1 hora', '2 horas'], 1,
        'Aproximadamente 15 minutos de luz por dedo.'),
  ],
);

// =====================================================================
// NÓS E FERRAMENTAS
// =====================================================================
const nudosPt = Category(
  id: 'nudos',
  name: 'Nós e ferramentas',
  icon: Icons.handyman_outlined,
  summary: 'Nós essenciais, faca, corda e mochila.',
  articles: [
    Article('nud_esenciales', 'Os 6 nós essenciais', r'''
## Lais de guia (bowline)
Laço fixo que não fecha nem solta. Para resgate, amarrar numa árvore, amarrar-se pela cintura.
"O coelho sai da toca, dá a volta na árvore e volta para a toca": faça um olhal pequeno, passe a ponta de baixo para cima, contorne a corda principal por trás e desça de novo pelo olhal.

## Volta do fiel (ballestrinque)
Amarrar rápido num poste. Duas voltas cruzadas, a segunda passa por baixo de si mesma.

## Nó direito
Unir duas cordas da mesma grossura e ataduras. Direita sobre esquerda, depois esquerda sobre direita.

## Nó de tensão ajustável (taut-line)
Para esticar cordas de barraca e lona; desliza para ajustar mas segura com carga.

## Oito
Trava no fim da corda para não sair de um furo. Base dos nós de escalada.

## Nó de lenhador (timber hitch)
Arrastar troncos. Contorne e enrole a ponta sobre si mesma 3 vezes. Solta fácil.

* Pratique cada nó de olhos fechados: numa emergência pode ser de noite ou com frio.
'''),
    Article('nud_mochila', 'Mochila de 72 horas', r'''
Uma mochila pronta para sair em minutos.

- Água: 3 litros por pessoa + método de purificação.
- Comida: 3 dias de alimentos que não precisem cozinhar (barras, amendoim, atum, rapadura).
- Lanterna de cabeça + pilhas, ou lanterna de dínamo.
- Isqueiro, fósforos em saco hermético, ferrocério.
- Canivete multiuso.
- Kit de primeiros socorros e remédios pessoais.
- Manta térmica, poncho ou lona, corda (15 m).
- Muda de roupa, meias, gorro.
- Apito.
- Cópias de documentos em saco plástico, dinheiro em notas pequenas.
- Bateria externa carregada, rádio a pilha ou dínamo.
- Caderno, lápis, mapa em papel da sua região.
- Higiene: sabão, escova, papel, absorventes, máscaras.

* Use a lista de verificação do Inventário para revisar sua mochila.
'''),
    Article('nud_cuchillo', 'Faca e machado: uso seguro', r'''
- Corte sempre afastando do corpo; nada na frente da lâmina ("triângulo de sangue": parte interna das coxas e virilha).
- Uma faca afiada é mais segura que uma cega: escorrega menos.
- Afie numa pedra lisa molhada num ângulo de uns 20°, o mesmo número de passadas de cada lado.
- Machado: pés bem afastados, corte com o tronco sobre outro tronco, nunca no chão em direção aos pés.
- Guarde na bainha e seca; passe óleo na lâmina para evitar ferrugem.
'''),
  ],
  quiz: [
    Question('O nó que forma um laço fixo para resgate é:',
        ['Direito', 'Lais de guia', 'Oito', 'Volta do fiel'], 1,
        'O lais de guia não fecha nem solta com carga.'),
    Question('Quanta água leva a mochila de 72 h por pessoa?',
        ['1 copo', '3 litros no mínimo', '20 litros', 'Nada'], 1,
        'Uns 3 litros mais um método para purificar.'),
    Question('Uma faca cega é mais segura?',
        ['Sim', 'Não, escorrega mais e exige mais força', 'Igual', 'Depende da cor'], 1,
        'Um bom fio exige menos força e escorrega menos.'),
  ],
);

// =====================================================================
// DESASTRES E PERIGOS
// =====================================================================
const desastresPt = Category(
  id: 'desastres',
  name: 'Desastres e perigos',
  icon: Icons.warning_amber_outlined,
  summary: 'Terremotos, enchentes, vulcões, epidemias e segurança.',
  articles: [
    Article('des_sismo', 'Terremoto', r'''
Muitas regiões da América Latina estão em zona de alto risco sísmico.

## Durante
- ABAIXE-SE, CUBRA-SE e SEGURE-SE: debaixo de uma mesa firme, ou junto a uma parede interna cobrindo cabeça e pescoço.
- Longe de janelas, estantes e objetos que possam cair.
- Não corra para a rua durante o tremor nem use elevadores.
- Se estiver fora: afaste-se de prédios, postes e fios.

## Depois
- Espere réplicas.
- Verifique cheiro de gás: se sentir, não acenda nada, abra e saia.
- Corte a luz e o gás se puder.
- Se ficar preso: cubra a boca, bata em canos ou paredes (três batidas), use apito; grite só se necessário para poupar energia.
'''),
    Article('des_inundacion', 'Enchentes e avalanches de lama', r'''
- Suba para áreas altas imediatamente. Não espere a água chegar.
- 15 cm de água correndo podem derrubar você; 60 cm podem arrastar um carro.
- Não atravesse rios cheios. Se precisar atravessar: no trecho mais largo e lento, de frente para a correnteza na diagonal, com um pau como terceiro apoio, mochila solta da cintura.
- Escute: um rugido forte rio acima ou água turva com troncos pode anunciar uma avalanche de lama. Suba pelas laterais, não rio abaixo.
- A água da enchente está contaminada: não beba sem purificar.
'''),
    Article('des_volcan', 'Erupção vulcânica e cinzas', r'''
- Afaste-se dos leitos de rios que descem do vulcão: os lahares (fluxos de lama) viajam muito rápido.
- Proteja a respiração: máscara N95 ou pano úmido.
- Óculos fechados para os olhos.
- Limpe as cinzas dos telhados: pesam muito e os derrubam.
- Cubra as caixas-d'água.
'''),
    Article('des_epidemia', 'Epidemias e quarentena', r'''
- Lavar as mãos com sabão por 20 segundos: a medida mais eficaz.
- Isole os doentes num espaço à parte, com uma só pessoa cuidando deles.
- Máscara para o doente e para o cuidador.
- Utensílios separados; lave roupa e pratos com água quente e sabão.
- Enterre ou queime fezes e resíduos longe (no mínimo 30 m) da água.
- Quarentena: quem chega de fora espera 14 dias separado do grupo se houver uma doença contagiosa ativa.
'''),
    Article('des_nuclear', 'Acidente nuclear ou químico', r'''
## Radiação / explosão
- Entre num prédio sólido, no centro e no porão se houver: longe de telhados e paredes externas.
- Fique dentro no mínimo 24 horas: a radiação do pó radioativo cai rápido nos primeiros dias.
- Ao entrar: tire a roupa de cima (elimina grande parte do pó), ponha num saco e lave-se com água e sabão; não use condicionador.
- Água e comida em recipientes fechados são seguras.

## Químico
- Suba para andares altos (muitos gases são mais pesados que o ar).
- Feche janelas, desligue a ventilação, vede frestas com pano úmido e fita.
'''),
    Article('des_seguridad', 'Segurança pessoal e do grupo', r'''
- Discrição: não mostre suas provisões; muita gente desesperada pode se tornar perigosa.
- Luz e fumaça denunciam sua posição à noite: cubra as janelas.
- Desloquem-se em grupo; combinem sinais e pontos de encontro.
- Turnos de guarda à noite: 2 horas por pessoa.
- Combinem palavras-chave para se reconhecer.
- Evite conflitos: negociar e se retirar quase sempre é melhor que brigar. Uma ferida sem médico pode ser fatal.
'''),
  ],
  quiz: [
    Question('Durante um terremoto você deve:',
        ['Correr para a rua', 'Abaixar-se, cobrir-se e segurar-se', 'Usar o elevador', 'Ficar junto a uma janela'], 1,
        'Correr durante o tremor causa muitas lesões por queda de objetos.'),
    Question('Quanta água correndo pode derrubar uma pessoa?',
        ['2 metros', '15 cm', '1 metro', '5 cm nunca'], 1,
        'Uns 15 cm de água rápida podem derrubar você.'),
    Question('Depois de uma chuva radioativa, o que fazer ao entrar em casa?',
        ['Nada', 'Tirar a roupa de cima e lavar-se', 'Abrir janelas', 'Ir ao telhado'], 1,
        'Grande parte da contaminação fica na roupa de cima.'),
    Question('Diante de gases químicos convém...',
        ['Ir ao porão', 'Subir para andares altos e vedar', 'Sair correndo', 'Abrir janelas'], 1,
        'Muitos gases tóxicos são mais pesados que o ar.'),
  ],
);
