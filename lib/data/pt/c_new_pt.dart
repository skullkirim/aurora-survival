import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// HIGIENE E KIT CASEIRO
// =====================================================================
const higienePt = Category(
  id: 'higiene',
  name: 'Higiene e kit caseiro',
  icon: Icons.sanitizer_outlined,
  summary: 'Sabão, desinfetantes, álcool em gel, soro, esterilizar e vacinas: o que dá para fazer em casa.',
  articles: [
    Article('hig_manos', 'Higiene que salva vidas', r'''
A diarreia e as infecções matam mais gente nos desastres do que a fome. Quase todas se evitam com água limpa, sabão e uma latrina longe da água.

## Lavar as mãos
- Com água e sabão por 20 segundos (o tempo de cantar "Parabéns" duas vezes): palmas, costas, entre os dedos, unhas.
- Sempre: depois do banheiro, antes de cozinhar e comer, depois de tocar carne crua, feridas, lixo ou animais.
- Sem sabão: cinza de lenha esfregada com água também limpa.
* Faça uma "torneira de galão": um galão pendurado com um furo tampado por um palito. Gasta pouquíssima água.

## Água e comida
- Água para beber e escovar os dentes: fervida, clorada ou filtrada.
- Tampe a comida e a água: moscas e baratas levam micróbios.
- O lixo longe e tampado ou enterrado.

## Dentes e corpo
- Escova de raminho mastigado (goiabeira, limoeiro) se não houver escova; bicarbonato ou sal no lugar da pasta.
- Absorventes de pano: lave com sabão, seque ao sol e guarde limpos.
- Roupa íntima e meias secas todo dia: evitam fungos.
! Uma só pessoa com diarreia pode contagiar o grupo todo: que use seu próprio copo e lave muito bem as mãos.
'''),
    Article('hig_jabon', 'Sabão caseiro com cinza e gordura', r'''
É o sabão das avós: lixívia de cinza + gordura. Serve para mãos, roupa e lavar em volta de feridas.

## 1. Lixívia de cinza
- Use cinza BRANCA de madeira dura (não de papel, plástico nem carvão comprado).
- Balde com furos embaixo, uma camada de pedrinhas e palha, e a cinza por cima.
- Despeje água de chuva quente aos poucos e recolha o líquido marrom que pinga.
- Passe de novo pela cinza até que uma pena de galinha se desfaça ou um ovo flutue nele: aí está forte.
! A lixívia QUEIMA a pele e os olhos. Luvas, óculos ou pano no rosto, e longe das crianças. Se respingar: muita água por 15 minutos.

## 2. Cozinhar o sabão
- Derreta e coe gordura (sebo de boi, banha de porco ou óleo). Proporção aproximada: 2 partes de gordura para 1 de lixívia.
- Em panela de ferro ou barro (não de alumínio), misture e ferva em fogo baixo mexendo com um pau por 1–3 horas.
- Está pronto quando engrossa como um creme e uma gota esfria firme.
- Um punhado de sal no final ajuda a endurecer.

## 3. Curar
- Despeje em fôrmas (caixas, cascas de coco) e deixe 4 semanas em lugar seco.
* Teste: se arder ou coçar na pele, ainda tem muita lixívia. Deixe mais tempo ou use só para roupa.
'''),
    Article('hig_desinfectar', 'Desinfetantes: água sanitária, álcool e vinagre', r'''
## Água sanitária (comum, 5 %)
- Superfícies, banheiros, utensílios: 1 colher de sopa (10 ml) por litro de água.
- Sangue, vômito, diarreia: 1 parte de água sanitária para 9 de água.
- Água para beber: 2 gotas por litro (4 se estiver turva), espere 30 minutos.
- Prepare a mistura todo dia: com o tempo e o sol perde força.
- Limpe primeiro a sujeira com água e sabão; a água sanitária não funciona sobre sujeira.
! NUNCA misture água sanitária com amoníaco, vinagre, ácidos ou álcool: formam-se gases tóxicos que podem matar. Use só com água e em lugares ventilados.

## Álcool
- Funciona entre 60 e 80 %. O álcool 96° se dilui: 3 partes de álcool para 1 de água fervida.
- Para mãos, termômetros, tesouras e pinças limpas.
! Pega fogo com muita facilidade: longe do fogo e de velas.

## Vinagre e limão
- Servem para tirar gordura e calcário, mas NÃO desinfetam bem. Não use em feridas nem na água de beber.

## Sol
- Roupas, lençóis e ataduras lavados e secos ao sol direto ficam muito mais limpos: a luz ultravioleta mata muitos micróbios.
'''),
    Article('hig_gel', 'Álcool em gel ou líquido (fórmula da OMS)', r'''
A Organização Mundial da Saúde publicou esta receita para lugares sem acesso a álcool em gel comercial.

## Para 1 litro
- 833 ml de álcool etílico 96°.
- 42 ml de água oxigenada 3 % (mata esporos que caiam na garrafa).
- 15 ml de glicerina (protege a pele; se não houver, pode omitir).
- Complete até 1 litro com água fervida e fria.

## Como
- Misture numa garrafa limpa com tampa e agite.
- Deixe repousar 72 horas antes de usar.
- Use uns 3 ml e esfregue as mãos até secar (20–30 segundos).
* Com álcool isopropílico 99 %: 751 ml no lugar dos 833 ml.
! Não funciona se as mãos estiverem sujas de terra ou gordura: aí lave com água e sabão. Inflamável. Não se bebe.
'''),
    Article('hig_suero', 'Soro fisiológico para lavar feridas, olhos e nariz', r'''
## Soro fisiológico caseiro
- 1 litro de água fervida por 1 minuto (3 minutos em lugares altos).
- 9 gramas de sal: uma colher de chá cheia ou uma e meia rasa. Sem iodo é melhor, mas o comum serve.
- Dissolva com a água ainda quente, tampe e deixe esfriar.
- Use no mesmo dia; o que sobrar depois de 24 horas se joga fora.

## Usos
- Lavar feridas: jogue em jato com uma garrafa ou seringa sem agulha para arrastar a terra.
- Olhos com poeira ou cinza: lave do nariz para fora.
- Nariz entupido ou com poeira: umas gotas ou lavagem suave.
! Não é para beber no lugar da água. Para desidratação use o soro oral (água, açúcar e sal) da seção de Receitas.
* A maioria das feridas só precisa ser muito bem lavada com bastante água limpa. É o que mais evita infecções.
'''),
    Article('hig_esterilizar', 'Esterilizar instrumentos e fazer ataduras', r'''
## Instrumentos (pinças, tesouras, agulhas, faca)
- Lave com água, sabão e uma escova.
- Ferva 20 minutos tampados, totalmente cobertos de água.
- Melhor: panela de pressão 15–20 minutos depois que começar a chiar (é quase uma autoclave).
- Tire com uma pinça também fervida e deixe sobre um pano limpo, coberto.
* Passar na chama serve para a ponta de uma agulha ou pinça numa emergência, mas não esteriliza o instrumento todo.

## Ataduras e gazes
- Use lençóis ou camisetas de algodão: corte em tiras de 5–10 cm.
- Ferva 20 minutos, seque ao sol e passe com ferro bem quente (ou asse numa panela tampada).
- Guarde em sacos plásticos ou potes limpos e fechados.
- Gazes: dobre quadrados de pano de algodão em 4–8 camadas.

## Kit improvisado
- Ataduras e gazes fervidas, fita adesiva, tesoura, pinça.
- Talas: papelão, revistas enroladas ou paus.
- Torniquete: pano largo (4–5 cm) e um pau para girar.
- Termômetro, luvas ou sacos plásticos limpos para as mãos.
- Mel de abelha puro: em feridas superficiais ajuda a cicatrizar (não em bebês com menos de 1 ano).
! Ferida vermelha, quente, inchada, com pus ou riscos vermelhos subindo, ou com febre: infecção. Precisa de antibiótico e de um médico.
'''),
    Article('hig_vacunas', 'Vacinas: por que não se fazem em casa e o que fazer', r'''
! Uma vacina NÃO pode ser fabricada em casa. Fazê-la exige laboratórios estéreis, culturas controladas e testes de segurança. Uma tentativa caseira não protege e pode causar infecções graves, abscessos ou a morte. Não injete nada feito em casa.

## O que você PODE fazer AGORA
- Ponha em dia o calendário de vacinas no seu posto de saúde (os programas nacionais costumam ser gratuitos).
- Tétano (dT): um reforço a cada 10 anos. É a mais importante para feridas com terra, pregos ou ferrugem.
- Pergunte por: hepatite A e B, sarampo, febre amarela (regiões quentes), gripe, e raiva se você trabalha com animais.
- Guarde as carteirinhas de vacinação da família num saco plástico com os documentos.

## Se você tiver vacinas guardadas
- Quase todas se conservam entre 2 °C e 8 °C. Sem geladeira: pote de barro dentro de outro com areia molhada (esfria ao evaporar), à sombra.
- Não congele, não deixe ao sol. Se mudarem de cor ou tiverem grumos, não servem.

## Sem vacina, prevenção
- Tétano: lave toda ferida a fundo com água e sabão e tire a terra. Feridas fundas e sujas precisam de médico.
- Raiva: se um animal morder ou arranhar, lave 15 minutos com água e sabão e procure atendimento; a vacina depois da mordida salva vidas.
- Sarampo, gripe e covid: isolar o doente, ventilar e lavar as mãos.
- Hepatite A, cólera e tifo: água fervida ou clorada e comida bem cozida.
'''),
  ],
  quiz: [
    Question('O que NUNCA se mistura com água sanitária?', ['Água', 'Amoníaco ou vinagre', 'Água de chuva', 'Nada, tudo pode'], 1,
        'Formam-se gases tóxicos. A água sanitária só se mistura com água.'),
    Question('Quanto sal leva 1 litro de soro fisiológico para feridas?', ['Uma pitada', 'Uns 9 gramas', 'Meio pacote', 'Nada'], 1,
        'Uns 9 g (uma colher de chá cheia) por litro de água fervida.'),
    Question('Como se esteriliza uma pinça?', ['Soprando', 'Com vinagre', 'Fervendo 20 minutos', 'Ao sol 5 minutos'], 2,
        'Lavar e ferver 20 minutos (ou panela de pressão).'),
    Question('Dá para fabricar uma vacina em casa?', ['Sim, com soro', 'Sim, com alho', 'Não: é perigoso e não protege', 'Só a do tétano'], 2,
        'São necessários laboratórios estéreis. O que funciona: vacinar-se antes e lavar bem as feridas.'),
  ],
);

