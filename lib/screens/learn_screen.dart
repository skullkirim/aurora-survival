import 'dart:math';

import 'package:flutter/material.dart';

import '../core/i18n.dart';

import '../core/storage.dart';
import '../data/library.dart';
import 'library_screen.dart';

/// Modo entrenamiento: cursos por tema (lecciones + examen) con progreso.
class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});
  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

double catProgress(Category c) {
  final read = Store.read;
  final r = c.articles.where((a) => read.contains(a.id)).length / c.articles.length;
  if (c.quiz.isEmpty) return r;
  final best = Store.quizBest(c.id);
  final q = best < 0 ? 0.0 : best / c.quiz.length;
  return r * 0.5 + q * 0.5;
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = library.map(catProgress).reduce((a, b) => a + b) / library.length;
    final rank = switch (total) {
      < 0.15 => tr('Novato', 'Rookie'),
      < 0.40 => tr('Aprendiz', 'Apprentice'),
      < 0.70 => tr('Sobreviviente', 'Survivor'),
      < 0.95 => tr('Experto', 'Expert'),
      _ => tr('Reconstructor', 'Rebuilder'),
    };

    final rankNames = [tr('Novato', 'Rookie'), tr('Aprendiz', 'Apprentice'), tr('Sobreviviente', 'Survivor'), tr('Experto', 'Expert'), tr('Reconstructor', 'Rebuilder')];
    final rankIdx = rankNames.indexOf(rank);
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(tr('Aprender', 'Learn'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cs.primary)),
            Text(tr('Cada tema tiene lecciones con dibujos y un examen al final.', 'Each topic has illustrated lessons and a quiz at the end.')),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Icon(Icons.military_tech, color: cs.primary, size: 36),
                    const SizedBox(width: 8),
                    Text(tr('Rango: $rank', 'Rank: $rank', 'Patente: $rank'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    for (var k = 0; k < rankNames.length; k++)
                      Expanded(
                        child: Column(children: [
                          Container(
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            color: k <= rankIdx ? cs.primary : const Color(0xFF333333),
                          ),
                          const SizedBox(height: 4),
                          Text(rankNames[k],
                              style: TextStyle(fontSize: 10, color: k <= rankIdx ? cs.primary : Colors.grey)),
                        ]),
                      ),
                  ]),
                  const SizedBox(height: 8),
                  Text(tr('${(total * 100).round()} % completado · lee lecciones y aprueba exámenes para subir', '${(total * 100).round()} % complete · read lessons and pass quizzes to rank up', '${(total * 100).round()} % concluído · leia lições e passe nas provas para subir')),
                ]),
              ),
            ),
          ]),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 0.95,
          ),
          delegate: SliverChildBuilderDelegate(
            (_, i) => TopicCard(library[i],
                onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => CategoryScreen(library[i])))
                    .then((_) => setState(() {}))),
            childCount: library.length,
          ),
        ),
      ),
    ]);
  }
}

class QuizScreen extends StatefulWidget {
  final Category cat;
  const QuizScreen(this.cat, {super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<Question> _qs = [...widget.cat.quiz]..shuffle(Random());
  int _i = 0;
  int _score = 0;
  int? _picked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_i >= _qs.length) {
      final pct = _score / _qs.length;
      return Scaffold(
        appBar: AppBar(title: Text(tr('Resultado', 'Result'))),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(pct >= 0.7 ? Icons.emoji_events : Icons.refresh,
                  size: 72, color: cs.primary),
              const SizedBox(height: 12),
              Text('$_score / ${_qs.length}',
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(pct >= 0.7
                  ? tr('¡Aprobado! Este conocimiento puede salvarte la vida.', 'Passed! This knowledge can save your life.')
                  : tr('Repasa las lecciones e inténtalo de nuevo.', 'Review the lessons and try again.'),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              FilledButton(
                  onPressed: () => Navigator.pop(context), child: Text(tr('Volver', 'Back'))),
            ]),
          ),
        ),
      );
    }

    final q = _qs[_i];
    return Scaffold(
      appBar: AppBar(title: Text(tr('Pregunta ${_i + 1} de ${_qs.length}', 'Question ${_i + 1} of ${_qs.length}', 'Pergunta ${_i + 1} de ${_qs.length}'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(q.q, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          for (var o = 0; o < q.options.length; o++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(14),
                  backgroundColor: _picked == null
                      ? null
                      : o == q.answer
                          ? Colors.green.withValues(alpha: 0.25)
                          : o == _picked
                              ? Colors.red.withValues(alpha: 0.25)
                              : null,
                ),
                onPressed: _picked != null
                    ? null
                    : () => setState(() {
                          _picked = o;
                          if (o == q.answer) _score++;
                        }),
                child: Text(q.options[o], style: const TextStyle(fontSize: 16)),
              ),
            ),
          if (_picked != null) ...[
            const SizedBox(height: 8),
            Text(_picked == q.answer ? tr('✔ Correcto', '✔ Correct') : tr('✘ Incorrecto', '✘ Wrong'),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _picked == q.answer ? Colors.green : Colors.red)),
            const SizedBox(height: 4),
            Text(q.why, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final next = _i + 1;
                if (next >= _qs.length) await Store.saveQuiz(widget.cat.id, _score);
                setState(() {
                  _i = next;
                  _picked = null;
                });
              },
              child: Text(_i + 1 >= _qs.length ? tr('Ver resultado', 'See result') : tr('Siguiente', 'Next')),
            ),
          ],
        ],
      ),
    );
  }
}
