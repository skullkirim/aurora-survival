import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// NAVIGATION AND SIGNALS
// =====================================================================
const navigationEn = Category(
  id: 'orientacion',
  name: 'Navigation and signals',
  icon: Icons.explore_outlined,
  summary: 'Finding your way without GPS and calling for rescue.',
  articles: [
    Article('ori_sol', 'Navigating by the sun and stars', r'''
## The sun
- It rises roughly in the East and sets in the West.
- Near the equator the sun is almost overhead at noon; use morning or afternoon to orient yourself.

## Shadow-stick method (the most reliable)
1. Push a straight stick into the ground.
2. Mark the tip of the shadow with a stone.
3. Wait 15–20 minutes and mark the new tip.
4. The line from the first mark to the second points from West to East.

## At night
- Northern hemisphere: the North Star marks North (near the equator it is very low on the horizon).
- Southern Cross: extend the long axis of the cross 4.5 times; from there drop straight to the horizon: that is South.
- Orion: the sword's star rises almost exactly in the East.

## Estimating daylight
Stretch out your arm, hand horizontal under the sun: each finger between the sun and the horizon ≈ 15 minutes of light.
'''),
    Article('ori_brujula', 'Using a compass and coordinates', r'''
## Compass
- Keep it away from metal, magnets and a charging phone.
- The needle (or the app) points to magnetic North; near Colombia the difference from true North is small.
- To walk in a straight line: pick a bearing, fix a visible point in that direction (tree, rock), walk to it, repeat.

## GPS coordinates
- Latitude: North/South of the equator (Colombia: between −4° and 13°).
- Longitude: East/West (Colombia: approx. −67° to −79°).
- 0.001° ≈ 111 meters.

* This app's Map tab saves points (water, shelter, danger) and guides you to them with a compass, without internet.
'''),
    Article('ori_perdido', 'If you are lost: S.T.O.P.', r'''
- S – Sit: stop. Walking in panic makes everything worse.
- T – Think: where did I come from? How long did I walk?
- O – Observe: terrain, water, sun, resources, dangers.
- P – Plan: decide to stay or move.

## Stay or move
- If someone knows where you are, stay and signal.
- If you must move: follow water downhill; rivers lead to towns.
- Mark your path (broken branches, stacked stones) so you can come back.
'''),
    Article('ori_senales', 'Rescue signals', r'''
## Three = help
Three fires in a triangle, three whistle blasts, three shots, three flashes.

## SOS in Morse code
· · · — — — · · ·  (3 short, 3 long, 3 short). Use it with a flashlight, mirror, knocks or whistle. The app has SOS with the flash.

## Ground-to-air signals (make them big, at least 3 m, with contrast)
- V: I need help.
- X: I need medical assistance.
- Arrow →: I am going this way.
- N: no / negative.  Y: yes / affirmative.

## Signal mirror
Reflect the sun toward a plane or boat: it can be seen for tens of kilometers. Aim by extending your other hand with two fingers in a V and putting the flash between them.

## Smoke
- Day: white smoke (green grass on the fire) against a dark background.
- Black smoke (rubber, oil) against a light background or snow.
- At night: a bright fire.
'''),
    Article('ori_morse', 'Morse code', r'''
Units: dot = 1, dash = 3, gap between signals = 1, between letters = 3, between words = 7.

- A ·—   B —···   C —·—·   D —··
- E ·   F ··—·   G ——·   H ····
- I ··   J ·———   K —·—   L ·—··
- M ——   N —·   O ———   P ·——·
- Q ——·—   R ·—·   S ···   T —
- U ··—   V ···—   W ·——   X —··—
- Y —·——   Z ——··
- 1 ·————   2 ··———   3 ···——   4 ····—   5 ·····
- 6 —····   7 ——···   8 ———··   9 ————·   0 —————

* Use the Morse translator in Tools to send any message with the flashlight.
'''),
  ],
  quiz: [
    Question('SOS in Morse is:',
        ['3 long, 3 short, 3 long', '3 short, 3 long, 3 short', '1 long', '5 short'], 1,
        '· · · — — — · · ·'),
    Question('With the shadow method, the first mark indicates...',
        ['East', 'North', 'West', 'South'], 2,
        'The sun moves west, so the shadow moves east: the first mark is West.'),
    Question('A big X on the ground for a plane means:',
        ['All good', 'I need medical assistance', 'I am going there', 'Yes'], 1,
        'V = help, X = medical assistance.'),
    Question('Lost in the wild and nobody knows where you are. What do you follow?',
        ['Always go uphill', 'Water downhill', 'Walk at night', 'Walk in circles'], 1,
        'Rivers and streams usually lead to towns.'),
    Question('Each finger between the sun and the horizon equals about...',
        ['5 min', '15 min', '1 hour', '2 hours'], 1,
        'About 15 minutes of light per finger.'),
  ],
);

