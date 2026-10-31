import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// HYGIENE AND HOMEMADE FIRST-AID KIT
// =====================================================================
const hygieneEn = Category(
  id: 'higiene',
  name: 'Hygiene and homemade kit',
  icon: Icons.sanitizer_outlined,
  summary: 'Soap, disinfectants, sanitizer, saline, sterilizing and vaccines: what you CAN make at home.',
  articles: [
    Article('hig_manos', 'Hygiene that saves lives', r'''
Diarrhea and infections kill more people in disasters than hunger. Almost all of it is prevented with clean water, soap and a latrine far from the water.

## Washing hands
- With soap and water for 20 seconds (singing "Happy Birthday" twice): palms, backs, between fingers, nails.
- Always: after the toilet, before cooking and eating, after touching raw meat, wounds, garbage or animals.
- No soap: wood ash rubbed with water also cleans.
* Make a "tippy tap": a hanging jug with a hole plugged by a stick. It uses very little water.

## Water and food
- Water for drinking and brushing teeth: boiled, chlorinated or filtered.
- Cover food and water: flies and cockroaches carry germs.
- Garbage far away and covered or buried.

## Teeth and body
- A chewed twig toothbrush (guava, lemon) if there is no brush; baking soda or salt instead of toothpaste.
- Cloth sanitary pads: wash them with soap, dry them in the sun and store them clean.
- Dry underwear and socks every day: they prevent fungus.
! One person with diarrhea can infect the whole group: they should use their own cup and wash their hands very well.
'''),
    Article('hig_jabon', 'Homemade soap with ash and fat', r'''
This is grandma's soap: ash lye + fat. Good for hands, clothes and washing around wounds.

## 1. Ash lye
- Use WHITE ash from hardwood (not paper, plastic or store-bought charcoal).
- A bucket with holes in the bottom, a layer of pebbles and straw, and the ash on top.
- Pour hot rainwater little by little and collect the brown liquid that drips out.
- Run it through the ash again until a chicken feather dissolves or an egg floats in it: then it is strong.
! Lye BURNS skin and eyes. Gloves, goggles or cloth over the face, and away from children. If it splashes: lots of water for 15 minutes.

## 2. Cooking the soap
- Melt and strain fat (beef tallow, lard or oil). Rough ratio: 2 parts fat to 1 part lye.
- In an iron or clay pot (not aluminum), mix and simmer on low heat stirring with a stick for 1–3 hours.
- It is ready when it thickens like custard and a drop cools firm.
- A handful of salt at the end helps it harden.

## 3. Curing
- Pour into molds (boxes, coconut shells) and leave 4 weeks in a dry place.
* Test: if it stings or burns the skin, it still has too much lye. Let it cure longer or use it only for laundry.
'''),
    Article('hig_desinfectar', 'Disinfectants: bleach, alcohol and vinegar', r'''
## Bleach (regular household, 5 %)
- Surfaces, toilets, utensils: 1 tablespoon (10 ml) per liter of water.
- Blood, vomit, diarrhea: 1 part bleach to 9 parts water.
- Drinking water: 2 drops per liter (4 if cloudy), wait 30 minutes.
- Mix a fresh batch every day: time and sunlight weaken it.
- Clean off dirt first with soap and water; bleach doesn't work on grime.
! NEVER mix bleach with ammonia, vinegar, acids or alcohol: it makes toxic gases that can kill. Use it only with water and in ventilated places.

## Alcohol
- It works at 60–80 %. Dilute 96 % alcohol: 3 parts alcohol to 1 part boiled water.
- For hands, thermometers, clean scissors and tweezers.
! It catches fire very easily: keep it away from flames and candles.

## Vinegar and lemon
- They remove grease and scale but do NOT disinfect well. Don't use them for wounds or drinking water.

## Sunlight
- Clothes, sheets and bandages washed and dried in direct sun are much cleaner: UV light kills many germs.
'''),
    Article('hig_gel', 'Hand sanitizer (WHO formula)', r'''
The World Health Organization published this recipe for places without access to commercial sanitizer.

## For 1 liter
- 833 ml of 96 % ethyl alcohol.
- 42 ml of 3 % hydrogen peroxide (kills spores that get into the bottle).
- 15 ml of glycerin (protects the skin; can be left out).
- Top up to 1 liter with boiled, cooled water.

## How
- Mix in a clean bottle with a lid and shake.
- Let it stand 72 hours before use.
- Use about 3 ml and rub your hands until dry (20–30 seconds).
* With 99 % isopropyl alcohol: 751 ml instead of 833 ml.
! It doesn't work on hands dirty with soil or grease: wash with soap and water. Flammable. Not for drinking.
'''),
    Article('hig_suero', 'Saline for washing wounds, eyes and nose', r'''
## Homemade saline
- 1 liter of water boiled for 1 minute (3 minutes at high altitude).
- 9 grams of salt: one heaped teaspoon or one and a half level teaspoons. Non-iodized is better, but regular salt works.
- Dissolve while the water is still hot, cover and let cool.
- Use it the same day; throw away what is left after 24 hours.

## Uses
- Washing wounds: squirt it from a bottle or needleless syringe to flush out dirt.
- Eyes with dust or ash: rinse from the nose outward.
- Blocked or dusty nose: a few drops or a gentle rinse.
! It is not for drinking instead of water. For dehydration use oral rehydration solution (water, sugar and salt) from the Recipes section.
* Most wounds only need a very thorough wash with plenty of clean water. That is what prevents infection the most.
'''),
    Article('hig_esterilizar', 'Sterilizing instruments and making bandages', r'''
## Instruments (tweezers, scissors, needles, knife)
- Wash them with soap, water and a brush.
- Boil them covered for 20 minutes, fully under water.
- Better: a pressure cooker for 15–20 minutes once it hisses (it is almost an autoclave).
- Take them out with tweezers that were also boiled and lay them on a clean cloth, covered.
* Passing through a flame works for a needle or tweezer tip in an emergency, but it doesn't sterilize the whole instrument.

## Bandages and gauze
- Use cotton sheets or T-shirts: cut them into 5–10 cm strips.
- Boil them 20 minutes, dry them in the sun and iron them with a very hot iron (or bake them in a covered pot).
- Store them in clean, closed plastic bags or jars.
- Gauze: fold squares of cotton cloth into 4–8 layers.

## Improvised first-aid kit
- Boiled bandages and gauze, tape, scissors, tweezers.
- Splints: cardboard, rolled-up magazines or sticks.
- Tourniquet: wide cloth (4–5 cm) and a stick to twist.
- Thermometer, gloves or clean plastic bags for your hands.
- Pure bee honey: on shallow wounds it helps healing (not for babies under 1 year).
! A wound that is red, hot, swollen, with pus or red streaks spreading, or with fever: infection. It needs antibiotics and a doctor.
'''),
    Article('hig_vacunas', 'Vaccines: why they can\'t be made at home and what to do', r'''
! A vaccine can NOT be made at home. It takes sterile labs, controlled cultures and safety testing. A homemade attempt doesn't protect and can cause serious infections, abscesses or death. Never inject anything homemade.

## What you CAN do NOW
- Get up to date with your vaccines at your health center (in Colombia the national immunization program is free).
- Tetanus (Td): a booster every 10 years. It is the most important one for wounds with soil, nails or rust.
- Ask about: hepatitis A and B, measles, yellow fever (warm areas), influenza, and rabies if you work with animals.
- Keep the whole family's vaccination cards in a plastic bag with your documents.

## If you have stored vaccines
- Almost all are kept between 2 °C and 8 °C. No fridge: a clay pot inside another with wet sand (it cools as it evaporates), in the shade.
- Don't freeze them, don't leave them in the sun. If they change color or have lumps, they are no good.

## Without vaccines, prevention
- Tetanus: wash every wound thoroughly with soap and water and remove the dirt. Deep, dirty wounds need a doctor.
- Rabies: if an animal bites or scratches, wash 15 minutes with soap and water and get care; the vaccine after the bite saves lives.
- Measles, flu and covid: isolate the sick person, ventilate and wash hands.
- Hepatitis A, cholera and typhoid: boiled or chlorinated water and well-cooked food.
'''),
  ],
  quiz: [
    Question('What must NEVER be mixed with bleach?', ['Water', 'Ammonia or vinegar', 'Rainwater', 'Nothing, anything goes'], 1,
        'It makes toxic gases. Bleach is only mixed with water.'),
    Question('How much salt goes into 1 liter of saline for wounds?', ['A pinch', 'About 9 grams', 'Half a bag', 'None'], 1,
        'About 9 g (one heaped teaspoon) per liter of boiled water.'),
    Question('How do you sterilize tweezers?', ['Blowing on them', 'With vinegar', 'Boiling them 20 minutes', 'In the sun 5 minutes'], 2,
        'Wash and boil 20 minutes (or use a pressure cooker).'),
    Question('Can a vaccine be made at home?', ['Yes, with serum', 'Yes, with garlic', 'No: it is dangerous and doesn\'t protect', 'Only tetanus'], 2,
        'It takes sterile labs. What works: get vaccinated beforehand and wash wounds well.'),
  ],
);
