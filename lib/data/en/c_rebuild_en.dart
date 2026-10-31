import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// REBUILDING SOCIETY
// =====================================================================
const rebuildEn = Category(
  id: 'reconstruir',
  name: 'Rebuilding society',
  icon: Icons.foundation_outlined,
  summary: 'Farming, hygiene, energy, building, community and knowledge.',
  articles: [
    Article('rec_prioridades', 'Where to start', r'''
Surviving the first week is one thing; living the next years is another. A sustainable community needs, in this order:

1. Safe water and sanitation (latrines far from water).
2. Renewable food: gardens, seeds, animals.
3. Lasting shelter.
4. Health: hygiene, births, wounds, basic medical knowledge.
5. Organization: rules, sharing tasks, resolving conflicts.
6. Tools and trades: carpentry, blacksmithing, textiles, pottery.
7. Knowledge: teaching children to read, write, count and the trades.
8. Energy and communication.

* Books and knowledge are as valuable as food. Rescue libraries, technical manuals and school textbooks.
'''),
    Article('rec_huerta', 'Garden: growing your food', r'''
## Easy, productive crops in Colombia
- Hot climate: cassava, plantain, corn, beans, squash, sweet potato, papaya, yam.
- Cold climate: potato, fava beans, peas, corn, onion, garlic, cabbage, carrot, quinoa.
- Fast (harvest in 30–60 days): radish, lettuce, spinach, cilantro, chard.
- Perennials that feed for years: plantain, fruit trees, avocado, pigeon pea, moringa.
@ yuca, platano, ahuyama, moringa, amaranto

## Basic steps
1. A spot with at least 6 hours of sun and close to water.
2. Loosen the soil 20–30 cm and mix in compost or well-rotted manure.
3. Sow seeds at a depth of 2–3 times their size.
4. Water early in the morning or at dusk.
5. Cover the soil with dry leaves or straw (mulch): it keeps moisture and stops weeds.

## The "milpa" or three sisters
Corn + beans + squash together: the corn supports the beans, the beans add nitrogen to the soil and the squash covers the ground. An Indigenous American system proven over thousands of years.

## Crop rotation
Don't plant the same thing in the same place every season. Rotate: leaves → fruits → roots → legumes (beans, peas), which restore the soil.
'''),
    Article('rec_semillas', 'Saving seeds', r'''
Without seeds there is no future. Saving them is the most important long-term task.

- Use heirloom or traditional varieties (not F1 hybrids): their seeds give plants like the mother.
- Choose the best plants (healthy, productive) for seed, not the leftovers.
- Let the fruit ripen fully on the plant (beans dry in the pod, squash fully ripe).
- Dry the seeds in the shade for several days.
- Store in closed glass jars, in a cool, dry, dark place. A little ash or dry rice absorbs moisture.
- Label: species, variety, date.
- Germination test: 10 seeds on damp paper; if 7 sprout, you have 70 %.

* Cassava, plantain and potato are propagated by cuttings, suckers and tubers, not seed.
'''),
    Article('rec_compost', 'Compost and fertile soil', r'''
- Mix "green" materials (kitchen scraps, fresh grass, manure) and "brown" ones (dry leaves, straw, cardboard) at roughly 1:2.
- It should be moist like a wrung-out sponge.
- Turn it every 1–2 weeks to air it.
- In 2–3 months you get dark soil that smells like the forest.
- Don't add meat, fat, or dog or human feces to garden compost.

* Diluted human urine (1 part to 8–10 of water) is a nitrogen-rich fertilizer; apply it to the soil, not to leaves eaten raw.
'''),
    Article('rec_animales', 'Farm animals', r'''
@ gallina, cuy, conejo, tilapia, abeja_miel
- Chickens: the easiest. Daily eggs, meat, they eat scraps and insects. They need a closed coop at night.
- Rabbits and guinea pigs: breed fast, eat grass and scraps, lean meat.
- Goats: milk, meat, adapt to poor land.
- Bees: honey (sweetener, medicine, preservative), wax and crop pollination.
- Fish in ponds (tilapia, cachama) in hot climates.

! Wash your hands well after handling animals and cook meat and eggs thoroughly.
'''),
    Article('rec_higiene', 'Hygiene and sanitation', r'''
Sanitation has saved more lives in history than almost any medicine.

## Pit latrine
- At least 30 m from wells and water sources, and downhill from them.
- Pit 1.5–2 m deep.
- After each use: a handful of ash, lime or soil. It reduces smell and flies.
- Cover it. When it is 50 cm from the top, fill it with soil and dig another.

## Handwashing
With soap, always: after the toilet, before cooking and eating, after caring for the sick. A washing station with a hanging jug and a stick ("tippy tap") saves water.

## Homemade soap
Soap is made from fat + alkali (lye). Traditional lye is made by filtering water through hardwood ash.
! Lye burns skin and eyes: use gloves, goggles and containers that are not aluminum.

## Waste
Separate: organic to compost; the rest buried or burned away from homes and water.
'''),
    Article('rec_energia', 'Energy and light', r'''
- Solar panels: rescue them from roofs, road signs or calculators. A panel + charge controller + car battery gives light and charges phones.
- Lead-acid car batteries can be recharged with panels; don't discharge them below 50 %.
- Bicycle dynamos generate electricity by pedaling.
- Water: a wheel in a stream with a drop can drive a mill or a small generator.
- Light: oil lamps (vegetable oil + cotton wick), beeswax or tallow candles.
- Heat: efficient wood stoves ("rocket", clay "Lorena" stove).

* Save your phone: airplane mode, low brightness, dark theme (this app already uses it), and charge it with the sun during the day.
'''),
    Article('rec_construccion', 'Traditional building', r'''
Techniques with local materials used in Colombia for centuries:

@ guadua
- Bahareque (wattle and daub): a guadua or wood frame filled with mud mixed with straw. It resists earthquakes well because it is flexible.
- Adobe: blocks of mud + straw dried in the sun. Thick, cool by day and warm at night. Weak in earthquakes unless reinforced.
- Rammed earth: damp earth compacted in wooden forms.
- Guadua bamboo: "vegetable steel". Strong, flexible and fast-growing. Cut it mature (3–5 years) and cure it (soaking in water or smoke) so insects don't attack it.

## Principles
- Stone foundations that raise the wall off the ground: water destroys mud.
- Long roof eaves: they protect the walls from rain.
- Light roofs in earthquake zones.
'''),
    Article('rec_comunidad', 'Organizing a community', r'''
## First agreements
- Census: names, skills (doctors, farmers, mechanics, teachers, cooks), health and needs.
- Common inventory of key resources (water, food, medicines, tools).
- Simple, clear rules, written down and accepted by everyone.
- Regular assembly for important decisions.

## Sharing the work
Rotate heavy tasks (water, guard duty, latrines). Everyone contributes according to their ability.

## Resolving conflicts
- Listen to both sides separately and then together.
- A neutral mediator.
- Proportional sanctions known in advance.
- Stealing common food or water and violence are the most serious offenses.

## Barter and trade
Valuable goods after a collapse: salt, drinking water, medicines, seeds, tools, soap, lighters, alcohol (disinfectant), knowledge (healing, repairing, teaching).

* Communities that cooperate survive better than isolated individuals. It is the most repeated lesson of history.
'''),
    Article('rec_conocimiento', 'Basic knowledge to restart', r'''
## The scientific method
Observe → question → hypothesis → experiment (changing only one thing at a time) → record → conclude. This is how everything improves: crops, medicine, tools.

## Simple machines
Lever, pulley, inclined plane, wheel and axle, wedge and screw. With them one person moves huge loads.
- Lever: the farther from the fulcrum you push, the less force you need.
- Double pulley: halves the force.

## Measuring
- An average step ≈ 0.75 m; count double steps to measure distances.
- One liter = 1 kg of water.
- Calendar: record moons and rains to plan sowing.

## Useful chemistry
- Ash + water = lye (alkali) → soap.
- Lime (burned limestone) → mortar, disinfecting latrines, improving acid soils.
- Charcoal: wood burned without oxygen (buried or in a closed kiln). Powerful fuel and filter.
- Alcohol by fermenting fruit or cane + distillation: disinfectant and fuel.

## Education
Teach every child to read, write and do the four operations. Write down what you know: knowledge that isn't written is lost in one generation.
'''),
    Article('rec_parto', 'Emergency childbirth', r'''
Most births go well on their own. Your job is to help, keep things clean and not rush.

- Wash your hands very well, have clean cloths, boiled water, something to tie the cord (boiled laces) and a boiled blade or scissors.
- Let the mother take whatever position she wants.
- Don't pull the baby: support the head as it comes out.
- If the cord is around the neck, gently slip it over the head.
- Dry the baby, put it skin to skin on the mother's chest and cover them both.
- If it doesn't cry or breathe: rub its back, clear the mouth and nose.
- Wait until the cord stops pulsing. Tie it in two places (10 and 15 cm from the baby) and cut between them.
- The placenta comes out on its own in about 30 minutes. Don't pull the cord. Breastfeeding helps the uterus contract.

! Heavy bleeding after birth: firmly massage the lower belly (uterus) and put the baby to the breast.
'''),
  ],
  quiz: [
    Question('The "milpa" or three sisters combines:',
        ['Potato, cassava and rice', 'Corn, beans and squash', 'Coffee, cocoa and cane', 'Wheat, barley and oats'], 1,
        'An Indigenous system where each plant helps the others.'),
    Question('Minimum distance from water for a latrine?',
        ['3 m', '30 m', '1 m', 'It doesn\'t matter'], 1,
        'At least 30 m and downhill from the source.'),
    Question('Which seeds should you save?',
        ['F1 hybrids', 'Heirloom or traditional', 'Any', 'From sick plants'], 1,
        'Heirlooms reproduce the mother plant; hybrids don\'t.'),
    Question('Lye for making soap comes from...',
        ['Sand', 'Wood ash and water', 'Salt', 'Sugar'], 1,
        'Water filtered through ash is alkaline.'),
    Question('Bahareque uses...',
        ['Cement and iron', 'Guadua or wood with mud and straw', 'Glass', 'Plastic'], 1,
        'A flexible traditional technique that resists earthquakes.'),
    Question('In an emergency birth, do you pull the cord to get the placenta out?',
        ['Yes, hard', 'No, it comes out on its own', 'Yes, with tweezers', 'Only if the baby cries'], 1,
        'Pulling can cause severe bleeding.'),
  ],
);