// =====================================================================
// KNOTS AND TOOLS
// =====================================================================
const knotsEn = Category(
  id: 'nudos',
  name: 'Knots and tools',
  icon: Icons.handyman_outlined,
  summary: 'Essential knots, knife, rope and backpack.',
  articles: [
    Article('nud_esenciales', 'The 6 essential knots', r'''
## Bowline
A fixed loop that doesn't tighten or slip. For rescue, tying to a tree, tying around your waist.
"The rabbit comes out of the hole, goes around the tree and back into the hole": make a small loop, pass the end up through it, around the standing line from behind and back down through the loop.

## Clove hitch
Quick tie to a post. Two crossed turns, the second tucked under itself.

## Square knot (reef knot)
Joins two ropes of the same thickness, and bandages. Right over left, then left over right.

## Taut-line hitch
To tension tent and tarp lines; it slides to adjust but holds under load.

## Figure eight
Stopper at the end of the rope so it doesn't slip through a hole. Base of climbing knots.

## Timber hitch
Dragging logs. Wrap around, twist the end around itself 3 times. Releases easily.

* Practice each knot with your eyes closed: in an emergency it may be dark or cold.
'''),
    Article('nud_mochila', '72-hour backpack', r'''
A backpack ready to grab in minutes.

- Water: 3 liters per person + a purification method.
- Food: 3 days of food that doesn't need cooking (bars, peanuts, tuna, raw cane sugar).
- Headlamp + batteries, or a crank flashlight.
- Lighter, matches in a sealed bag, ferro rod.
- Multi-tool.
- First-aid kit and personal medications.
- Emergency blanket, poncho or tarp, rope (15 m).
- Change of clothes, socks, hat.
- Whistle.
- Copies of documents in a plastic bag, cash in small bills.
- Charged power bank, battery or crank radio.
- Notebook, pencil, paper map of your area.
- Hygiene: soap, toothbrush, toilet paper, sanitary pads, face masks.

* Use the checklist in Supplies to check your backpack.
'''),
    Article('nud_cuchillo', 'Knife and axe: safe use', r'''
- Always cut away from your body; nothing in front of the blade (the "blood triangle": inner thighs and groin).
- A sharp knife is safer than a dull one: it slips less.
- Sharpen on a wet smooth stone at about 20°, the same number of strokes on each side.
- Axe: feet wide apart, chop with the log on top of another log, never on the ground toward your feet.
- Keep it sheathed and dry; oil the blade to prevent rust.
'''),
  ],
  quiz: [
    Question('The knot that makes a fixed loop for rescue is:',
        ['Square knot', 'Bowline', 'Figure eight', 'Clove hitch'], 1,
        'The bowline doesn\'t tighten or slip under load.'),
    Question('How much water per person goes in the 72-hour backpack?',
        ['1 glass', '3 liters minimum', '20 liters', 'None'], 1,
        'About 3 liters plus a way to purify more.'),
    Question('Is a dull knife safer?',
        ['Yes', 'No, it slips more and needs more force', 'Same', 'Depends on the color'], 1,
        'A good edge needs less force and slips less.'),
  ],
);

