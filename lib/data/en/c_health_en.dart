import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// RADIATION AND NUCLEAR
// =====================================================================
const radiationEn = Category(
  id: 'radiacion',
  name: 'Radiation and nuclear',
  icon: Icons.warning_amber_rounded,
  summary: 'Bombs, nuclear accidents, shelter, decontamination and iodide.',
  articles: [
    Article('rad_que_es', 'What radiation is (simply explained)', r'''
Radiation is invisible energy coming from radioactive materials. You can't see, smell or feel it. In large doses it damages the body's cells.

## Three types
- Alpha: stopped by a sheet of paper or skin. Dangerous only if you breathe it in, eat it or it enters a wound.
- Beta: penetrates a few millimeters; clothing partly stops it. It can burn skin if the dust stays on it.
- Gamma: very penetrating, like X-rays. Only lots of mass stops it: earth, concrete, water, brick.

## The 3 defenses
- TIME: less time exposed = less damage. Fallout loses strength very quickly.
- DISTANCE: each time you double the distance from the source, you get 4 times less.
- SHIELDING: put mass between you and the outside. The heavier, the better.

## Units
Dose is measured in Sieverts (Sv). For reference:
- A chest X-ray: 0.0001 Sv.
- 1 Sv at once: nausea, mild radiation sickness.
- 4–5 Sv at once: half of people die without medical care.
* A dosimeter or Geiger counter is the only way to measure it. If you get one, treasure it.
'''),
    Article('rad_explosion', 'If there is a nuclear explosion', r'''
## At the moment of the flash
1. DON'T look at the light: it can blind you.
2. Drop face down behind something solid (wall, ditch, curb). Cover your head and neck with your arms, mouth open.
3. The blast wave arrives seconds later (1 second per 340 m of distance). Stay down until the wind and glass have passed.

## Afterwards: GET INSIDE, STAY INSIDE, STAY TUNED
- You have about 10–20 minutes before radioactive dust falls (it looks like sand, ash or dust).
- Get into the most solid building nearby. Go to the basement or the center of the building, away from roofs and outer walls.
- Stay inside at least 24 hours, ideally 2–3 days, unless authorities say otherwise.
- Listen to a battery radio for instructions.

! Don't go out looking for relatives in the first hours: that is when radiation is highest. Agree on a meeting point beforehand.
* Use the "Radiation" tool to calculate how much the radiation has dropped.
'''),
    Article('rad_refugio', 'Fallout shelter', r'''
## What protects most
What matters is the mass between you and the radioactive dust (on the roof and on the ground outside).

Thickness that cuts radiation in HALF:
- Steel: 1.8 cm
- Concrete: 6 cm
- Packed earth: 9 cm
- Water: 18 cm
- Wood: 22 cm
With 10 of those thicknesses (for example 90 cm of earth), radiation drops about 1,000 times.

## Best places
- Basements, tunnels, underground parking, subway stations.
- The center of a large concrete building, middle floors.
- A trench covered with doors or boards and 60–90 cm of earth on top.

## Improve a makeshift shelter
- Put boxes of books, earth, water jugs or heavy furniture against walls and on top of a table where you shelter.
- Ventilation: air can be moved with a fan; radioactive dust is heavy and hardly gets in if you close up and seal gaps.
- Water: 4 L per person per day; bucket toilet with bags and a lid.
'''),
    Article('rad_descontaminar', 'Personal decontamination', r'''
If you were outside when the dust was falling:
1. Before going in, take off your outer clothing: it removes up to 90 % of the contamination. Put it in a closed bag away from people.
2. Shower with soap and water; wash your hair with shampoo. DON'T use conditioner: it sticks the dust to your hair.
3. Don't scrub hard or scratch your skin.
4. Blow your nose, clean ears, eyelids and nails.
5. If there is no shower: wipe your skin with a damp cloth, top to bottom, using a clean part each time.
6. Clean clothes that were stored away.
7. Clean pets with soap and water using gloves.

! A contaminated wound is rinsed with plenty of water before covering it.
'''),
    Article('rad_comida', 'Water and food after fallout', r'''
## Safe
- Canned food, jars, sealed bags, fridge or closed pantry.
- Wipe the outside of cans and jars before opening.
- Bottled water, water from a covered tank or the building's pipes (fill containers early).

## With care
- Fruit and vegetables from outside: wash and peel them; remove outer leaves.
- River and lake water: let it stand so the dust settles, take the top water and filter it through earth or sand. Boiling does NOT remove radioactivity.
- Milk from animals that ate contaminated grass: avoid it for the first weeks (radioactive iodine).

! Deep well water is among the safest because the ground filters the dust.
'''),
    Article('rad_yoduro', 'Potassium iodide (KI)', r'''
It protects ONLY the thyroid against radioactive iodine (typical of nuclear plant accidents). It doesn't protect against the rest of the radiation.

## When
Only if authorities say so, ideally before or right after exposure. One dose protects about 24 hours.

## Reference doses (potassium iodide tablets)
- Adults: 130 mg.
- Children 3 to 18 years: 65 mg (teens over 68 kg: 130 mg).
- Children 1 month to 3 years: 32 mg.
- Babies under 1 month: 16 mg.

! DON'T take iodized salt, iodine tincture or povidone-iodine: they don't work and can poison you.
! People over 40 only need it for very high exposures. People with thyroid problems or iodine allergy: seek advice.
'''),
    Article('rad_enfermedad', 'Radiation sickness', r'''
## Symptoms
- Nausea and vomiting in the first hours: the sooner they start, the higher the dose.
- Then there may be days when the person "seems" better.
- Later: hair loss, bleeding gums, bruises, infections, diarrhea.

## Possible care without a hospital
- Plenty of fluids with salts (oral rehydration).
- Extreme hygiene: clean hands, food and water. Defenses drop and any infection is serious.
- Rest and soft, nutritious food.
- Keep the person away from anyone with infections.

* Radiation sickness is not contagious. Caring for a sick person is safe if they have been decontaminated.
'''),
    Article('rad_central', 'Nuclear plant accident and electromagnetic pulse', r'''
## Accident at a power plant
- If you are inside the zone set by authorities: shelter inside or evacuate in the direction they indicate, perpendicular to the wind.
- Close windows and turn off ventilation.
- Potassium iodide only if instructed.

## Electromagnetic pulse (EMP)
A nuclear explosion high in the atmosphere can damage electronics over a huge area.
- Keep a small radio, flashlight and power bank inside a closed metal box (a tin or cookie box), wrapped in cloth or cardboard so they don't touch the metal: it's a "Faraday cage".
- Unplugged, switched-off devices are more likely to survive.
- Keep paper maps, manuals and books.
'''),
  ],
  quiz: [
    Question('The three defenses against radiation are:',
        ['Time, distance and shielding', 'Water, salt and iodine', 'Run, shout and jump', 'Pills, gloves and goggles'], 0,
        'Less time, more distance and more mass between you and the source.'),
    Question('After a nuclear explosion, the best thing is:',
        ['Go out to see what happened', 'Get into a solid building and stay 24 h or more', 'Go to the river', 'Go up to the roof'], 1,
        'Get inside, stay inside, stay tuned.'),
    Question('By the 7-10 rule, at 7 hours radiation is...',
        ['The same', '10 times lower than at hour 1', 'Double', '7 times higher'], 1,
        'Each time the time is multiplied by 7, it drops 10 times.'),
    Question('Does boiling water remove radioactivity?',
        ['Yes', 'No', 'Only with salt', 'Only at night'], 1,
        'Boiling kills microbes but doesn\'t remove radioactive particles; let it settle and filter it.'),
    Question('When entering the shelter after being outside:',
        ['Remove outer clothes and wash with shampoo, no conditioner', 'Use conditioner', 'Sleep like that', 'Scrub your skin hard'], 0,
        'Removing outer clothing removes up to 90 % of the contamination.'),
    Question('Potassium iodide protects...',
        ['The whole body', 'Only the thyroid', 'The lungs', 'The skin'], 1,
        'It only blocks radioactive iodine in the thyroid.'),
    Question('Which material shields best per centimeter?',
        ['Wood', 'Water', 'Concrete', 'Cloth'], 2,
        'Concrete: 6 cm halve it; wood needs 22 cm.'),
  ],
);

