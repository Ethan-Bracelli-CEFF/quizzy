import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    return Storybook(
      initialStory: 'Widgets/Answer',
      stories: [
        Story(
          name: 'Widgets/QuizItem',
          description: 'La tuile d\'un quiz',
          builder: (context) => QuizItem(quiz: quiz),
        ),
        Story(
          name: 'Widgets/QuizDetail',
          description: 'Grande tuile de detail d\'un quiz',
          builder: (context) => DetailQuizItem(quiz: quiz),
        ),
        Story(
          name: 'Widgets/StartButton',
          description: 'Bouton pour commencer un quiz',
          builder: (context) => StartButton(),
        ),
        Story(
          name: 'Widgets/Question',
          description: 'Zone dédié à la question dans un quiz',
          builder: (context) =>
              QuestionQuiz(text: 'Quel est le surnom de Fabian Marti?'),
        ),
        Story(
          name: 'Widgets/Answer',
          description: 'Bouton re réponse à une question',
          builder: (context) => AnswerItem(text: 'Martin'),
        ),
      ],
      wrapperBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizzy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Center(child: child),
        ),
      ),
    );
  }
}
