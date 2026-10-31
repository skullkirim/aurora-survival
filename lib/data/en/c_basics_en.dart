import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// FIRST AID
// =====================================================================
const firstAidEn = Category(
  id: 'auxilios',
  name: 'First aid',
  icon: Icons.medical_services_outlined,
  summary: 'Saving lives without a hospital: CPR, bleeding, burns, fractures.',
  articles: [
    Article('aux_prioridades', 'Assessing an emergency (PAS and XABCDE)', r'''
## The PAS rule
- Protect: make sure the area is safe for you and the victim. An injured rescuer is just another victim.
- Alert: if there is any way to call for help (radio, other people), do it now.
- Assist: only after the above.

## Check order XABCDE
- X – eXsanguinating hemorrhage: massive bleeding kills in minutes. Control it first.
- A – Airway: can they talk? Is anything in the mouth? Tilt the head back and lift the chin.
- B – Breathing: look, listen and feel for no more than 10 seconds.
- C – Circulation: look for other bleeding, cold pale skin, weak pulse (shock).
- D – Disability: do they respond? Equal pupils? Can they move arms and legs?
- E – Exposure: check the whole body, then cover them to prevent hypothermia.

* If the person talks normally, they have an airway and are breathing. Move on to look for bleeding and fractures.
! Do not move someone with a possible spine injury (fall from height, hard blow) unless their life is in danger where they are.
'''),
    Article('aux_rcp', 'CPR: cardiopulmonary resuscitation', r'''
## When to do it
The person does not respond and is NOT breathing or only gasps irregularly.

## Adult
1. Lay them on their back on a hard surface.
2. Heel of one hand on the center of the chest (lower half of the breastbone), other hand on top, arms straight.
3. Push 5 to 6 cm deep, at 100 to 120 per minute (the beat of "Stayin' Alive").
4. Let the chest come all the way back up between compressions.
5. If you know how and can: 30 compressions and 2 breaths (head tilted, nose pinched, 1 second each, chest should rise).
6. If you don't know how or don't want to give breaths: continuous compressions only. Still very useful.

## Children and babies
- Child: one or two hands, about 5 cm deep.
- Baby: two fingers on the center of the chest, about 4 cm.
- In children, if you are alone, start with 5 rescue breaths.

* Switch every 2 minutes: compression quality drops fast with fatigue.
! In a world without hospitals, CPR rarely revives someone without a defibrillator. Still, in drowning, electrocution or children it can work. Keep going until they breathe, help arrives or you are exhausted.
'''),
    Article('aux_hemorragia', 'Bleeding and tourniquets', r'''
## Direct pressure (always first)
1. Use gloves or a plastic bag if you have them.
2. Press hard with clean cloth directly on the wound, at least 10 minutes without lifting to look.
3. If the cloth soaks through, add more on top; do not remove the first one.
4. Bandage tightly to keep the pressure.

## Packing a deep wound
For deep wounds in the armpit, groin or neck: push cloth or gauze into the wound until it is full and press hard on top.

## Tourniquet (arms and legs only)
Use it if the blood spurts or won't stop with pressure.
- Wide strap, 4–5 cm (belt, cloth). Never wire or thin cord.
- Place it 5–8 cm above the wound, never over a joint.
- Twist a stick (windlass) until the bleeding STOPS. Secure the stick.
- Write the time on the person's forehead or on the tourniquet.

! A tourniquet hurts a lot; that is normal. Loosening it without medical care can cause new, deadly bleeding. It is tolerated well for up to 2 hours; beyond that the limb may be lost.
* Shock (pale, cold, sweaty skin, fast pulse, confusion): lay the person down, keep them warm and raise their legs if there are no fractures.
'''),
    Article('aux_heridas', 'Wounds and infections', r'''
Without antibiotics, an infected wound can kill. Cleaning is your best medicine.

## Cleaning
- Rinse with plenty of drinking water (boiled and cooled) as a stream. Lots of volume is better than a little "strong" water.
- Remove dirt and visible debris with clean (boiled) tweezers.
- Soap around the wound, not inside.
- Do not use alcohol or hydrogen peroxide inside deep wounds: they damage tissue.

## Close it or not
- Dirty wounds, bites or wounds older than 6–8 hours: do NOT close them. Leave them open, covered, and change the dressing daily.
- Clean, recent cuts: you can bring the edges together with adhesive strips.

## Signs of infection
- Spreading redness, heat, swelling, pus, bad smell, fever, red lines running up the limb.

* Pure honey has antibacterial effects and has been used on wounds for centuries: thin layer, cover, change daily.
! Red lines, high fever or confusion = spreading infection. Find antibiotics or a doctor at all costs.
'''),
    Article('aux_quemaduras', 'Burns', r'''
1. Move away from the heat source. If clothing is on fire: stop, drop and roll.
2. Cool with fresh (not icy) running water for 20 minutes.
3. Remove rings and watches before swelling starts.
4. Cover loosely with clean plastic wrap or a clean damp cloth.

## Don't
- Don't use ice, toothpaste, butter, oil or coffee.
- Don't pop blisters.
- Don't peel off clothing stuck to the skin.

! Serious: burns larger than 10 of the victim's palms in adults, on the face, hands, genitals, joints, or white/black skin without pain. Give fluids with salts (oral rehydration) and watch for shock.
'''),
    Article('aux_fracturas', 'Fractures, sprains and splints', r'''
## Recognizing a fracture
Intense pain at one point, deformity, swelling, can't bear weight or move, crunching.

## Immobilize (splint)
- Immobilize the joint above and the joint below the broken bone.
- Pad with cloth between the splint and the skin.
- Materials: straight sticks, rolled magazines, cardboard, or tie the injured leg to the healthy one.
- Check afterwards: fingers/toes pink, warm and with feeling. If they turn blue or cold, loosen.

## Open fracture (bone visible)
Control bleeding without pressing on the bone, cover with clean cloth and DO NOT try to push it back in.

## Sprain: RICE
- Rest, Ice or cold (20 min every 2–3 h), Compression with a bandage, Elevation.

! Only try to straighten a limb if there is no pulse below the fracture and no help is possible; pull gently and steadily in a straight line.
'''),
    Article('aux_temperatura', 'Hypothermia and heat stroke', r'''
## Hypothermia
Shivering, clumsiness, confusion, slurred speech. If they stop shivering while still cold, it's serious.
- Get them out of wind and moisture. Remove wet clothing.
- Insulate from the ground (branches, cardboard, backpack).
- Cover head, neck and torso. Share body heat in a sleeping bag.
- If conscious: warm, sweet drinks.
! Don't rub the limbs or warm them suddenly with direct fire.

## Heat stroke
Very hot skin, confusion, headache, vomiting, may stop sweating.
- Shade immediately, remove clothing, wet the whole body and fan.
- Cold cloths on neck, armpits and groin.
- If conscious, sips of water with a little salt.
! Heat stroke is deadly. Cooling fast is the priority.
'''),
    Article('aux_suero', 'Dehydration, diarrhea and oral rehydration', r'''
Diarrhea from contaminated water is one of the biggest causes of death after a disaster.

## Homemade oral rehydration solution (WHO)
- 1 liter of drinking water
- 6 level teaspoons of sugar
- ½ level teaspoon of salt
Mix well. Test: it should not taste saltier than tears.

## How to give it
- Small, frequent sips, even if they vomit (wait 10 min and continue).
- Adult: 1 to 2 glasses after each bowel movement.
- Keep eating soft foods (rice, cooked plantain, broth).

## Warning signs
Dry mouth, no urine for 8+ hours, sunken eyes, dizziness when standing, lethargy. In babies: sunken soft spot.

* Wash your hands with soap before eating and after using the toilet: it stops most infections.
'''),
    Article('aux_mordeduras', 'Snakebites and stings', r'''
## Snake
@ mapana, cascabel, coral, verrugosa
1. Move away from the snake. Don't try to catch it.
2. Keep the person calm and still: movement speeds up the venom.
3. Remove rings, watches and tight clothing before swelling.
4. Immobilize the limb at heart level or slightly below.
5. Mark the edge of the swelling with the time every 30 minutes.
6. Getting to a facility with antivenom is the only cure.

## DON'T
- Don't cut, don't suck, no tourniquet, no ice, no alcohol, no folk remedies.

## Stings (bees, wasps, scorpions)
- Remove the stinger by scraping with a card, not squeezing.
- Cold on the area.
! Trouble breathing, swelling of face/lips or fainting after a sting = anaphylaxis. If there is an epinephrine auto-injector, use it in the thigh.
'''),
    Article('aux_atragantamiento', 'Choking', r'''
## If they can cough
Encourage them to cough hard. Don't hit them yet.

## If they can't talk, cough or breathe (adult and child > 1 year)
1. Stand behind them and lean them forward.
2. 5 firm blows between the shoulder blades with the heel of your hand.
3. 5 abdominal thrusts (Heimlich): fist between the navel and the breastbone, other hand on top, pull in and up.
4. Alternate 5 and 5 until it comes out or they lose consciousness (then: CPR).

## Baby
Face down on your forearm, 5 back blows; then face up, 5 chest thrusts with 2 fingers.
'''),
    Article('aux_botiquin', 'Survival first-aid kit', r'''
## The basics
- Gauze, elastic bandages, tape, adhesive bandages.
- Gloves, scissors, tweezers, thermometer.
- Tourniquet or 4 cm wide strap.
- Oral rehydration packets, soap, antiseptic (povidone-iodine or chlorhexidine).
- Painkillers (paracetamol, ibuprofen), antihistamines, anti-diarrheal.
- Emergency blanket, flashlight, notebook and pencil.
- Your personal medications for several weeks.

* Check expiry dates every 6 months. Log the kit in this app's inventory.
! Never take other people's medicines without knowing what they're for and their dose.
'''),
  ],
  quiz: [
    Question('What is treated first in a victim with spurting leg bleeding?',
        ['Breathing', 'The bleeding', 'Fractures', 'Temperature'], 1,
        'In XABCDE the X (massive hemorrhage) comes first: it can kill in minutes.'),
    Question('Correct CPR compression rate:',
        ['60 per minute', '80 per minute', '100 to 120 per minute', '150 per minute'], 2,
        '100 to 120 per minute, about 5–6 cm deep in adults.'),
    Question('A burn is cooled with...',
        ['Ice directly', 'Toothpaste', 'Fresh running water for 20 min', 'Oil'], 2,
        'Fresh water for 20 minutes. Ice, toothpaste and oils damage the skin more.'),
    Question('Homemade oral rehydration per liter of water:',
        ['6 tsp sugar and ½ tsp salt', '1 tsp sugar and 3 of salt', 'Only salt', 'Only sugar'], 0,
        'WHO formula: 6 level teaspoons of sugar and half a teaspoon of salt.'),
    Question('After a snakebite you should...',
        ['Cut and suck', 'Apply a tourniquet', 'Immobilize and keep calm', 'Apply ice'], 2,
        'Immobilize, calm and transport. Cutting, sucking or a tourniquet make it worse.'),
    Question('Where does a tourniquet go?',
        ['On the knee', '5–8 cm above the wound', 'Right on the wound', 'On the neck'], 1,
        '5 to 8 cm above the wound, never over a joint.'),
  ],
);