// =====================================================================
// MIND AND LEADERSHIP
// =====================================================================
const mindEn = Category(
  id: 'mente',
  name: 'Mind and leadership',
  icon: Icons.psychology_outlined,
  summary: 'Controlling fear, keeping morale and leading.',
  articles: [
    Article('men_miedo', 'Controlling panic', r'''
Panic kills more than many wounds: it leads to bad decisions.

## Box breathing (used by the military)
Inhale 4 seconds → hold 4 → exhale 4 → hold 4. Repeat 4 times.

## The 5-4-3-2-1 technique
Name 5 things you see, 4 you touch, 3 you hear, 2 you smell, 1 you taste. It brings you back to the present.

## Mindset
- Break problems into small tasks: "right now I only need water".
- Celebrate each achievement.
- Accept what you can't change; focus on what you can.
'''),
    Article('men_moral', 'Group morale', r'''
- Daily routines: set times to eat, work and rest. They give a sense of control.
- Every person needs to feel useful.
- Moments of rest, games, music and stories.
- Talk about grief; don't hide losses.
- Take special care of children and the elderly: they need simple explanations and presence.
- Sleep: lack of sleep destroys judgment and mood.
'''),
    Article('men_lider', 'Leading in a crisis', r'''
- Decide fast with the information you have; a reasonable decision in time beats a perfect one too late.
- Communicate clearly: what is happening, what we will do, what I need from each person.
- Lead by example: the leader eats last and works like everyone else.
- Listen to the group's experts.
- Delegate: nobody can do everything.
- Admit mistakes and correct them.
'''),
  ],
  quiz: [
    Question('Box breathing is:',
        ['4-4-4-4 seconds', 'Fast and short', 'Holding 1 minute', 'Only exhaling'], 0,
        'Inhale, hold, exhale and hold 4 seconds each.'),
    Question('A good leader in a crisis...',
        ['Eats first', 'Leads by example and delegates', 'Decides alone without listening', 'Hides information'], 1,
        'Example and delegation keep trust.'),
  ],
);
