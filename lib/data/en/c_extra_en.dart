import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// ANIMALS
// =====================================================================
const animalsEn = Category(
  id: 'animales',
  name: 'Animals',
  icon: Icons.pets_outlined,
  summary: 'Dangerous animals, the diseases they carry and useful wildlife.',
  articles: [
    Article('ani_serpientes', 'Venomous snakes of Colombia', r'''
Colombia has more than 50 species of venomous snakes. Most bites happen in the countryside, at night, when stepping on them or reaching without looking.
@ mapana, cascabel, coral, verrugosa

## Clues (not foolproof)
- Vipers (fer-de-lance, rattlesnake, bushmaster): triangular head wider than the neck, vertical pupil, a pit between the eye and the nostril.
- Coral snakes: small, bright colored rings, round head. Very venomous even if they look harmless.
! Treat EVERY unknown snake as venomous. Don't try to kill it: that is how most bites happen.

## Prevention
- High boots, long pants and a flashlight at night.
- Look where you step and where you put your hands (firewood, holes, rocks).
- Keep grass short and no trash around the house: it attracts rats, and rats attract snakes.
- Tap the ground with a stick when walking in tall grass.
'''),
    Article('ani_aracnidos', 'Spiders, scorpions and dangerous insects', r'''
@ viuda_negra, alacran, arana_bananera, lonomia, hormiga_conga, abeja_africanizada

## General rules
- Shake out clothes, shoes, blankets and towels before using them.
- Wear gloves when moving firewood, rocks, roof tiles or rubble.
- Don't touch hairy or spiny caterpillars.
- Keep the bed away from the wall.

## If stung or bitten
- Wash with soap and water.
- Cold on the area for pain.
- Watch for 24 hours: trouble breathing, heavy sweating, vomiting or bleeding are warning signs.
'''),
    Article('ani_enfermedades', 'Diseases carried by animals', r'''
After a disaster, diseases carried by animals kill more than the animals themselves.
@ aedes, pito, vampiro

## Mosquitoes (dengue, malaria, zika)
- Eliminate standing water: cover tanks, turn containers over, change water in troughs every 3 days.
- Mosquito net at night; long clothing at dawn and dusk.

## Rats (leptospirosis)
- Spread through rat urine in flood water and puddles.
- Wear boots in water; keep food in closed containers; trap or scare off rats.
! High fever, strong calf pain and red eyes after walking in flood water: it may be leptospirosis.

## Rabies
- Dogs, cats, bats and foxes can transmit it.
- Every bite: wash for 15 minutes under running water with soap. It is the most important step.
! An animal acting strangely (aggressive for no reason, drooling, can't swallow, very tame for a wild animal) may have rabies. Stay away.

## Parasites
- Cook all meat and fish thoroughly.
- Wear shoes: many parasites enter through bare feet.
'''),
    Article('ani_grandes', 'Large animals and feral dogs', r'''
@ jaguar, caiman, raya

## Stray dogs (the most common danger)
- In a collapse, abandoned dogs form packs.
- Don't run: it triggers their chase instinct.
- Turn sideways, don't stare them in the eyes, and back away slowly.
- Keep a stick or something between you and them. Climb somewhere high if they attack.
- Protect your neck and face with an arm wrapped in clothing.

## Livestock
- Bulls and cows with calves can charge. Don't cross pastures with them.

## In rivers and swamps
- Shuffle your feet to scare off stingrays.
- Avoid murky, still water at dusk (caimans).
'''),
    Article('ani_caza', 'Sustainable animal protein', r'''
@ gallina, cuy, conejo, tilapia, chiguiro, iguana

- Raising animals is safer and more productive than hunting: chickens, guinea pigs, rabbits and pond fish.
- Small animals breed fast and eat scraps and grass.
- Fishing with set lines and traps works on its own while you do other tasks.

## Cleaning a small animal
1. Bleed it by cutting the neck, hanging head down.
2. Remove skin or feathers (hot water helps with plucking).
3. Open the belly without piercing the intestines and remove the organs.
4. Keep the heart and liver if healthy (red, firm, no spots).
5. Wash with clean water and cook well.

! A liver with white spots or cysts means disease: throw away the whole animal.
* Guts and blood make fishing bait, or fertilizer when buried.
'''),
  ],
  quiz: [
    Question('What do you do with an unknown snake?',
        ['Kill it', 'Treat it as venomous and move away', 'Catch it', 'Follow it'], 1,
        'Many bites happen when trying to kill or catch the snake.'),
    Question('Coral snakes in Colombia...',
        ['Are harmless', 'Can be told apart by the color rhyme', 'Are very venomous', 'Only live in the sea'], 2,
        'Their venom can paralyze breathing; color rhymes don\'t work here.'),
    Question('Leptospirosis is mainly transmitted by...',
        ['Bee stings', 'Rat urine in water', 'Eating fruit', 'The sun'], 1,
        'Flood water contaminated with rat urine.'),
    Question('After a dog or bat bite, the first thing is:',
        ['Wash 15 minutes with soap and water', 'Apply ice', 'Burn the wound', 'Nothing'], 0,
        'Washing under running water greatly lowers the risk of rabies.'),
    Question('If a swarm of Africanized bees attacks you:',
        ['Jump into water', 'Run to a closed place covering your face', 'Stay still', 'Swat them'], 1,
        'They wait above the water; running to a closed shelter is best.'),
    Question('When crossing a river with stingrays you should...',
        ['Jump', 'Shuffle your feet', 'Go barefoot', 'Run'], 1,
        'Shuffling scares them away instead of stepping on them.'),
  ],
);