// =====================================================================
// MEDICINAL PLANTS
// =====================================================================
const herbalEn = Category(
  id: 'medicina_natural',
  name: 'Medicinal plants',
  icon: Icons.spa_outlined,
  summary: 'Which plants to gather, what they are for and how to prepare them.',
  articles: [
    Article('med_reglas', 'Before using a medicinal plant', r'''
! Medicinal plants DO have effects and can also poison. Use them for minor complaints; serious illnesses need medicine.

- Identify the plant with certainty: look at the photo, leaves, flowers, smell and where it grows. If in doubt, don't use it.
- Gather far from roads, dumps, mines and sprayed crops.
- Start with a small amount and watch for 24 hours.
- One plant at a time: that way you know which one works or which one caused harm.
- Pregnant women, babies, young children and people with liver or kidney disease: avoid remedies or use only the mildest (chamomile, spearmint) in small amounts.
- Stop if a rash, vomiting, dizziness or pain appears.
'''),
    Article('med_preparar', 'How to prepare remedies', r'''
## Infusion (tea) — leaves and flowers
1 tablespoon of dried plant (or 2 of fresh) per cup of just-boiled water. Cover 5–10 minutes and strain. Up to 3 cups a day.
@ manzanilla, hierbabuena, toronjil, cidron

## Decoction — roots, bark and seeds
Simmer 10–20 minutes on low heat with the pot covered. Strain.
@ jengibre, una_gato

## Compress
Soak a clean cloth in a warm infusion and place it on the area (bruises, inflammation, irritated eyes).

## Poultice
Mash the fresh plant into a paste, put it on the skin and cover with a cloth. For stings, scrapes and pimples.
@ llanten, sabila, calendula

## Steam
Boil aromatic leaves, cover your head with a towel and breathe the steam at a safe distance. For congestion.
@ eucalipto, tomillo

## Gargles
Warm infusion with a pinch of salt, several times a day, for the throat.
@ malva, manzanilla

## Homemade salve
Heat 1 cup of oil with a handful of dried plant on very low heat for 1–2 hours, strain, add 2 tablespoons of melted beeswax and let it cool.

## Drying and storing
- Gather in the morning, after the dew has dried.
- Dry in the shade in hanging bundles, in a ventilated place, 1–2 weeks.
- Store in closed, labeled jars (plant and date). They last about a year.
'''),
    Article('med_botiquin', 'Green first-aid kit: which plant for what', r'''
## Diarrhea
Oral rehydration first. Guava leaf tea (a handful of young leaves boiled 10 min).
@ guayaba

## Nausea and motion sickness
@ jengibre, hierbabuena

## Gas, cramps and heavy digestion
@ manzanilla, hierbabuena, cidron, prontoalivio, albahaca

## Cough and sore throat
Thyme or elderflower tea with honey; mallow gargles.
@ tomillo, sauco, malva, eucalipto

## Small wounds and scrapes
Wash first. Then dragon's blood, calendula or plantain.
@ sangre_drago, calendula, llanten

## Minor burns and sunburn
@ sabila

## Bruises and bumps (unbroken skin)
@ arnica

## Nerves, anxiety and insomnia
@ valeriana, toronjil, manzanilla, cidron

## Insect bites
@ llanten, sabila

## Joint pain and inflammation
@ una_gato, jengibre

## Repelling insects
@ limoncillo, achiote, albahaca

! A high fever that won't come down, blood in stools, trouble breathing, confusion or infected wounds need medicine and medical care.
'''),
    Article('med_peligrosas', 'Dangerous traditional remedies', r'''
Some plants are used in folk medicine but can cause serious poisoning.
@ ruda, paico, quina, cola_caballo, matarraton

- Rue: used for "cleansings" and cramps, but it can cause miscarriage, liver damage and skin burns in sunlight. Never during pregnancy.
- Epazote (paico): traditional against parasites; its oil is toxic and has caused deaths, especially in children.
- Cinchona (quina): its bark gave quinine against malaria, but in excess it causes deafness and heart and vision problems. Only if there is no other option and with a prudent dose.
- Horsetail: diuretic; don't use it for weeks on end.
- Matarratón (Gliricidia): traditional in baths for fever; external use only.
- Angel's trumpet, castor bean and dieffenbachia: never as a remedy.
'''),
  ],
  quiz: [
    Question('How is an infusion prepared?',
        ['Boil the plant for 1 hour', 'Just-boiled water over the plant, cover 5–10 min', 'Plant in cold water', 'Burn the plant'], 1,
        'Leaves and flowers go in infusions; roots and bark in decoctions.'),
    Question('For minor burns you use the gel of:',
        ['Rue', 'Aloe vera', 'Epazote', 'Castor bean'], 1,
        'The inner gel of aloe soothes the skin.'),
    Question('Arnica is used...',
        ['As a tea', 'Only externally on bruises without wounds', 'In the eyes', 'On open wounds'], 1,
        'Arnica is toxic if swallowed.'),
    Question('Which traditional plant should a pregnant woman NOT use?',
        ['Rue', 'Chamomile in small amounts', 'Aloe on the skin', 'Plantain poultice'], 0,
        'Rue can cause miscarriage and poisoning.'),
    Question('For diarrhea, besides oral rehydration, you use tea made from leaves of...',
        ['Guava', 'Castor bean', 'Angel\'s trumpet', 'Oleander'], 0,
        'Guava leaves are astringent.'),
    Question('Where should you NOT gather medicinal plants?',
        ['Your garden', 'Next to roads and sprayed crops', 'Clean wild land', 'Your yard'], 1,
        'They absorb smoke, metals and pesticides.'),
  ],
);
