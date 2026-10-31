import 'package:flutter/material.dart';

class Article {
  final String id;
  final String title;

  /// Marcado simple:
  /// `## Título`, `- viñeta`, `! advertencia`, `* consejo`, línea vacía = espacio.
  final String body;
  const Article(this.id, this.title, this.body);
}

class Question {
  final String q;
  final List<String> options;
  final int answer;
  final String why;
  const Question(this.q, this.options, this.answer, this.why);
}

class Category {
  final String id;
  final String name;
  final IconData icon;
  final String summary;
  final List<Article> articles;
  final List<Question> quiz;
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.summary,
    required this.articles,
    this.quiz = const [],
  });
}
