import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// FOOD
// =====================================================================
const foodEn = Category(
  id: 'comida',
  name: 'Food',
  icon: Icons.restaurant_outlined,
  summary: 'Rations, fishing, insects and food preservation.',
  articles: [
    Article('com_raciones', 'Rations and nutrition', r'''
## Calories
- Resting adult: about 1,800–2,000 kcal/day. With physical work: 2,500–3,500.
- You can survive weeks on much less, but strength and judgment drop.

## Prioritize
- Carbohydrates: rice, raw cane sugar, plantain, cassava, potato, oats, corn.
- Protein: beans, lentils, chickpeas, eggs, fish, canned tuna.
- Fat (more energy per gram): oil, peanuts, coconut, avocado.
- Salt: essential in heat and when sweating.

## Emergency pantry (lasts years)
White rice, lentils, dry beans, raw cane sugar, salt, honey, oats, oil, canned goods, peanuts. Rotate what you buy: oldest first.

* Combining rice + beans or corn + beans gives complete protein.
! If you have little water, eat little and avoid salty or protein-rich foods: they increase thirst.
'''),
    Article('com_insectos', 'Edible insects', r'''
Insects are one of the most abundant and easiest proteins to get. In Colombia the "hormiga culona" (big-bottomed ant, Santander) is a traditional delicacy.

## Generally safe (always cooked)
@ hormiga_culona, mojojoy, lombriz
- Leafcutter queen ants, grasshoppers and crickets (remove legs and wings).
- Beetle larvae from rotting logs (mojojoy in the Amazon).
- Termites.
- Earthworms (purge in clean water for a few hours first).

## Avoid
- Brightly colored or foul-smelling insects.
- Hairy insects (caterpillars).
- Flies, ticks, mosquitoes (they carry diseases).
- Spiders, centipedes and scorpions.

! Always cook insects: toasted or boiled. It kills parasites.
'''),
    Article('com_pesca', 'Survival fishing', r'''
## Improvised hook
Bent safety pin, fish bone, paper clip, cut soda can.

## Set line
Several baited hooks on a line tied to a flexible branch on the bank. Check it morning and evening: it fishes while you do other things.

## Bottle trap
Cut a large bottle, put the neck part upside down inside the body, add bait. Fish get in and can't find the way out.

## Where
- Dawn and dusk.
- Shady pools, under logs, eddies behind rocks.

* Bait: worms, insects, other fish guts, ripe fruit.
! Never eat fish from water contaminated by mines or factories, or fish that smells bad or has sunken eyes and gray gills.
'''),
    Article('com_conservar', 'Preserving food without a fridge', r'''
## Drying
- Cut thin strips of lean meat (no fat) or fruit.
- In the sun with good ventilation and protected from flies (mesh), or over smoke.
- It's ready when it bends and cracks, with no moisture.

## Smoking
Smoke from non-resinous woods (guava, for example) for many hours over a low fire. It dries and protects the meat.

## Salting
Cover meat or fish completely in salt. Salt draws out water and slows bacteria. Soak to remove salt before cooking.

## Others
- Pickling in vinegar.
- Jams: lots of sugar preserves fruit.
- Tubers (potato, unpeeled cassava) in a cool, dark place; cassava spoils 2–3 days after harvest, so harvest what you will eat.
- Dry grains in closed containers against weevils and mice.

! Bulging, leaking cans, cans dented at the seam or that smell bad: throw them away. Botulism is deadly.
'''),
    Article('com_cocinar', 'Cooking with little fuel', r'''
- Soak grains (beans, lentils) overnight: it halves the cooking time.
- Always cover the pot.
- "Heat-retention box": boil 5–10 minutes, then put the covered pot in a box or hole surrounded by blankets, straw or clothes. It finishes cooking by itself for hours.
- Solar cooker: box lined with aluminum foil, black pot, glass lid.
- "Rocket" stove: L-shaped tube that burns little wood very efficiently.
'''),
  ],
  quiz: [
    Question('Which combination gives complete protein:',
        ['Rice + beans', 'Sugar + salt', 'Water + raw sugar', 'Potato + cassava'], 0,
        'Grains + legumes complement each other\'s amino acids.'),
    Question('Which insect should you avoid?',
        ['Cricket', 'Leafcutter queen ant', 'Hairy, colorful caterpillar', 'Termite'], 2,
        'Bright colors and hairs often signal toxins or irritants.'),
    Question('A bulging can should be...',
        ['Boiled longer', 'Thrown away', 'Eaten quickly', 'Kept'], 1,
        'It may contain botulism, which is deadly.'),
    Question('The "heat-retention box" is used to...',
        ['Cool food', 'Finish cooking without using fuel', 'Store water', 'Dry clothes'], 1,
        'Retained heat keeps cooking without fire.'),
  ],
);

