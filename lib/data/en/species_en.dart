/// English texts for the visual guide: id -> (name, how to recognize, uses/danger).
const Map<String, (String, String, String)> speciesEnText = {
  // FRUITS
  'mango': ('Mango', r'''
- Large tree (10–30 m), dense round crown, evergreen.
- Long, narrow, shiny leaves; new ones come out reddish.
- Oval fruit hanging on long stems; green, yellow or reddish.''', r'''
- Very common in hot climates (0–1,500 m). Sweet flesh, rich in energy and vitamins A and C.
! The peel and sap are in the same family as cashew: they can cause a rash in sensitive people. Peel the mango if it irritates you.'''),
  'guayaba': ('Guava', r'''
- Shrub or small tree; smooth cinnamon-colored bark that peels in sheets.
- Opposite, rough leaves with very marked veins; they smell when crushed.
- Round fruit, green to yellow, strong sweet smell; pink or white flesh with many seeds.''', r'''
- One of the fruits highest in vitamin C. Grows in almost any warm or temperate pasture.
* Guava leaf tea is traditionally used against diarrhea.
- Its wood is excellent for smoking meat.'''),
  'papaya': ('Papaya', r'''
- Single straight trunk without branches, with scars from fallen leaves.
- Huge, deeply cut (palmate) leaves only at the top.
- Fruit attached directly to the trunk under the leaves.''', r'''
- Ripe fruit: sweet and good for digestion. Green and cooked it's eaten as a vegetable.
- The seeds taste peppery; use small amounts.
* One of the few plants with milky sap that is edible; the sap of unripe fruit irritates the skin.'''),
  'guanabana': ('Soursop', r'''
- Small tree with shiny, dark green, fragrant leaves.
- Large green fruit with soft, curved "spines".
- White, fibrous, juicy flesh with black seeds.''', r'''
- Edible flesh, sour and sweet.
! Don't eat the seeds or overuse the leaves in tea: they contain substances toxic to the nervous system.'''),
  'coco': ('Coconut', r'''
- Tall palm with a thin, leaning trunk, typical of beaches.
- Long, feather-like leaves.
- Clusters of green or brown coconuts at the top.''', r'''
- The water of a healthy green coconut is sterile and good for hydration.
- The flesh gives lots of fat and energy; oil is made from it.
- Fibers for rope, shells as containers and tinder.
! Never stand under a palm with ripe coconuts: they fall and can kill.'''),
  'platano': ('Plantain and banana', r'''
- Large plant without a woody trunk: a "stem" of rolled leaves.
- Giant, whole leaves that tear in the wind.
- Hanging bunch with a purple flower (bud) at the tip.''', r'''
- Fruit: a staple food in Colombia. Green it's cooked; ripe it's eaten raw.
- The bud (flower) is eaten cooked.
- Leaves: roofing, plates, wrapping food, waterproof shelter.
* It spreads by suckers growing from the base: pull them out with roots and plant them.'''),
  'maracuya': ('Passion fruit', r'''
- Vine with tendrils that grab fences and trees.
- Three-lobed leaves; striking white and purple flower.
- Round yellow or purple fruit with a hard, smooth shell.''', r'''
- Sour pulp with seeds, rich in vitamins. Eat the pulp with the seeds.
! Eat only ripe fruit (yellow or purple shell, a bit wrinkled). Unripe fruit can be toxic.'''),
  'mamoncillo': ('Spanish lime', r'''
- Medium tree with compound leaves.
- Clusters of green balls with a thin, hard shell.
- Salmon-colored jelly-like flesh around a large seed.''', r'''
- Sweet and sour flesh. Common on the Caribbean coast and warm valleys.
! The seed is large and slippery: children can choke.'''),
  'borojo': ('Borojó', r'''
- Shrub of the Pacific rainforest (Chocó).
- Large, opposite leaves.
- Round brown fruit, soft when ripe, very dense brown flesh.''', r'''
- Very nutritious and energetic. Eaten as juice or sweets.
- Keeps well as a sweet or dried.'''),
  'chontaduro': ('Peach palm', r'''
- Palm with trunks full of black spines in rings.
- Clusters of red, orange or yellow fruit the size of a small egg.''', r'''
- Very nutritious: fat, protein, vitamin A. Heart of palm comes from the shoot.
! Always cooked (boiled with salt 1–3 hours). Raw it irritates the mouth and stomach.'''),
  'mora': ('Andean blackberry', r'''
- Climbing shrub with arching stems full of thorns.
- Leaves with 3 leaflets, whitish underneath.
- Fruit in clusters: green, then red and black when ripe.''', r'''
- Edible fruit, fresh or as juice; cold climate (1,800–2,800 m).
* Wild blackberries (Rubus) are generally safe: compound fruits made of "little balls".'''),
  'lulo': ('Lulo (naranjilla)', r'''
- Shrub 1–2 m, huge leaves with purple spines and hairs.
- Round orange fruit covered in fuzz that rubs off.
- Green, juicy, very sour flesh.''', r'''
- Edible when ripe (orange). Rich in vitamin C. Temperate humid climate.
! It belongs to the nightshade family: don't eat its leaves or unripe fruit.'''),
  'tomate_arbol': ('Tree tomato (tamarillo)', r'''
- Shrub 2–3 m with a fragile stem, large heart-shaped leaves with a strong smell.
- Oval hanging fruit, red or orange, smooth skin.''', r'''
- Ripe fruit is edible, sour; typically as juice. Cool-temperate climate.
- The skin is bitter: peel or scald it.'''),
  'uchuva': ('Cape gooseberry', r'''
- Herb or low shrub with heart-shaped, velvety leaves.
- Fruit: an orange ball inside a dry papery husk (calyx).''', r'''
- Very nutritious ripe fruit; keeps for weeks inside its husk.
! Only the fully ripe orange fruit. Leaves, stems and unripe fruit are toxic.'''),
  'granadilla': ('Sweet granadilla', r'''
- Vine with heart-shaped leaves.
- Oval yellow-orange fruit with spots, hard and brittle shell.
- Gray, translucent pulp with black seeds.''', r'''
- Very digestible; suitable for children and the sick. Temperate climate.'''),
  'aguacate': ('Avocado', r'''
- Large tree with oval, leathery leaves that smell of anise when crushed.
- Pear-shaped fruit, green or black, with a big seed.''', r'''
- One of the fattiest fruits: an excellent energy source.
! Leaves, skin and seed are toxic to birds, rabbits, goats and horses.'''),
  'guama': ('Ice-cream bean (guama)', r'''
- Medium tree with compound leaves.
- Long green pods (up to 1 m) hanging down.
- Inside: seeds covered in sweet white cotton.''', r'''
- Suck the sweet cotton covering the seeds.
- Shade tree for coffee; fixes nitrogen and improves the soil.
! Don't eat the seeds raw.'''),
  'maranon': ('Cashew', r'''
- Medium tree of hot, dry climates.
- Fleshy red or yellow "fruit" shaped like a bell pepper.
- A kidney-shaped nut hangs below it.''', r'''
- The fleshy part is eaten raw or as juice.
! The nut's shell has a caustic oil that burns skin and mouth. Eat the nut only after roasting it outdoors and shelling it; the smoke also irritates.'''),
  'zapote': ('South American sapote', r'''
- Tall tree with large heart-shaped leaves.
- Round green-brown fruit with a thick rind.
- Orange, fibrous, sweet flesh with several seeds.''', r'''
- Edible, energy-rich flesh; common in the Pacific and warm valleys.'''),
  'carambola': ('Star fruit', r'''
- Small tree with compound leaves.
- Yellow fruit with 5 ribs: sliced it looks like a star.''', r'''
- Refreshing, sour fruit.
! People with kidney disease must NOT eat it: it contains a toxin they can't eliminate.'''),
  'pitahaya': ('Yellow dragon fruit', r'''
- Climbing cactus with three-ribbed stems.
- Yellow fruit with spiny bumps that fall off when ripe.
- White flesh with small black seeds.''', r'''
- Sweet, laxative flesh. Remove the spines before peeling.'''),
  'naranja': ('Orange and citrus', r'''
- Tree with thorns on the branches; shiny leaves with a citrus smell.
- Very fragrant white flowers (orange blossom).''', r'''
- Vitamin C: prevents scurvy during long confinement.
- Dried peel works as tinder and a mild repellent.
* Lime: disinfects surfaces and helps preserve food.'''),
  // EDIBLE AND USEFUL PLANTS
  'yuca': ('Cassava', r'''
- Shrub 1–3 m, stems with marked nodes.
- Palmate leaves with 5–7 long lobes, reddish stalk.
- Thick underground roots, brown skin and white flesh.''', r'''
- Great source of energy. Planted with 20 cm stem cuttings.
! Contains cyanide: always peeled and well cooked. Bitter cassava needs grating, soaking and squeezing before cooking (casabe, fariña). Never raw.'''),
  'verdolaga': ('Purslane', r'''
- Creeping herb with reddish, fleshy stems.
- Small, thick, succulent spoon-shaped leaves.
- Tiny yellow flowers.''', r'''
- Leaves and stems raw or cooked; rich in omega-3. Grows as a weed in gardens and sidewalks.
! Don't confuse it with spurge (Euphorbia), which looks similar but has milky white sap: if milk comes out, it is NOT purslane.'''),
  'diente_leon': ('Dandelion', r'''
- Rosette of leaves at ground level with toothed edges.
- One yellow flower per hollow stem; then a white seed ball.''', r'''
- The whole plant is edible: young leaves in salad, roasted root as a coffee substitute. Very common in cold climates.'''),
  'amaranto': ('Amaranth (pigweed)', r'''
- Herb up to 2 m, oval leaves, sometimes reddish.
- Dense spikes of tiny green, red or purple flowers.''', r'''
- Leaves cooked like spinach; seeds as a grain (toasted or as porridge).
- Grows fast as a weed in disturbed soil.'''),
  'moringa': ('Moringa', r'''
- Very fast-growing tree, brittle branches.
- Compound leaves with small round leaflets.
- Long drumstick-shaped pods.''', r'''
- Very nutritious leaves (protein, iron, vitamins), cooked or dried as powder.
* Crushed seeds clear cloudy water (you still need to boil it afterwards).'''),
  'ortiga': ('Stinging nettle', r'''
- Herb with toothed, heart-shaped, opposite leaves.
- Covered in hairs that sting when touched.''', r'''
- Cooking removes the sting: very nutritious in soups. Fiber for cordage.
! Gather it with gloves. Pringamosa (another stinging plant) burns even more.'''),
  'ahuyama': ('Squash (ahuyama)', r'''
- Creeping plant with large rough leaves and big yellow flowers.
- Large fruit with a hard rind and orange flesh.''', r'''
- Fruit, flowers, tender leaves and toasted seeds: all edible.
- Keeps for months whole in a dry place. Part of the "milpa" (corn, beans, squash).'''),
  'guadua': ('Guadua bamboo', r'''
- Native giant bamboo (up to 25 m), green stems with nodes and white bands.
- Grows in groves along rivers.''', r'''
- "Vegetable steel": houses, bridges, pipes, containers, rafts.
- The internodes hold drinkable water at some times of year.
- Tender shoots are eaten well cooked.'''),
  // MEDICINAL
  'manzanilla': ('Chamomile', r'''
- Low herb with very fine, divided leaves.
- Flowers like small daisies: hollow yellow center and white petals. Smells like apple.''', r'''
- Tea for nerves, insomnia, cramps and digestion. Warm compresses for irritated eyes.
! Can cause allergy in people allergic to daisies.'''),
  'hierbabuena': ('Spearmint', r'''
- Herb with a square stem, toothed leaves with a strong mint smell.
- Spreads by underground stems.''', r'''
- Tea for stomach ache, gas and nausea. Freshens breath.'''),
  'sabila': ('Aloe vera', r'''
- Rosette of thick, fleshy, gray-green leaves with teeth on the edges.
- Clear gel inside the leaf.''', r'''
- The gel soothes minor burns, scrapes and sunburn.
! The yellow layer under the skin (aloin) is a strong laxative: don't take it.'''),
  'calendula': ('Calendula', r'''
- Herb with long, sticky leaves.
- Orange or yellow daisy-like flowers.''', r'''
- Compresses or salve for small wounds, irritation and stings. Edible petals.'''),
  'jengibre': ('Ginger', r'''
- Plant with long, narrow leaves on cane-like stems.
- Beige, knobby, very aromatic and spicy rhizome (root).''', r'''
- Tea for nausea, motion sickness and colds. Plant a piece of rhizome with "eyes".'''),
  'limoncillo': ('Lemongrass', r'''
- Grass in large clumps, long rough leaves that smell of lemon.''', r'''
- Relaxing and digestive tea. Planted around the house it helps keep mosquitoes away.'''),
  'eucalipto': ('Eucalyptus', r'''
- Very tall tree, bark that peels off in strips.
- Young leaves round and bluish; adult leaves long and sickle-shaped. Strong smell.''', r'''
- Steam from boiled leaves for congestion and cough.
! Don't swallow eucalyptus oil: it is toxic, especially for children.'''),
  'llanten': ('Plantain (herb)', r'''
- Rosette of broad leaves at ground level with 5–7 very marked parallel veins.
- Thin spikes of tiny flowers.''', r'''
- Crushed leaf on stings, scrapes and small wounds. Tender leaves edible cooked.
- Very common on paths and pastures.'''),
  'toronjil': ('Lemon balm', r'''
- Herb with a square stem, toothed and wrinkled leaves that smell of lemon.''', r'''
- Calming tea for anxiety, insomnia and a nervous stomach.'''),
  'ajo': ('Garlic', r'''
- Long flat leaves; bulb divided into cloves with a strong smell.''', r'''
- Mild antibacterial, seasoning. Plant the cloves one by one.
! Don't put it raw directly on wounds or skin: it can burn.'''),
  'romero': ('Rosemary', r'''
- Shrub with needle-like leaves, green on top and white underneath, very aromatic.
- Small pale blue flowers.''', r'''
- Tea for digestion and fatigue; a seasoning that helps preserve meat.'''),
  // POISONOUS PLANTS AND FUNGI
  'manzanillo': ('Manchineel', r'''
- Tree of the Caribbean and Pacific coasts, near beaches and mangroves.
- Shiny oval leaves with a yellow stalk.
- Small green-yellow fruit like little apples that smell sweet.''', r'''
! One of the most toxic trees in the world. The fruit burns the mouth and throat; the sap causes blisters and can blind.
! Don't shelter under it in the rain (water carries the sap) or burn its wood (the smoke harms eyes and lungs).'''),
  'borrachero': ('Angel\'s trumpet', r'''
- Shrub or small tree, very common in gardens and hedges in cold climates.
- Huge trumpet-shaped flowers hanging down: white, yellow, pink or red.''', r'''
! The whole plant is very toxic (scopolamine): delirium, dilated pupils, fever, paralysis, death. Not in tea or smoke. Don't touch it and then rub your eyes.'''),
  'higuerilla': ('Castor bean', r'''
- Fast-growing shrub on vacant lots and roadsides.
- Huge palmate leaves with 5–11 points, sometimes reddish.
- Clustered fruit with soft spines; shiny mottled seeds.''', r'''
! The seeds contain ricin: chewing a few can kill a child. Don't eat them or use them as necklace beads.'''),
  'adelfa': ('Oleander', r'''
- Ornamental shrub very common in medians and parks.
- Long, narrow, hard leaves in groups of 3.
- Pink, white or red flowers in clusters.''', r'''
! All parts affect the heart. Don't use its branches as roasting skewers or burn its wood.'''),
  'dieffenbachia': ('Dieffenbachia (dumb cane)', r'''
- Houseplant with large green leaves spotted white or cream.
- Thick, fleshy stem.''', r'''
! Biting it swells the mouth and tongue with intense pain; it can make breathing hard. Dangerous for children and pets.'''),
  'chocho': ('Rosary pea', r'''
- Vine with small compound leaves.
- Pods that open to show bright red seeds with a black spot.''', r'''
! A single chewed seed can be deadly (abrin). They are used in crafts: keep them away from children.'''),
  'cicuta': ('Poison hemlock', r'''
- Tall herb (up to 2 m) of the carrot family.
- Hollow stem with purple spots; leaves like parsley or fern.
- White flowers in umbrellas. Unpleasant mousy smell.''', r'''
! Deadly: it paralyzes the breathing muscles. That is why you should NEVER eat wild plants resembling carrot, parsley or cilantro.'''),
  'lantana': ('Lantana', r'''
- Strong-smelling shrub with rough stems.
- Clusters of small flowers that change color (yellow, orange, red, pink).
- Green berries that turn black.''', r'''
! Unripe berries are toxic, especially for children; the leaves poison livestock.'''),
  'pringamosa': ('Pringamosa (stinging shrub)', r'''
- Shrub with large leaves with spines and stinging hairs.
- Small white or pink fruit.''', r'''
! Contact causes intense burning that lasts hours. Wash with soap and water without rubbing; remove hairs with tape.'''),
  'amanita_phalloides': ('Death cap (deadly mushroom)', r'''
- Olive-green to whitish cap, white gills.
- Ring on the stem and a "cup" (volva) at the buried base.''', r'''
! Causes most mushroom deaths. Symptoms start 6–24 h later, when the liver is already damaged. Cooking doesn't make it safe.'''),
  'amanita_muscaria': ('Fly agaric (red mushroom)', r'''
- Bright red cap with white warts.
- Common under pine and eucalyptus in cold regions of Colombia.''', r'''
! Toxic: delirium, vomiting, seizures. Golden rule: don't eat wild mushrooms.'''),
  // DANGEROUS ANIMALS
  'mapana': ('Fer-de-lance (mapaná)', r'''
- Snake 1.2–2 m, wide triangular head.
- Brown-olive with dark triangle or "X" patterns on the sides.
- Active at night in warm areas, crops and near houses.''', r'''
! Causes most serious bites in Colombia. Immobilize, keep calm and find antivenom. Don't cut, don't suck, no tourniquet.
* Wear boots and a flashlight at night; don't reach into holes or firewood without looking.'''),
  'cascabel': ('Rattlesnake', r'''
- Thick snake with diamonds on its back and a rattle on the tail that sounds when it moves.
- Savannas and dry areas of the Caribbean and the Llanos.''', r'''
! Venom that affects nerves and muscles (blurred vision, drooping eyelids). If you hear the rattle, back away slowly.'''),
  'coral': ('Coral snake', r'''
- Small and slender, with complete red, black and yellow or white rings.
- Small, non-triangular head. Shy.''', r'''
! Very potent neurotoxic venom that can paralyze breathing hours later, even if it barely hurts. In Colombia, treat EVERY snake with colored rings as dangerous: color rhymes don't work here.'''),
  'verrugosa': ('Bushmaster', r'''
- The longest viper in the Americas (up to 3 m).
- Rough, "warty" scales, dark diamond pattern on a cream or brown background.
- Humid rainforests (Amazon, Pacific, Middle Magdalena).''', r'''
! Injects a lot of venom. Avoid the jungle at night without a flashlight.'''),
  'rana_dorada': ('Golden poison frog', r'''
- Small frog (5 cm), bright yellow or orange, sometimes mint green.
- Pacific rainforest (Cauca). Other poison frogs have bright colors with spots.''', r'''
! Its skin carries one of the most potent toxins in nature. Don't touch brightly colored frogs; if you do, don't touch your mouth or eyes and wash very well.'''),
  'viuda_negra': ('Black widow', r'''
- Small, shiny black spider, round abdomen, sometimes with a red hourglass mark.
- Messy webs in corners, firewood, latrines.''', r'''
! Bite with cramps and strong muscle pain, sweating. Dangerous for children and the elderly. Cold on the area and watch them.
* Shake out clothes, boots and blankets before using them.'''),
  'alacran': ('Scorpion', r'''
- Arachnid with pincers and a curved tail with a stinger.
- Hides under rocks, logs, bricks and inside shoes.''', r'''
! Tityus species can be serious in small children (vomiting, sweating, trouble breathing). Cold on the area and watch them.'''),
  'arana_bananera': ('Banana spider (wandering spider)', r'''
- Large, hairy brown spider (legs up to 15 cm).
- Doesn't build a web: hunts on the ground. Aggressive: rears up on its back legs.
- Common in banana groves and bunches.''', r'''
! Very painful bite; can be serious in children. Check banana bunches before carrying them.'''),
  'lonomia': ('Lonomia caterpillar', r'''
- Green-brown caterpillars with branched spines, in groups on tree trunks.
- Camouflaged against the bark.''', r'''
! Its venom stops blood from clotting: bleeding gums, blood in urine and bruises days later. Don't touch spiny or hairy caterpillars. Bleeding after contact is an emergency.'''),
  'abeja_africanizada': ('Africanized bee', r'''
- Looks like a regular bee, but defends its hive as a swarm and chases for hundreds of meters.''', r'''
! If attacked: run in a straight line to a closed place (house, car) covering your face and head. Don't jump into water: they wait above. Scrape out the stingers.'''),
  'caiman': ('Spectacled caiman', r'''
- Reptile 1.5–2.5 m in swamps, slow rivers and channels.
- Eyes and nostrils stick out of the water; at night its eyes glow red in a flashlight.''', r'''
! Avoid bathing or washing clothes in murky, still lowland water, especially at dusk.'''),
  'raya': ('Freshwater stingray', r'''
- Flat, disc-shaped fish that buries itself in the sand of rivers and river beaches.
- Tail with a serrated stinger.''', r'''
! When crossing rivers shuffle your feet: you scare them away instead of stepping on them. The wound hurts a lot: water as hot as can be tolerated (without burning) for 30–90 min.'''),
  'hormiga_conga': ('Bullet ant', r'''
- Very large black ant (2.5 cm), at the base of trees in humid forest.''', r'''
! Its sting is one of the most painful in the world; the pain lasts hours. Rarely deadly. Cold on the area and a painkiller.'''),
  'vampiro': ('Vampire bat', r'''
- Small brown bat with a flat nose. Bites livestock at night and sometimes sleeping people.''', r'''
! Transmits rabies. Sleep under a mosquito net or in a closed place. Every bat bite: wash 15 minutes with soap and water and seek a rabies vaccine.'''),
  'aedes': ('Dengue mosquito', r'''
- Black mosquito with white stripes on legs and back. Bites by day.
- Breeds in still, clean water: tires, cans, vases, uncovered tanks.''', r'''
! Transmits dengue, zika, chikungunya and yellow fever. Cover stored water, empty containers every week, use a mosquito net and long clothing.'''),
  'pito': ('Kissing bug (Chagas)', r'''
- Elongated brown bug 2–3 cm. Lives in palm-thatch roofs and cracks in mud walls.
- Bites at night, near the mouth and eyes.''', r'''
! Transmits Chagas disease (damages the heart years later). Plaster cracks, check thatched roofs, use a mosquito net.'''),
  'jaguar': ('Jaguar', r'''
- The largest cat in the Americas: yellow with black rosettes.
- Jungles and the Llanos; rarely seen.''', r'''
! Attacks on people are very rare. If you see one: don't run, don't turn your back, make yourself big, speak loudly and back away slowly.'''),
  // USEFUL / EDIBLE ANIMALS
  'hormiga_culona': ('Leafcutter queen ant', r'''
- Winged queens of leafcutter ants, large abdomen.
- They swarm out of nests at the start of the rains (March–May).''', r'''
- Toasted with salt: lots of protein and fat. A Santander tradition.
* Remove wings and legs before toasting.'''),
  'mojojoy': ('Palm weevil grub (mojojoy)', r'''
- Fat white grub (5–7 cm) with a dark head, inside fallen or rotting palm trunks.''', r'''
- Traditional food in the Amazon: very rich in fat and protein. Grilled or fried.
* It can be "farmed" by cutting a palm trunk and checking it weeks later.'''),
  'tilapia': ('Tilapia', r'''
- Freshwater fish with a tall body, gray with vertical stripes.''', r'''
- The easiest fish to raise in warm-climate ponds; eats algae, scraps and feed. Grows fast.'''),
  'bocachico': ('Bocachico', r'''
- Silvery fish with a fleshy sucker-like mouth; rivers and swamps of the Magdalena.''', r'''
- A traditional riverside protein. Many bones: it is scored before frying.'''),
  'cuy': ('Guinea pig', r'''
- Small tailless domestic rodent, many colors.''', r'''
- Raised in small spaces on grass and kitchen scraps. Breeds fast. Lean meat; a tradition in Nariño.'''),
  'conejo': ('Rabbit', r'''
- Long-eared mammal; raised in cages or pens.''', r'''
- Lean meat; its manure is excellent direct fertilizer for the garden.
! Rabbit meat alone isn't enough: your diet needs fat from other sources.'''),
  'gallina': ('Heritage chicken', r'''
- Domestic bird; heritage breeds are hardy and good mothers.''', r'''
- Eggs almost daily, meat, insect control and fertilizer. Secure coop at night against opossums and dogs.'''),
  'iguana': ('Green iguana', r'''
- Large green lizard (up to 1.5 m) with a crest of spines on its back; lives in trees near water.''', r'''
- Meat and eggs are traditionally eaten on the Caribbean coast.
! Can carry salmonella: cook very well and wash your hands. In normal times it is legally protected during breeding season.'''),
  'chiguiro': ('Capybara', r'''
- The largest rodent in the world (up to 60 kg), brown, tailless. Lives in groups near water in the Llanos.''', r'''
- A traditional source of meat in the Llanos.'''),
  'abeja_miel': ('Honey bee', r'''
- Golden-brown striped bee; hives in boxes or tree hollows.
- Colombia also has native stingless bees (angelitas).''', r'''
- Honey: food, preservative and wound care. Wax for candles and waterproofing. They pollinate crops.'''),
  'lombriz': ('Earthworm', r'''
- Pink segmented worm in moist, rich soil.''', r'''
- Fishing bait; red wigglers turn scraps into fertilizer (vermicompost).
- Edible in an emergency: purge in water and cook well.'''),
  // MORE MEDICINAL PLANTS
  'cidron': ('Lemon verbena', r'''
- Shrub 1–3 m, long narrow rough leaves in groups of 3.
- Very strong lemon smell when crushed. Tiny white or lilac flowers in spikes.''', r'''
- Digestive and calming tea: gas, cramps, nerves, insomnia.
* Very common in cold and temperate gardens.'''),
  'prontoalivio': ('Bushy lippia (prontoalivio)', r'''
- Shrub with long arching branches, small wrinkled opposite leaves with a strong mint-lemon smell.
- Lilac flowers in little heads.''', r'''
- Tea for stomach ache, cramps, gas and nerves. Widely used in rural Colombia.'''),
  'albahaca': ('Basil', r'''
- Herb with a square stem, shiny, very aromatic oval leaves.
- Spikes of white or purple flowers.''', r'''
- Digestive tea and for gas. Seasoning.
- Planted at windows and doors it helps keep mosquitoes away.'''),
  'tomillo': ('Thyme', r'''
- Low woody shrub with tiny grayish, very aromatic leaves.''', r'''
- Tea with honey for cough and throat; steam for congestion. Mild antiseptic. A seasoning that helps preserve.'''),
  'malva': ('Mallow', r'''
- Herb with rounded leaves with 5–7 lobes and toothed edges.
- Pink-purple flowers with dark stripes; fruit like little round cheeses.''', r'''
- Gargles and tea for an irritated throat and dry cough. Compresses for skin inflammation. Tender leaves edible cooked.'''),
  'sauco': ('Elder', r'''
- Shrub or small tree with compound leaves (5–7 toothed leaflets).
- Flat clusters of tiny white flowers; then black-purple berries.''', r'''
- Tea of dried FLOWERS for cough, colds and fever (it makes you sweat).
! Leaves, stems, bark and raw or unripe berries are toxic. Ripe berries only cooked.'''),
  'sangre_drago': ('Dragon\'s blood', r'''
- Tree of the Amazon and foothills, large heart-shaped leaves.
- Cutting the bark releases a dark red latex like blood.''', r'''
- A few drops of latex on small wounds and scrapes form a protective layer and help healing.
- Traditionally a few drops in water are taken for diarrhea and ulcers; don't overdo it.'''),
  'una_gato': ('Cat\'s claw', r'''
- Forest vine with curved spines like cat's claws in pairs.''', r'''
- Bark decoction: traditional for inflammation and joint pain.
! Not during pregnancy or for people with transplants or autoimmune diseases.'''),
  'arnica': ('Arnica', r'''
- Mountain herb with yellow-orange daisy-like flowers with messy petals.
- In Colombia other plants are also called "árnica"; check.''', r'''
- Compresses or salve ONLY on bumps, bruises and sprains with unbroken skin.
! Toxic if swallowed: don't drink it or put it on open wounds.'''),
  'valeriana': ('Valerian', r'''
- Tall herb with divided leaves, white or pink flowers in clusters.
- The dried root smells strong and unpleasant (like cheese or socks).''', r'''
- Mild root decoction for insomnia and anxiety. It makes you sleepy: don't combine with alcohol or sleeping pills.'''),
  'achiote': ('Annatto (achiote)', r'''
- Shrub with heart-shaped leaves, pink flowers.
- Hairy red capsules with seeds covered in red-orange paste.''', r'''
- The seeds color and season food.
- Indigenous peoples use the paste on the skin as sunscreen and insect repellent.'''),
  'quina': ('Cinchona (quina)', r'''
- Andean cloud-forest tree, large oval leaves with reddish veins.
- Pink tubular flowers in clusters; bitter bark.''', r'''
- Its bark gave quinine, the first medicine against malaria.
! Dangerous in excess: ringing ears, deafness, vision and heart problems. Only for malaria with no other option.'''),
  'cola_caballo': ('Horsetail', r'''
- Plant without true leaves: hollow green stems with nodes and rings of thin branches, like a horse's tail.
- Grows in damp places and stream banks.''', r'''
- Traditional diuretic tea. Its rough stems are used to polish and scrub pots.
! Don't use it for more than 1–2 weeks in a row.'''),
  'matarraton': ('Mother of cocoa (matarratón)', r'''
- Medium tree used for living fences in warm climates, compound leaves.
- Pink-lilac flower clusters before new leaves.''', r'''
- Baths with soaked leaves: a traditional remedy to lower fever and for the skin.
- Excellent fodder and green manure; fixes nitrogen.
! External use only. It is toxic to rodents (hence its Spanish name).'''),
  'ruda': ('Rue', r'''
- Small shrub with divided blue-green leaves, very strong unpleasant smell.
- Yellow flowers with 4–5 petals.''', r'''
! A dangerous folk remedy: can cause miscarriage, liver and kidney damage. Its sap plus sunlight burns the skin (blisters). Never during pregnancy.'''),
  'paico': ('Epazote (paico)', r'''
- Herb with a very strong, penetrating smell, long toothed leaves.
- Spikes of tiny green flowers.''', r'''
! Used against parasites, but its oil is toxic and has caused deaths, especially in children. In small amounts it is used as a seasoning.'''),
};
