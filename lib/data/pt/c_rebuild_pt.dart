import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// RECONSTRUIR A SOCIEDADE
// =====================================================================
const reconstruirPt = Category(
  id: 'reconstruir',
  name: 'Reconstruir a sociedade',
  icon: Icons.foundation_outlined,
  summary: 'Agricultura, higiene, energia, construção, comunidade e conhecimento.',
  articles: [
    Article('rec_prioridades', 'Por onde começar', r'''
Sobreviver à primeira semana é uma coisa; viver os próximos anos é outra. Uma comunidade sustentável precisa, nesta ordem:

1. Água segura e saneamento (latrinas longe da água).
2. Comida renovável: hortas, sementes, animais.
3. Abrigo duradouro.
4. Saúde: higiene, partos, feridas, conhecimento médico básico.
5. Organização: regras, divisão de tarefas, resolução de conflitos.
6. Ferramentas e ofícios: carpintaria, ferraria, tecidos, cerâmica.
7. Conhecimento: ensinar as crianças a ler, escrever, contar e os ofícios.
8. Energia e comunicação.

* Os livros e o conhecimento valem tanto quanto a comida. Resgate bibliotecas, manuais técnicos e livros escolares.
'''),
    Article('rec_huerta', 'Horta: cultivar sua comida', r'''
## Cultivos fáceis e produtivos
- Clima quente: mandioca, banana-da-terra, milho, feijão, abóbora, batata-doce, mamão, inhame.
- Clima frio: batata, fava, ervilha, milho, cebola, alho, repolho, cenoura, quinoa.
- Rápidos (colheita em 30–60 dias): rabanete, alface, espinafre, coentro, acelga.
- Perenes que alimentam por anos: banana, frutíferas, abacate, guandu, moringa.
@ yuca, platano, ahuyama, moringa, amaranto

## Passos básicos
1. Lugar com pelo menos 6 horas de sol e perto da água.
2. Afofe a terra 20–30 cm e misture composto ou esterco bem curtido.
3. Semeie a uma profundidade de 2–3 vezes o tamanho da semente.
4. Regue cedo pela manhã ou ao entardecer.
5. Cubra o solo com folhas secas ou palha (cobertura morta): conserva a umidade e freia o mato.

## A "milpa" ou três irmãs
Milho + feijão + abóbora juntos: o milho sustenta o feijão, o feijão fixa nitrogênio no solo e a abóbora cobre o chão. Sistema indígena americano testado por milhares de anos.

## Rotação de culturas
Não plante o mesmo no mesmo lugar a cada temporada. Alterne: folhas → frutos → raízes → leguminosas (feijão, ervilha), que recuperam o solo.
'''),
    Article('rec_semillas', 'Guardar sementes', r'''
Sem sementes não há futuro. Guardá-las é a tarefa mais importante a longo prazo.

- Use variedades crioulas ou tradicionais (não híbridas F1): suas sementes dão plantas iguais à mãe.
- Escolha as melhores plantas (sadias, produtivas) para semente, não as sobras.
- Deixe o fruto amadurecer completamente na planta (feijão seco na vagem, abóbora bem madura).
- Seque as sementes à sombra por vários dias.
- Guarde em potes de vidro fechados, lugar fresco, seco e escuro. Um pouco de cinza ou arroz seco absorve a umidade.
- Etiquete: espécie, variedade, data.
- Teste de germinação: 10 sementes em papel úmido; se 7 germinarem, você tem 70 %.

* A mandioca, a banana e a batata se propagam por manivas, mudas e tubérculos, não por semente.
'''),
    Article('rec_compost', 'Composto e solo fértil', r'''
- Misture materiais "verdes" (restos de cozinha, capim fresco, esterco) e "marrons" (folhas secas, palha, papelão) na proporção aproximada de 1:2.
- Deve ficar úmido como uma esponja espremida.
- Revire a cada 1–2 semanas para arejar.
- Em 2–3 meses você terá terra escura com cheiro de mata.
- Não ponha carne, gordura nem fezes de cachorro ou humanas no composto da horta.

* A urina humana diluída (1 parte para 8–10 de água) é um adubo rico em nitrogênio; aplique no solo, não nas folhas que se comem cruas.
'''),
    Article('rec_animales', 'Animais de criação', r'''
@ gallina, cuy, conejo, tilapia, abeja_miel
- Galinhas: as mais fáceis. Ovos diários, carne, comem sobras e insetos. Precisam de galinheiro fechado à noite.
- Coelhos e porquinhos-da-índia: reproduzem-se rápido, comem capim e sobras, carne magra.
- Cabras: leite, carne, adaptam-se a terreno pobre.
- Abelhas: mel (adoçante, remédio, conservante), cera e polinização das plantações.
- Peixes em tanque (tilápia, tambaqui) em clima quente.

! Lave muito bem as mãos depois de lidar com animais e cozinhe bem a carne e os ovos.
'''),
    Article('rec_higiene', 'Higiene e saneamento', r'''
O saneamento salvou mais vidas na história do que quase qualquer remédio.

## Latrina de fossa
- No mínimo 30 m de distância de poços e fontes de água, e abaixo deles no terreno.
- Fossa de 1,5–2 m de profundidade.
- Depois de cada uso: um punhado de cinza, cal ou terra. Reduz cheiro e moscas.
- Tampa. Quando estiver a 50 cm da borda, cubra de terra e cave outra.

## Lavar as mãos
Com sabão, sempre: depois do banheiro, antes de cozinhar e comer, depois de cuidar de doentes. Uma estação de lavagem com um galão pendurado e um palito ("tippy tap") economiza água.

## Sabão caseiro
O sabão se faz com gordura + álcali (lixívia). A lixívia tradicional se obtém filtrando água através de cinza de madeira dura.
! A lixívia queima a pele e os olhos: use luvas, óculos e recipientes que não sejam de alumínio.

## Lixo
Separe: orgânico para o composto; o resto enterrado ou queimado longe das casas e da água.
'''),
    Article('rec_energia', 'Energia e luz', r'''
- Painéis solares: resgate de telhados, placas de trânsito ou calculadoras. Um painel + controlador de carga + bateria de carro dá luz e carrega celulares.
- As baterias de chumbo de carros podem ser recarregadas com painéis; não as descarregue abaixo de 50 %.
- Dínamos de bicicleta geram eletricidade pedalando.
- Água: uma roda num córrego com queda pode mover um moinho ou um pequeno gerador.
- Luz: lamparinas a óleo (óleo vegetal + pavio de algodão), velas de cera de abelha ou sebo.
- Calor: fogões a lenha eficientes ("rocket", fogão de barro).

* Poupe o celular: modo avião, brilho baixo, tema escuro (este app já usa) e carregue durante o dia com o sol.
'''),
    Article('rec_construccion', 'Construção tradicional', r'''
Técnicas com materiais locais usadas na América Latina há séculos:

- Pau a pique (taipa de mão): estrutura de bambu ou madeira preenchida com barro misturado com palha. Resiste bem a tremores por ser flexível.
- Adobe: blocos de barro + palha secos ao sol. Grossos, frescos de dia e mornos à noite. Fracos diante de terremotos se não forem reforçados.
- Taipa de pilão: terra úmida compactada em fôrmas de madeira.
@ guadua
- Bambu gigante (guadua): "o aço vegetal". Forte, flexível e cresce rápido. Corte maduro (3–5 anos) e cure (imersão em água ou fumaça) para que os insetos não o ataquem.

## Princípios
- Fundações de pedra que elevem a parede acima do chão: a água destrói o barro.
- Beirais longos no telhado: protegem as paredes da chuva.
- Telhados leves em áreas sísmicas.
'''),
    Article('rec_comunidad', 'Organizar uma comunidade', r'''
## Primeiros acordos
- Censo: nomes, habilidades (médicos, agricultores, mecânicos, professores, cozinheiros), saúde e necessidades.
- Inventário comum dos recursos-chave (água, comida, remédios, ferramentas).
- Regras simples e claras, escritas e aceitas por todos.
- Assembleia periódica para decisões importantes.

## Dividir o trabalho
Rodízio das tarefas pesadas (água, guarda, latrinas). Cada um contribui conforme sua capacidade.

## Resolver conflitos
- Ouvir as duas partes separadamente e depois juntas.
- Mediador neutro.
- Sanções proporcionais e conhecidas de antemão.
- Roubar comida ou água comuns e a violência são as faltas mais graves.

## Troca e comércio
Bens de valor depois de um colapso: sal, água potável, remédios, sementes, ferramentas, sabão, isqueiros, álcool (desinfetante), conhecimento (curar, consertar, ensinar).

* As comunidades que cooperam sobrevivem melhor que indivíduos isolados. É a lição mais repetida da história.
'''),
    Article('rec_conocimiento', 'Conhecimento básico para recomeçar', r'''
## Método científico
Observe → pergunte → hipótese → experimente (mudando uma coisa de cada vez) → registre → conclua. Assim se melhora tudo: plantações, medicina, ferramentas.

## Máquinas simples
Alavanca, polia, plano inclinado, roda e eixo, cunha e parafuso. Com elas uma pessoa move cargas enormes.
- Alavanca: quanto mais longe do ponto de apoio você empurra, menos força precisa.
- Polia dupla: reduz a força pela metade.

## Medir
- Um passo médio ≈ 0,75 m; conte passos duplos para medir distâncias.
- Um litro = 1 kg de água.
- Calendário: registre luas e chuvas para planejar plantios.

## Química útil
- Cinza + água = lixívia (álcali) → sabão.
- Cal (calcário queimado) → argamassa, desinfetar latrinas, corrigir solos ácidos.
- Carvão vegetal: madeira queimada sem oxigênio (enterrada ou em forno fechado). Combustível potente e filtro.
- Álcool por fermentação de fruta ou cana + destilação: desinfetante e combustível.

## Educação
Ensine todas as crianças a ler, escrever e as quatro operações. Escreva o que você sabe: o conhecimento que não se escreve se perde numa geração.
'''),
    Article('rec_parto', 'Parto de emergência', r'''
A maioria dos partos dá certo sozinha. Seu trabalho é ajudar, manter limpo e não apressar.

- Lave muito bem as mãos, tenha panos limpos, água fervida, algo para amarrar o cordão (cadarços fervidos) e uma lâmina ou tesoura fervida.
- Deixe a mãe ficar na posição que quiser.
- Não puxe o bebê: segure a cabeça conforme ela sai.
- Se o cordão estiver em volta do pescoço, passe-o suavemente por cima da cabeça.
- Seque o bebê, coloque-o pele com pele sobre o peito da mãe e cubra os dois.
- Se não chorar nem respirar: esfregue as costas, limpe boca e nariz.
- Espere o cordão parar de pulsar. Amarre em dois pontos (a 10 e 15 cm do bebê) e corte entre eles.
- A placenta sai sozinha em uns 30 minutos. Não puxe o cordão. Amamentar ajuda o útero a se contrair.

! Sangramento abundante depois do parto: massageie com firmeza a parte baixa do abdômen (útero) e ponha o bebê para mamar.
'''),
  ],
  quiz: [
    Question('A "milpa" ou três irmãs combina:',
        ['Batata, mandioca e arroz', 'Milho, feijão e abóbora', 'Café, cacau e cana', 'Trigo, cevada e aveia'], 1,
        'Um sistema indígena em que cada planta ajuda as outras.'),
    Question('A que distância mínima da água fica uma latrina?',
        ['3 m', '30 m', '1 m', 'Não importa'], 1,
        'Pelo menos 30 m e abaixo da fonte no terreno.'),
    Question('Que sementes convém guardar?',
        ['Híbridas F1', 'Crioulas ou tradicionais', 'Qualquer uma', 'As de plantas doentes'], 1,
        'As crioulas reproduzem a planta mãe; as híbridas não.'),
    Question('A lixívia para fazer sabão se obtém de...',
        ['Areia', 'Cinza de madeira e água', 'Sal', 'Açúcar'], 1,
        'A água filtrada pela cinza é alcalina.'),
    Question('O pau a pique usa...',
        ['Cimento e ferro', 'Bambu ou madeira com barro e palha', 'Vidro', 'Plástico'], 1,
        'Técnica tradicional flexível e resistente a tremores.'),
    Question('Num parto de emergência, se puxa o cordão para tirar a placenta?',
        ['Sim, forte', 'Não, sai sozinha', 'Sim, com pinça', 'Só se o bebê chorar'], 1,
        'Puxar pode causar uma hemorragia grave.'),
  ],
);