// =====================================================================
// PLANTS AND FRUITS
// =====================================================================
const plantsEn = Category(
  id: 'plantas',
  name: 'Fruits and plants',
  icon: Icons.eco_outlined,
  summary: 'What you can eat, what kills and how to recognize it (Colombia and the tropics).',
  articles: [
    Article('pla_reglas', 'Golden rules for wild plants', r'''
! If you are not 100 % sure what plant it is, do NOT eat it. Many deadly plants look like edible ones.

## Danger signs (avoid)
- Milky or white sap (with known exceptions such as papaya or fig).
- Smell of bitter almonds or peach when broken.
- Leaves in groups of three.
- Very brightly colored fruits you don't know.
- Seeds inside unknown pods.
- Mushrooms: NEVER eat them without an expert. The deadliest look harmless.

## Prefer what you know
Abandoned cultivated fruit (farms, yards, parks) is much safer than unknown wild plants.

## Universal edibility test (last resort)
Only if there is no other option and the plant is abundant. It takes almost a day per plant part:
1. Fast 8 hours. Test a single part (leaf, root, fruit) of a single plant.
2. Rub on your wrist for 15 min. If it burns or rashes, discard.
3. Put a piece on your lip for 3 min, then on your tongue for 15 min without swallowing.
4. Chew and hold in your mouth for 15 min without swallowing.
5. Swallow a little and wait 8 hours eating nothing else.
6. If there are no symptoms, eat ¼ cup cooked and wait another 8 hours.
! This test is NOT safe against all toxins (some act days later). It is a last resort.
'''),
    Article('pla_frutas', 'Common fruits of Colombia', r'''
These fruits are easy to identify and appear on farms, yards and roadsides.

## Hot climate (0–1,000 m)
@ mango, guayaba, papaya, guanabana, coco, platano, maracuya, mamoncillo, borojo, chontaduro
- Mango: large tree, hanging fruit. The peel can irritate some people's skin.
- Guava: smooth bark that peels, cinnamon colored. Green/yellow fruit with a strong smell. Leaf tea helps with diarrhea.
- Papaya: branchless trunk, big leaves at the top, fruit attached to the trunk.
- Soursop: green fruit with soft "spines", white pulp. Don't eat the seeds.
- Coconut: sterile water inside green coconuts; fat-rich flesh.
- Plantain and banana: the flower (bud) is also eaten cooked.
- Passion fruit: vine, yellow fruit, sour pulp with seeds.
- Spanish lime (mamoncillo): clusters of green balls. Careful: children choke on the seed.
- Borojó (Pacific): very nutritious brown fruit.
- Peach palm (chontaduro, spiny palm): always COOKED; raw it irritates.

## Temperate and cold climate (1,000–3,000 m)
@ mora, lulo, tomate_arbol, uchuva, granadilla, aguacate
- Andean blackberry: thorny bramble, black/red fruit.
- Lulo (naranjilla): big leaves with purple spines, fuzzy orange fruit.
- Tree tomato (tamarillo): shrub, oval red/orange fruit.
- Cape gooseberry (uchuva): shrub, yellow fruit inside a papery "husk". Only the ripe fruit!
- Banana passion fruit and sweet granadilla: Passiflora vines.
- Feijoa, avocado, citrus (orange, tangerine, lime).

* Ripe fruit has more sugar and fewer toxins than unripe fruit.
'''),
    Article('pla_toxicas', 'Dangerous plants in Colombia', r'''
! Learn to recognize these plants. They can kill or leave serious injuries.
@ manzanillo, borrachero, higuerilla, adelfa, chocho, cicuta, dieffenbachia, amanita_phalloides

- Manchineel (Caribbean and Pacific coasts): tree with fruit like small green apples. Fruit, sap and even rain dripping from its leaves cause severe burns. Never shelter under it or burn its wood.
- Angel's trumpet (borrachero, Brugmansia): large hanging trumpet-shaped flowers, white, yellow or pink. Very toxic: delirium, paralysis, death.
- Castor bean (higuerilla): big palmate leaves, fruit with soft spines. Its seeds contain ricin, deadly.
- Bitter cassava: contains cyanide. Sweet cassava can be eaten cooked, but if you don't know which it is, peel, grate, soak and cook it very well. Never raw.
- Peach, apple and cherry seeds: contain cyanide compounds; don't crush or eat them in quantity.
- Potato and tomato leaves and stems, and green or sprouted potatoes: solanine. Remove the green parts.
- Dieffenbachia (spotted-leaf garden plant): swells the mouth and throat.
- Wild mushrooms: many are deadly. No.

## If someone is poisoned
- Don't induce vomiting if they are drowsy or swallowed something corrosive.
- Keep a sample of the plant.
- If there is activated charcoal and they are conscious, it may help.
- Hydration and watch their breathing.
'''),
    Article('pla_medicinales', 'Traditional medicinal plants', r'''
These plants are traditionally used for minor complaints. They do not replace a doctor.
@ manzanilla, hierbabuena, sabila, calendula, jengibre, limoncillo, llanten, toronjil, eucalipto

- Chamomile: tea for nerves, cramps and digestion.
- Spearmint / mint: stomach ache, gas, nausea.
- Aloe vera: the inner gel soothes minor burns and scrapes.
- Calendula: compresses for small wounds and skin irritation.
- Ginger: nausea and motion sickness.
- Garlic: mild antibacterial.
- Guava leaves: tea for diarrhea.
- Lemongrass: relaxing tea.
- Eucalyptus: steam for congestion (don't swallow the oil).

! No plant cures serious infections, pneumonia or high fevers. Pregnant women and young children: avoid remedies without expert advice.
'''),
  ],
  quiz: [
    Question('Which coastal tree causes burns even with the water dripping from its leaves?',
        ['Mango', 'Manchineel', 'Guava', 'Coconut'], 1,
        'Manchineel (Hippomane mancinella) is one of the most toxic trees in the world.'),
    Question('Peach palm (chontaduro) should be eaten...',
        ['Raw', 'Cooked', 'With the seed', 'Unripe'], 1,
        'Raw it irritates; cooked it is nutritious.'),
    Question('Large hanging trumpet flowers (angel\'s trumpet) are...',
        ['Edible', 'Safe medicine', 'Very toxic', 'Good for tea'], 2,
        'Brugmansia causes delirium, paralysis and can kill.'),
    Question('What should you do with wild mushrooms you don\'t know?',
        ['Cook them well', 'Try a small one', 'Not eat them', 'Eat them with salt'], 2,
        'Deadly mushrooms don\'t become safe by cooking.'),
    Question('The water of a green coconut is...',
        ['Dangerous', 'Practically sterile and drinkable', 'Salty', 'Poisonous'], 1,
        'The water inside a healthy coconut is sealed and safe.'),
  ],
);
