import 'package:flutter/material.dart';

import '../core/i18n.dart';
import '../core/storage.dart';
import '../data/recipes.dart';
import 'inventory_screen.dart' show InventoryScreen;

/// Recetas de supervivencia según lo que hay en tu despensa (Provisiones).
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});
  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String? _cat;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pantry = Store.jsonList('inventory');
    final ranked = rankRecipes(pantry);
    final ready = ranked.where((r) => r.$3.isEmpty).length;
    return Scaffold(
      appBar: AppBar(title: Text(tr('Recetas con tu despensa', 'Recipes from your pantry', 'Receitas com sua despensa'))),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    pantry.isEmpty
                        ? tr('Tu despensa está vacía', 'Your pantry is empty', 'Sua despensa está vazia')
                        : tr('Con lo que tienes puedes preparar $ready receta(s)', 'With what you have you can make $ready recipe(s)',
                            'Com o que você tem dá para fazer $ready receita(s)'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)),
                const SizedBox(height: 4),
                Text(tr('Se calcula con lo que anotes en Provisiones (arroz, harina, latas, aceite...).',
                    'Based on what you list in Supplies (rice, flour, cans, oil...).', 'Calculado com o que você anotar em Provisões (arroz, farinha, latas, óleo...).')),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.inventory_2_outlined),
                    label: Text(tr('Abrir Provisiones', 'Open Supplies', 'Abrir Provisões')),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InventoryScreen()))
                        .then((_) => setState(() {})),
                  ),
                ),
              ]),
            ),
          ),
          Card(
            color: Colors.green.withValues(alpha: 0.08),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(tr(
                  'Ahorra combustible: remoja granos la noche antes, cocina siempre TAPADO y, cuando hierva, envuelve la olla en mantas o métela en una caja con ropa (caja de calor): se sigue cocinando sola.',
                  'Save fuel: soak grains the night before, always cook COVERED and, once it boils, wrap the pot in blankets or put it in a box with clothes (heat-retention box): it keeps cooking by itself.',
                  'Economize combustível: deixe os grãos de molho na noite anterior, cozinhe sempre TAMPADO e, quando ferver, enrole a panela em cobertores ou coloque numa caixa com roupas (caixa térmica): ela continua cozinhando sozinha.')),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: ChoiceChip(label: Text(tr('Todas', 'All')), selected: _cat == null, onSelected: (_) => setState(() => _cat = null)),
              ),
              for (final c in recipeCats)
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ChoiceChip(label: Text(recipeCatLabel(c)), selected: _cat == c, onSelected: (_) => setState(() => _cat = c)),
                ),
            ]),
          ),
          for (final (r, _, miss) in ranked.where((e) => _cat == null || e.$1.cat == _cat))
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeScreen(r, pantry))),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: (miss.isEmpty ? Colors.green : (miss.length == 1 ? Colors.orange : Colors.grey)).withValues(alpha: 0.2),
                      child: Icon(r.icon, color: miss.isEmpty ? Colors.green : (miss.length == 1 ? Colors.orange : Colors.grey)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(t3(r.name), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          miss.isEmpty
                              ? tr('✔ Tienes todo · ${t3(r.time)}', '✔ You have everything · ${t3(r.time)}', '✔ Você tem tudo · ${t3(r.time)}')
                              : tr('Falta: ${miss.map(groupLabel).join(', ')}', 'Missing: ${miss.map(groupLabel).join(', ')}',
                                  'Falta: ${miss.map(groupLabel).join(', ')}'),
                          style: TextStyle(color: miss.isEmpty ? Colors.green : Colors.grey),
                        ),
                      ]),
                    ),
                    const Icon(Icons.chevron_right),
                  ]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;
  final List<Map<String, dynamic>> pantry;
  const RecipeScreen(this.recipe, this.pantry, {super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final r = recipe;
    Widget ing(String g, bool required) {
      final ok = g.split('|').any((e) => hasIngredient(e, pantry));
      return ListTile(
        dense: true,
        leading: Icon(ok ? Icons.check_circle : (required ? Icons.cancel : Icons.radio_button_unchecked),
            color: ok ? Colors.green : (required ? Colors.red : Colors.grey)),
        title: Text(groupLabel(g), style: const TextStyle(fontSize: 15)),
        subtitle: required ? null : Text(tr('opcional', 'optional', 'opcional')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(t3(r.name))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            Icon(r.icon, size: 40, color: cs.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(t3(r.name), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          ]),
          Text('⏱ ${t3(r.time)}', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Text(tr('Ingredientes', 'Ingredients', 'Ingredientes'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)),
          for (final g in r.needs) ing(g, true),
          for (final g in r.optional) ing(g, false),
          const SizedBox(height: 12),
          Text(tr('Preparación', 'Method', 'Preparo'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)),
          for (var i = 0; i < r.steps.length; i++)
            ListTile(
              leading: CircleAvatar(backgroundColor: cs.primary, child: Text('${i + 1}', style: const TextStyle(color: Colors.black))),
              title: Text(t3(r.steps[i]), style: const TextStyle(fontSize: 16)),
            ),
          if (r.tip != null)
            Card(
              color: Colors.amber.withValues(alpha: 0.1),
              child: Padding(padding: const EdgeInsets.all(12), child: Text('💡 ${t3(r.tip!)}')),
            ),
          const SizedBox(height: 8),
          Text(
              tr('Hierve el agua si no es segura. Lávate las manos antes de cocinar.', 'Boil water if it isn\'t safe. Wash your hands before cooking.',
                  'Ferva a água se não for segura. Lave as mãos antes de cozinhar.'),
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