// =====================================================================
// MENTE E LIDERANÇA
// =====================================================================
const mentePt = Category(
  id: 'mente',
  name: 'Mente e liderança',
  icon: Icons.psychology_outlined,
  summary: 'Controlar o medo, manter o moral e liderar.',
  articles: [
    Article('men_miedo', 'Controlar o pânico', r'''
O pânico mata mais que muitas feridas: leva a decisões ruins.

## Respiração quadrada (usada por militares)
Inspire 4 segundos → segure 4 → expire 4 → segure 4. Repita 4 vezes.

## Técnica 5-4-3-2-1
Nomeie 5 coisas que você vê, 4 que toca, 3 que ouve, 2 que cheira, 1 que saboreia. Traz você de volta ao presente.

## Mentalidade
- Divida os problemas em tarefas pequenas: "agora só preciso de água".
- Comemore cada conquista.
- Aceite o que não pode mudar; foque no que pode.
'''),
    Article('men_moral', 'Moral do grupo', r'''
- Rotinas diárias: horários para comer, trabalhar, descansar. Dão sensação de controle.
- Cada pessoa precisa se sentir útil.
- Momentos de descanso, jogos, música e histórias.
- Falar do luto; não esconder as perdas.
- Cuide especialmente de crianças e idosos: precisam de explicações simples e presença.
- Durma: a falta de sono destrói o juízo e o humor.
'''),
    Article('men_lider', 'Liderar na crise', r'''
- Decida rápido com a informação disponível; uma decisão razoável a tempo é melhor que uma perfeita tarde demais.
- Comunique com clareza: o que está acontecendo, o que faremos, o que preciso de cada um.
- Dê o exemplo: o líder come por último e trabalha como os demais.
- Ouça os especialistas do grupo.
- Delegue: ninguém consegue fazer tudo.
- Admita erros e corrija.
'''),
  ],
  quiz: [
    Question('A respiração quadrada é:',
        ['4-4-4-4 segundos', 'Rápida e curta', 'Segurar 1 minuto', 'Só expirar'], 0,
        'Inspirar, segurar, expirar e segurar 4 segundos cada.'),
    Question('Um bom líder na crise...',
        ['Come primeiro', 'Dá o exemplo e delega', 'Decide sozinho sem ouvir', 'Esconde a informação'], 1,
        'O exemplo e a delegação mantêm a confiança.'),
  ],
);