// =====================================================================
// WATER
// =====================================================================
const waterEn = Category(
  id: 'agua',
  name: 'Water',
  icon: Icons.water_drop_outlined,
  summary: 'Finding, purifying and storing safe water.',
  articles: [
    Article('agua_regla3', 'The rule of 3', r'''
An average person can survive approximately:
- 3 minutes without air
- 3 hours without shelter in extreme weather
- 3 days without water
- 3 weeks without food

That is why the order of priorities is almost always: safety → shelter/temperature → water → fire → food.

## How much water you need
- Minimum for drinking: 2–3 liters per person per day; more in heat or with effort.
- For drinking + cooking + basic hygiene: about 4 liters per person per day.
* Use the ration calculator in Tools.
'''),
    Article('agua_encontrar', 'How to find water', r'''
## Sources, best to worst
1. Rain collected directly in clean containers (the safest).
2. Springs flowing out of rock.
3. Flowing rivers and streams (take water upstream of any settlement).
4. Lakes and ponds.
5. Puddles and stagnant water (last resort, always purify).

## Clues in the terrain
- Green, thick vegetation in dry areas.
- Insects (bees, flies, mosquitoes) and animal tracks converging.
- Birds flying low and straight at dawn or dusk.
- Valley bottoms and the outside of bends in dry riverbeds: dig there.

## In the city
- The toilet tank (the box at the back, NOT the bowl) if it has no chemicals.
- Water heater, building pipes (open the lowest tap).
- Swimming pools: only for washing, unless you distill it.

* Morning dew can be collected by dragging a cloth through grass and wringing it out.
'''),
    Article('agua_purificar', 'Purifying water', r'''
## 1. Filter first
Pass cloudy water through folded cloth or let it settle. Particles protect microbes.

## 2. Boiling (the safest method)
- Rolling boil for 1 minute.
- Above 2,000 m altitude: boil for 3 minutes.
- Let it cool covered.

## 3. Chlorine (bleach)
Use unscented bleach, 5–6 % sodium hypochlorite:
- 2 drops per liter of clear water.
- 4 drops per liter if cloudy or cold.
- Mix and wait 30 minutes. It should smell slightly of chlorine. If not, repeat and wait 15 more minutes.

## 4. Solar disinfection (SODIS)
- Clear PET bottle of up to 2 liters, clear water.
- In direct sun for 6 hours (2 days if cloudy).
- Works well in the tropics.

## 5. Commercial tablets or filters
Follow the manufacturer's instructions.

! No method removes chemicals, fuel or heavy metals except distillation. Avoid water near mines, factories or smelling of fuel.
'''),
    Article('agua_filtro', 'Homemade layered filter', r'''
A layered filter clears water but does NOT make it drinkable. Afterwards you must boil or chlorinate.

## Building it (upside-down cut bottle)
From bottom to top:
1. Cloth or cotton in the neck.
2. Crushed charcoal (from your campfire, not briquettes) — holds back smells and some chemicals.
3. Fine sand.
4. Coarse sand.
5. Gravel.
6. Small stones.

Throw away the first liters, which will come out black from the charcoal.

## Solar still
- Dig a hole and put a container in the middle.
- Put green leaves or dirty water around it.
- Cover with plastic, seal the edges with dirt and put a stone in the center over the container.
- The evaporated water condenses and drips clean. It produces little (about half a liter a day), but works with salty or contaminated water.
'''),
    Article('agua_almacenar', 'Storing water', r'''
- Food-grade containers, clean and with lids. Never chemical containers.
- Cool, dark place: light encourages algae.
- Treated tap water lasts about 6 months; rotate it.
- Label the date.
- Always use a clean ladle: don't put in hands or used cups.

* To disinfect the container: 1 teaspoon of bleach per liter of water, shake, wait 30 seconds and rinse.
'''),
  ],
  quiz: [
    Question('How long should water be boiled above 2,000 m?',
        ['10 seconds', '1 minute', '3 minutes', '30 minutes'], 2,
        'At sea level 1 minute is enough; at altitude water boils at a lower temperature, so boil 3.'),
    Question('Drops of 5–6 % bleach per liter of clear water:',
        ['2 drops', '10 drops', 'Half a cup', '1 tablespoon'], 0,
        '2 drops per liter (4 if cloudy or cold) and wait 30 minutes.'),
    Question('Does a sand and charcoal filter make water drinkable?',
        ['Yes, always', 'No, you must boil or chlorinate afterwards', 'Only river water', 'Only at night'], 1,
        'It clears the water but doesn\'t remove all microbes.'),
    Question('The safest water source in general is:',
        ['A puddle', 'Rain collected in a clean container', 'A pond', 'A pool tank'], 1,
        'Rain collected directly is the cleanest.'),
    Question('SODIS means leaving PET bottles in the sun for:',
        ['15 minutes', '6 hours', '1 week', '1 hour'], 1,
        'Six hours in direct sun; two days if cloudy.'),
  ],
);

