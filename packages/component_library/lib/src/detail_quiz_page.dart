import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class DetailQuizPage extends StatelessWidget {
  const DetailQuizPage({super.key});

  final quiz = const Quiz(
      creator: 'Fabrioche',
      title: 'Culture générale',
      description: 'Connaissez vous des choses inutiles?',
      questions: [],
      tags: [
        "#general",
        "#culture",
        "#inutile",
        "#aigri",
      ]);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DetailQuizItem(quiz: quiz),
        const SizedBox(height: 100),
        const StartButton(),
      ],
    );
  }
}