// =====================================================================
// DISASTERS AND DANGERS
// =====================================================================
const disastersEn = Category(
  id: 'desastres',
  name: 'Disasters and dangers',
  icon: Icons.warning_amber_outlined,
  summary: 'Earthquakes, floods, volcanoes, epidemics and security.',
  articles: [
    Article('des_sismo', 'Earthquake', r'''
Colombia is a high seismic risk zone.

## During
- DROP, COVER and HOLD ON: under a sturdy table, or against an interior wall covering your head and neck.
- Away from windows, shelves and objects that can fall.
- Don't run outside during the shaking or use elevators.
- If you are outside: move away from buildings, poles and wires.

## After
- Expect aftershocks.
- Check for a gas smell: if you smell it, don't switch anything on, open up and get out.
- Cut the power and gas if you can.
- If trapped: cover your mouth, knock on pipes or walls (three knocks), use a whistle; shout only if necessary to save energy.
'''),
    Article('des_inundacion', 'Floods and mudslides', r'''
- Go to high ground immediately. Don't wait for the water to arrive.
- 15 cm of moving water can knock you down; 60 cm can carry a car away.
- Don't cross swollen rivers. If you must cross: at the widest, slowest stretch, facing diagonally into the current, with a stick as a third leg, backpack waist strap unbuckled.
- Listen: a loud roar upstream or muddy water with logs may announce a mudslide (as in Armero and Mocoa). Climb sideways, not downstream.
- Flood water is contaminated: don't drink it without purifying.
'''),
    Article('des_volcan', 'Volcanic eruption and ash', r'''
- Stay away from river channels coming down from the volcano: lahars (mudflows) travel very fast.
- Protect your breathing: N95 mask or a damp cloth.
- Sealed goggles for your eyes.
- Clear ash from roofs: it is heavy and collapses them.
- Cover water tanks.
'''),
    Article('des_epidemia', 'Epidemics and quarantine', r'''
- Handwashing with soap for 20 seconds: the most effective measure.
- Isolate the sick in a separate space, with a single person caring for them.
- Masks for the sick person and the caregiver.
- Separate utensils; wash clothes and dishes with hot water and soap.
- Bury or burn feces and waste far (at least 30 m) from water.
- Quarantine: anyone arriving from outside stays 14 days separated from the group if there is an active contagious disease.
'''),
    Article('des_nuclear', 'Nuclear or chemical accident', r'''
## Radiation / explosion
- Get into a solid building, to the center and the basement if there is one: away from roofs and outer walls.
- Stay inside at least 24 hours: fallout radiation drops quickly in the first days.
- When you get in: remove outer clothing (it removes much of the dust), put it in a bag and wash with soap and water; don't use conditioner.
- Water and food in closed containers are safe.

## Chemical
- Go to upper floors (many gases are heavier than air).
- Close windows, turn off ventilation, seal gaps with wet cloth and tape.
'''),
    Article('des_seguridad', 'Personal and group security', r'''
- Discretion: don't show your supplies; desperate people can become dangerous.
- Light and smoke reveal your position at night: cover windows.
- Move in groups; agree on signals and meeting points.
- Night watch shifts: 2 hours per person.
- Agree on code words to recognize each other.
- Avoid conflict: negotiating and withdrawing is almost always better than fighting. A wound without a doctor can be fatal.
'''),
  ],
  quiz: [
    Question('During an earthquake you should:',
        ['Run outside', 'Drop, cover and hold on', 'Use the elevator', 'Stand by a window'], 1,
        'Running during the shaking causes many injuries from falling objects.'),
    Question('How much moving water can knock a person down?',
        ['2 meters', '15 cm', '1 meter', '5 cm never'], 1,
        'About 15 cm of fast water can knock you over.'),
    Question('After radioactive fallout, what do you do when entering home?',
        ['Nothing', 'Remove outer clothing and wash', 'Open windows', 'Go to the roof'], 1,
        'Much of the contamination stays on outer clothing.'),
    Question('With chemical gases it is better to...',
        ['Go to the basement', 'Go upstairs and seal', 'Run outside', 'Open windows'], 1,
        'Many toxic gases are heavier than air.'),
  ],
);