// =====================================================================
// FIRE
// =====================================================================
const fireEn = Category(
  id: 'fuego',
  name: 'Fire',
  icon: Icons.local_fire_department_outlined,
  summary: 'Heat, light, cooking and purifying: lighting it and keeping it.',
  articles: [
    Article('fuego_basico', 'How to light a fire', r'''
## The fire triangle
Heat + fuel + oxygen. If one is missing, it goes out.

## Prepare EVERYTHING before lighting
1. Tinder: very fine, dry material that catches a spark (cotton, dryer lint, thin bark, dry leaves, a nest of dry grass, wood shavings).
2. Kindling: sticks from match-thick to pencil-thick.
3. Small fuel: from finger-thick to wrist-thick.
4. Large fuel: to keep it going.
Have twice as much as you think you'll need.

## Lighting
- Make a dry base (sticks or bark) if the ground is damp.
- Tinder nest, light it and blow gently at the base.
- Add kindling in a teepee shape, then fuel gradually.

## Structures
- Teepee: fast and hot, ideal for starting and boiling water.
- Log cabin (crossed logs): stable, good coals for cooking.
- Star: logs pushed into the center; saves wood all night.

! Never light a fire inside a tent or closed space: carbon monoxide kills without a smell.
'''),
    Article('fuego_sinfosforos', 'Fire without matches', r'''
## Ferro rod
Scrape hard with the back of a knife directly over the tinder. The most reliable method: works when wet.

## Magnifying glass, glasses or can bottom
Focus the sun to the smallest possible point on dark tinder. A can bottom polished with toothpaste or chocolate works as a mirror.

## Battery and steel wool
Rub a 9 V battery (or two batteries in series) against fine steel wool: it glows instantly.

## Friction (bow drill)
- Soft, dry wooden board with a V notch.
- Straight, dry spindle, a bow with a cord, and a stone or hardwood piece to press on top.
- Spin fast until smoke appears and an ember forms in the notch; transfer it to the tinder nest.
It takes practice: do it before you need it.

* Keep dry tinder in a sealed bag: cotton with petroleum jelly burns for several minutes.
'''),
    Article('fuego_lluvia', 'Fire in the rain', r'''
- Look for dead wood still on trees (not on the ground).
- Split logs: the inside is usually dry.
- Birch bark, pine resin and fatwood burn even when damp.
- Make the fire under a natural roof or a high tarp.
- Put damp wood near the fire so it dries as it burns.
'''),
  ],
  quiz: [
    Question('The three elements of the fire triangle are:',
        ['Heat, fuel, oxygen', 'Wood, water, salt', 'Sun, wind, earth', 'Spark, smoke, ash'], 0,
        'Without one of the three there is no fire.'),
    Question('What do you prepare before lighting?',
        ['Only thick wood', 'Tinder, kindling and fuel of several sizes', 'Nothing', 'Water'], 1,
        'Having everything ready keeps the first flame from dying.'),
    Question('The most reliable method if everything is wet is:',
        ['Magnifying glass', 'Ferro rod', 'Bow drill', 'Rubbing stones'], 1,
        'A ferro rod throws very hot sparks even when wet.'),
    Question('Why not light a fire inside a tent?',
        ['The smell', 'Carbon monoxide and fire risk', 'Nothing happens', 'It uses up wood'], 1,
        'Carbon monoxide has no smell and kills; there is also a fire risk.'),
  ],
);