// =====================================================================
// AUTOPROTEÇÃO E SEGURANÇA
// =====================================================================
const seguridadPt = Category(
  id: 'seguridad',
  name: 'Autoproteção e segurança',
  icon: Icons.shield_outlined,
  summary: 'Estar alerta, casa segura, deslocar-se sem risco, acalmar conflitos, defesa pessoal e proteção do corpo.',
  articles: [
    Article('seg_alerta', 'Estar alerta sem viver com medo', r'''
A melhor briga é a que não acontece. Quase sempre se evita vendo o perigo a tempo.

## Os 4 estados de alerta
- Branco: distraído (celular, fones). Evite na rua.
- Amarelo: tranquilo mas atento. É o estado normal fora de casa.
- Laranja: algo estranho (alguém te segue, um grupo te observa). Pense: por onde eu saio?
- Vermelho: perigo real. Aja: afaste-se, corra, peça ajuda.

## Hábitos
- Ao entrar num lugar, localize duas saídas.
- Olhe as mãos das pessoas: o perigo está no que fazem, não no que dizem.
- Confie na intuição: se algo parecer errado, vá embora sem dar explicações.
- Não mostre comida, dinheiro, baterias nem remédios. Quem sabe que você tem, vem buscar.
- Passe despercebido: roupa simples, sem luxos, sem contar seus planos.
- À noite, só a luz necessária e tapada para fora: uma luz é vista a quilômetros.
* Não publique nas redes onde você está, o que tem nem quando sai de casa.
'''),
    Article('seg_casa', 'Deixar sua casa mais segura', r'''
## O básico
- Portas sólidas com boa fechadura e uma tranca ou barra por dentro.
- Janelas com grades ou, pelo menos, algo que faça barulho se abrirem (latas penduradas).
- Luz ou barulho quando houver movimento lá fora: um cachorro avisa melhor que qualquer alarme.
- Conheça seus vizinhos: um quarteirão organizado se protege sozinho (turnos de guarda, apitos).

## Provisões
- Não guarde tudo num só lugar: divida em 2–3 esconderijos.
- Tenha uma "reserva para entregar" visível e pequena; a principal, escondida.

## Cômodo seguro
- Escolha um cômodo interno com porta forte: água, lanterna, rádio, kit de primeiros socorros e um jeito de pedir ajuda.
- Se entrarem para roubar com você dentro: tranque-se, faça barulho, peça ajuda. As coisas se repõem; você não.

## Outros perigos em casa
- Detector de fumaça e um extintor ou balde de areia perto da cozinha.
- Verifique se o gás não vaza (água com sabão nas conexões: se fizer bolhas, há vazamento).
- Nunca cozinhe nem ligue gerador num cômodo fechado: o monóxido mata sem cheiro.
'''),
    Article('seg_moverse', 'Deslocar-se com segurança', r'''
## Antes de sair
- Diga a alguém aonde vai, por qual caminho e a que horas volta. Se não voltar, saberão onde procurar.
- Leve água, lanterna, apito, celular carregado e algo para comer.
- Vá de dia e em grupo de 3 ou mais quando a situação estiver difícil.

## No caminho
- Evite multidões, filas de saque, postos de controle desconhecidos e ruas sem saída.
- Ande pelo meio da calçada, longe de portas e esquinas escuras.
- Se alguém te seguir: atravesse a rua, mude o ritmo, entre num lugar com gente. Não vá direto para casa.
- Em grupo: um na frente observa, um atrás vigia, e todos conhecem o sinal para fugir e o ponto de reencontro.

## De carro
- Portas travadas e vidros fechados nos semáforos.
- Deixe espaço até o carro da frente para poder sair.
- Tanque sempre acima da metade.
'''),
    Article('seg_conflicto', 'Acalmar um conflito', r'''
A maioria das brigas começa por orgulho. Quem se acalma primeiro ganha.

## Como
- Distância: pelo menos dois braços. Corpo de lado, mãos abertas e visíveis na altura do peito.
- Voz baixa e lenta. Frases curtas: "Calma", "Não quero problema", "Entendo você".
- Não insulte, não zombe, não aponte o dedo, não toque.
- Escute e repita o que a pessoa pede: as pessoas se acalmam quando se sentem ouvidas.
- Dê uma saída digna: "Pronto, cada um segue seu caminho".
- Se o grupo tiver um problema interno, que fale uma pessoa de cada lado e com um terceiro tranquilo.

## Se for um assalto
! Entregue o que pedirem. Nenhum celular, comida ou dinheiro vale sua vida. Faça movimentos lentos e avise antes de se mexer ("vou pegar a carteira").
- Repare em detalhes para depois (roupa, tatuagens, para onde vão), sem ficar encarando o rosto.
'''),
    Article('seg_defensa', 'Defesa pessoal básica: para escapar', r'''
O objetivo NÃO é ganhar: é se soltar e fugir para um lugar com gente.

## Postura
- Pés afastados, um à frente, joelhos um pouco dobrados.
- Mãos para cima, abertas, na frente do rosto (parece que você pede calma, mas protege a cabeça).

## Se te agarrarem
- Pelo pulso: gire o braço na direção do polegar de quem segura (o ponto mais fraco) e puxe com força.
- Por trás: abaixe o corpo, pise com o calcanhar no peito do pé ou chute a canela, e empurre para se soltar.
- Pelo pescoço: encolha o queixo, levante os ombros e puxe as mãos dele para baixo com todo o seu peso.

## Se não houver outra saída
- Golpeie forte e rápido em áreas que dão tempo para escapar: olhos, nariz, virilha, joelho.
- Grite "SOCORRO!" ou "FOGO!": as pessoas reagem mais rápido.
- Assim que se soltar: corra. Não fique para brigar.
* Pratique esses movimentos devagar com alguém de confiança. Sob estresse, só sai o que você já praticou.
! Armas nas mãos de quem não tem treino costumam acabar usadas contra quem as carrega. Escapar quase sempre é melhor.
'''),
    Article('seg_cuerpo', 'Proteger o corpo: fumaça, sol, insetos e escombros', r'''
## Respirar
- Fumaça, cinza vulcânica ou pó de escombros: máscara N95 bem ajustada ao nariz.
- Sem N95: pano úmido dobrado sobre nariz e boca (ajuda pouco, mas algo).
- Gás ou químicos: afaste-se na direção contrária ao vento e para o alto.

## Olhos, mãos e pés
- Óculos (de sol ou de natação) contra poeira, cinza e farpas.
- Luvas de trabalho para escombros, vidros e lenha.
- Botas ou sapatos fechados sempre: um corte no pé pode incapacitar você por dias.
- Capacete ou boné grosso ao entrar em prédios danificados.

## Sol e calor
- Sombra entre 11h e 15h; chapéu de aba larga e manga comprida clara.
- Beba água mesmo sem sede. Urina escura = falta água.

## Insetos
- Mosquiteiro na cama, roupa comprida ao entardecer e repelente.
- Esvazie todo recipiente com água parada: ali nascem os mosquitos da dengue.

## Frio e chuva
- Camadas de roupa; a de fora, impermeável. Gorro e meias secas.
'''),
    Article('seg_vulnerables', 'Cuidar de crianças, idosos e pessoas vulneráveis', r'''
## Crianças
- Que saibam o nome completo, o dos pais e um número de telefone. Escreva também num papel dentro da roupa.
- Ponto de encontro combinado se se perderem: "Se nos separarmos, vamos para a igreja" (ou um lugar fixo).
- Palavra-chave da família: se alguém disser que você mandou buscá-las e não souber a palavra, elas não vão.
- Nunca sozinhas em abrigos, filas nem banheiros.

## Idosos e pessoas com deficiência
- Lista dos remédios, doses e doenças (use a Ficha médica do app).
- Quem cuida de cada pessoa numa evacuação.
- Bengala, óculos, aparelhos auditivos e carregadores na mochila de emergência.

## Em abrigos e acampamentos
- Dormir em grupos familiares, nunca isolado.
- Banheiros e latrinas iluminados, próximos e separados para mulheres e homens.
- Ir acompanhado ao banheiro à noite.
! Se alguém sofrer assédio ou abuso, acredite, ponha a pessoa em segurança e avise quem organiza o abrigo ou as autoridades.
'''),
  ],
  quiz: [
    Question('Fora de casa, o estado de alerta normal deve ser:', ['Branco (distraído)', 'Amarelo (tranquilo mas atento)', 'Sempre vermelho', 'Tanto faz'], 1,
        'Atento sem viver assustado: assim você vê o perigo a tempo.'),
    Question('Se te assaltarem com uma arma, o melhor é:', ['Brigar', 'Entregar o que pedem com movimentos lentos', 'Correr na direção do ladrão', 'Gritar com ele'], 1,
        'As coisas se repõem; sua vida não.'),
    Question('Na defesa pessoal o objetivo é:', ['Ganhar a briga', 'Soltar-se e fugir', 'Castigar o agressor', 'Tirar a arma dele'], 1,
        'Escapar para um lugar com gente é o mais seguro.'),
    Question('Para que uma criança não vá com um estranho, serve:', ['Uma palavra-chave da família', 'Dar doces', 'Nada', 'Deixá-la sozinha'], 0,
        'Se quem for buscá-la não souber a palavra-chave, ela não vai.'),
  ],
);