// =====================================================================
// COMMUNICATION
// =====================================================================
const commsEn = Category(
  id: 'comunicacion',
  name: 'Communication and radio',
  icon: Icons.settings_input_antenna,
  summary: 'Radios, phonetic alphabet, messages and group signals.',
  articles: [
    Article('com_radio', 'Emergency radios', r'''
## Receiving information
- An AM/FM radio powered by batteries, solar or a crank is the most important thing: local stations report shelters, water and dangers.
- AM reaches farther at night.

## Talking to others
- Walkie-talkies (PMR/FRS radios): easy, 1–5 km range in open terrain, less in cities or mountains.
- Amateur (ham) radios (VHF/UHF and HF): range of tens to thousands of km; in emergencies hams form help networks.

## Increasing range
- Get to a high, open place.
- Vertical antenna, away from metal.
- Speak briefly, clearly, close to the microphone without shouting.

## Protocol
- Listen before talking. Say who you are calling and who you are: "Base, this is Patrol One, over".
- "Over" = I'm done, your turn. "Out" = end of communication.
- Fixed contact times (for example 5 minutes every hour on the hour) save battery.
'''),
    Article('com_fonetico', 'Phonetic alphabet and clear messages', r'''
To spell names or coordinates without errors:
- A Alfa · B Bravo · C Charlie · D Delta · E Echo · F Foxtrot
- G Golf · H Hotel · I India · J Juliet · K Kilo · L Lima
- M Mike · N November · O Oscar · P Papa · Q Quebec · R Romeo
- S Sierra · T Tango · U Uniform · V Victor · W Whiskey
- X X-ray · Y Yankee · Z Zulu

## Emergency message (short format)
1. Who you are and how many people.
2. Where you are (coordinates from the Map tab, or a known place).
3. What is happening (injured, water, danger).
4. What you need.
5. What you will do and when you will call again.

* International radio distress call: "MAYDAY, MAYDAY, MAYDAY" (danger to life). "PAN-PAN" for urgency without immediate danger.
'''),
    Article('com_grupo', 'Coordinating the group without signal', r'''
- Agree on a main meeting point and an alternate one before anything happens.
- Written family plan: phone numbers on paper, a contact in another city, meeting points.
- Leave visible notes with date and time: "We're OK, went to X, 29/10 15:00".
- Door marks after searching a house (rescue system): an X with the date on top, team on the left, hazards on the right and number of victims at the bottom.
- Whistle: 1 = where are you? / attention, 2 = come here, 3 = help.
- Arm signals at a distance: both arms up in a "Y" = yes / need help, one arm up and one down = no.
'''),
  ],
  quiz: [
    Question('The most important device for receiving information in a disaster is:',
        ['TV', 'Battery or crank AM/FM radio', 'Game console', 'Printer'], 1,
        'It works without power grid or internet.'),
    Question('On the radio, "over" means...',
        ['I\'m done, your turn', 'Change channel', 'End of communication', 'Help'], 0,
        '"Out" ends the communication.'),
    Question('Three whistle blasts mean...',
        ['All good', 'Come here', 'Help', 'Food is ready'], 2,
        'Three is the universal distress signal.'),
    Question('"MAYDAY" is used when...',
        ['There is danger to life', 'Asking the time', 'The weather is nice', 'It\'s night'], 0,
        'Serious, imminent danger.'),
  ],
);
