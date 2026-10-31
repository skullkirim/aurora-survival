import 'package:flutter/material.dart';

import '../models.dart';

// =====================================================================
// SELF-PROTECTION AND SAFETY
// =====================================================================
const safetyEn = Category(
  id: 'seguridad',
  name: 'Self-protection and safety',
  icon: Icons.shield_outlined,
  summary: 'Awareness, a safer home, moving safely, calming conflicts, basic self-defense and protecting your body.',
  articles: [
    Article('seg_alerta', 'Staying alert without living in fear', r'''
The best fight is the one that never happens. It is almost always avoided by spotting danger early.

## The 4 alert states
- White: distracted (phone, earbuds). Avoid it on the street.
- Yellow: relaxed but aware. The normal state outside home.
- Orange: something is off (someone follows you, a group watches you). Think: where is my way out?
- Red: real danger. Act: move away, run, call for help.

## Habits
- When you enter a place, find two exits.
- Watch people's hands: danger is in what they do, not what they say.
- Trust your gut: if something feels wrong, leave without explaining.
- Don't show food, money, batteries or medicine. Whoever knows you have it will come for it.
- Blend in: plain clothes, no luxuries, don't share your plans.
- At night, only the light you need and shielded from outside: a light can be seen for kilometers.
* Don't post online where you are, what you have or when you leave home.
'''),
    Article('seg_casa', 'Making your home safer', r'''
## The basics
- Solid doors with a good lock and a bar or brace inside.
- Windows with bars or at least something that makes noise if opened (hanging cans).
- Lights or noise when there is movement outside: a dog warns better than any alarm.
- Know your neighbors: an organized block looks after itself (guard shifts, whistles).

## Supplies
- Don't keep everything in one place: split it into 2–3 hiding spots.
- Keep a small visible "give-away" stash; the main one hidden.

## Safe room
- Choose an interior room with a strong door: water, flashlight, radio, first-aid kit and a way to call for help.
- If thieves break in while you are inside: lock yourself in, make noise, call for help. Things can be replaced; you can't.

## Other dangers at home
- A smoke detector and an extinguisher or bucket of sand near the kitchen.
- Check gas for leaks (soapy water on the joints: bubbles mean a leak).
- Never cook or run a generator inside a closed room: carbon monoxide kills without a smell.
'''),
    Article('seg_moverse', 'Moving around safely', r'''
## Before leaving
- Tell someone where you are going, which route and when you will be back. If you don't return, they know where to look.
- Carry water, a flashlight, a whistle, a charged phone and something to eat.
- Go by day and in a group of 3 or more when things are tense.

## On the way
- Avoid crowds, looting lines, unknown checkpoints and dead-end streets.
- Walk in the middle of the sidewalk, away from doorways and dark corners.
- If someone follows you: cross the street, change pace, go into a place with people. Don't go straight home.
- In a group: one in front watches, one behind checks, and everyone knows the signal to run and the meeting point.

## In a vehicle
- Doors locked and windows up at traffic lights.
- Leave room behind the car in front so you can get out.
- Keep the tank above half.
'''),
    Article('seg_conflicto', 'Calming a conflict (de-escalation)', r'''
Most fights start from pride. Whoever calms down first wins.

## How
- Distance: at least two arm lengths. Body sideways, hands open and visible at chest height.
- Low, slow voice. Short phrases: "Easy", "I don't want trouble", "I understand".
- Don't insult, mock, point or touch them.
- Listen and repeat what they want: people calm down when they feel heard.
- Give them a dignified way out: "OK, we each go our way".
- For problems inside the group, one person speaks per side, with a calm third person.

## If it is a robbery
! Hand over what they ask for. No phone, food or money is worth your life. Move slowly and announce your moves ("I'm going to take out my wallet").
- Notice details for later (clothes, tattoos, which way they go) without staring at their face.
'''),
    Article('seg_defensa', 'Basic self-defense: to escape', r'''
The goal is NOT to win: it is to break free and run toward people.

## Stance
- Feet apart, one forward, knees slightly bent.
- Hands up, open, in front of your face (it looks like you are asking for calm, but it protects your head).

## If they grab you
- By the wrist: rotate your arm toward the grabber's thumb (the weakest point) and pull hard.
- From behind: drop your weight, stomp the instep or kick the shin with your heel, and push to break free.
- By the neck: tuck your chin, raise your shoulders and pull their hands down with all your weight.

## If there is no other way
- Hit hard and fast at areas that buy you time to escape: eyes, nose, groin, knee.
- Shout "HELP!" or "FIRE!": people react faster.
- As soon as you are free: run. Don't stay to fight.
* Practice these moves slowly with someone you trust. Under stress, only what you practiced comes out.
! Weapons in untrained hands often end up used against whoever carries them. Escaping is almost always better.
'''),
    Article('seg_cuerpo', 'Protecting your body: smoke, sun, insects and debris', r'''
## Breathing
- Smoke, volcanic ash or rubble dust: an N95 mask tight over the nose.
- No N95: folded damp cloth over nose and mouth (it helps a little).
- Gas or chemicals: move away against the wind and uphill.

## Eyes, hands and feet
- Goggles (sunglasses or swim goggles) against dust, ash and splinters.
- Work gloves for rubble, glass and firewood.
- Boots or closed shoes always: a cut on the foot can disable you for days.
- A helmet or thick cap when entering damaged buildings.

## Sun and heat
- Shade between 11 a.m. and 3 p.m.; wide-brim hat and light long sleeves.
- Drink water even if you aren't thirsty. Dark urine = not enough water.

## Insects
- Mosquito net over the bed, long clothes at dusk and repellent.
- Empty every container of standing water: that is where dengue mosquitoes breed.

## Cold and rain
- Layers of clothing; waterproof on the outside. Dry hat and socks.
'''),
    Article('seg_vulnerables', 'Looking after children, elders and vulnerable people', r'''
## Children
- They should know their full name, their parents' names and a phone number. Also write it on paper inside their clothes.
- An agreed meeting point if they get lost: "If we get separated, go to the church" (or a fixed place).
- A family code word: if someone says you sent them to pick the kids up and doesn't know the word, they don't go.
- Never alone in shelters, lines or bathrooms.

## Elders and people with disabilities
- A list of their medicines, doses and conditions (use the app's Medical card).
- Who is in charge of each person in an evacuation.
- Cane, glasses, hearing aids and chargers in the emergency bag.

## In shelters and camps
- Sleep in family groups, never isolated.
- Toilets and latrines lit, nearby and separate for women and men.
- Go with someone to the toilet at night.
! If someone suffers harassment or abuse, believe them, get them safe and tell the shelter organizers or the authorities.
'''),
  ],
  quiz: [
    Question('Outside home, your normal alert state should be:', ['White (distracted)', 'Yellow (relaxed but aware)', 'Always red', 'It doesn\'t matter'], 1,
        'Aware without living in fear: that way you see danger in time.'),
    Question('If you are robbed at gunpoint, the best thing is:', ['Fight', 'Hand over what they ask with slow moves', 'Run at the robber', 'Shout at them'], 1,
        'Things can be replaced; your life can\'t.'),
    Question('In self-defense the goal is:', ['Win the fight', 'Break free and run', 'Punish the attacker', 'Take their weapon'], 1,
        'Escaping toward people is the safest option.'),
    Question('To stop a child leaving with a stranger, use:', ['A family code word', 'Give them candy', 'Nothing', 'Leave them alone'], 0,
        'If whoever picks them up doesn\'t know the code word, they don\'t go.'),
  ],
);
