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
      children: [
        Container(
          color: Colors.grey,
          child: const Text('Quizzy', textAlign: TextAlign.center),
        ),
        Container(
          color: Colors.black,
          child: Column(
            children: [
              DetailQuizItem(quiz: quiz),
            ],
          ),
        ),
      ],
    );
  }
}