// =====================================================================
// SHELTER
// =====================================================================
const shelterEn = Category(
  id: 'refugio',
  name: 'Shelter',
  icon: Icons.cabin_outlined,
  summary: 'Protection from cold, rain, sun and wind.',
  articles: [
    Article('ref_ubicacion', 'Choosing where to shelter', r'''
## Look for
- Slightly raised, flat ground with drainage.
- Near (not next to) water: 50–100 m.
- Natural wind protection: rocks, trees.
- Materials nearby: branches, leaves.

## Avoid
- Riverbeds and dry streambeds: flash floods.
- Under trees with dead branches ("widowmakers").
- The base of unstable slopes (landslides) and exposed peaks (lightning).
- Near ant or wasp nests.

* In a building: choose small, interior rooms on lower floors; they are easier to heat and defend.
'''),
    Article('ref_tipos', 'Simple shelters', r'''
## Lean-to
- A horizontal pole between two trees at chest height.
- Branches leaned on one side to form the roof.
- Cover with leaves, palm fronds or a tarp from bottom to top, like shingles.
- Put the fire in front; a log wall behind the fire reflects the heat.

## Debris hut (A-frame)
- A long ridge pole resting on a stump: just a bit longer than you.
- Ribs of branches on the sides.
- Cover with 60–90 cm of dry leaves. Thicker = warmer.
- Stuff the inside too. It keeps you warm without fire.

## With a tarp or plastic
- Rope between two trees, tarp over it in an A shape, corners tied down.
- Always insulate yourself from the ground: the ground steals heat faster than air.

! A small shelter is warmer. Only slightly bigger than your body.
'''),
    Article('ref_ropa', 'Clothing and temperature', r'''
## Layering system
- Base layer: synthetic or wool, wicks away sweat. Avoid cotton in the cold: wet cotton doesn't insulate.
- Mid layer: insulating (fleece, wool, down).
- Outer layer: blocks wind and rain.

## Rules
- Remove layers before you sweat; sweat chills you later.
- Cover head, neck and hands.
- Sleeping with tomorrow's clothes inside the sleeping bag keeps them dry and warm.
* Newspaper between layers of clothing works as emergency insulation.
'''),
  ],
  quiz: [
    Question('Where should you NOT build a shelter?',
        ['Raised ground', 'In a dry streambed', 'Protected from wind', 'Near materials'], 1,
        'Flash floods can sweep you away.'),
    Question('Why insulate yourself from the ground?',
        ['Only because of insects', 'The ground steals heat quickly', 'It\'s more comfortable', 'It doesn\'t matter'], 1,
        'Conduction to cold ground chills the body very fast.'),
    Question('In cold weather, which fabric should you avoid as a base layer?',
        ['Wool', 'Synthetic', 'Cotton', 'Fleece'], 2,
        'Wet cotton loses almost all its insulating power.'),
  ],
);
