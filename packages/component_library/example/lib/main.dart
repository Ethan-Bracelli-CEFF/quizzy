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
      id: 'Salam',
      questions: [
        Question(
          title:
              'D\'une manière très objective quel est le meilleurs cours du jeudi?',
          answers: ['Simon', 'Quentin', 'Martim', 'Fabian'],
          rightAnswer: 2,
        ),
        Question(
          title: 'Laquelle de ces personnes préfère le cours de mobile?',
          answers: ['Ewan', 'Quentin', 'Martim', 'Le Hockey'],
          rightAnswer: 2,
        ),
        Question(
          title: 'Qui a eu la meilleure note au cie 295?',
          answers: ['Le Hockey', 'Quentin', 'Ewan', 'Fabian'],
          rightAnswer: 2,
        ),
      ],
      tags: [
        "#general",
        "#culture",
        "#inutile",
        "#aigri",
      ]);

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: 'Widgets/QuestionTitleItem',
      stories: [
        Story(
          name: 'Widgets/QuizItem',
          description: 'La tuile d\'un quiz',
          builder: (context) => QuizItem(
            quiz: quiz,
            showDetail: (String id) {},
          ),
        ),
        Story(
          name: 'Widgets/QuizDetail',
          description: 'Grande tuile de detail d\'un quiz',
          builder: (context) => DetailQuizItem(quiz: quiz),
        ),
        // Story(
        //   name: 'Widgets/StartButton',
        //   description: 'Bouton pour commencer un quiz',
        //   builder: (context) => StartButton(),
        // ),
        Story(
          name: 'Widgets/Question',
          description: 'Zone dédié à la question dans un quiz',
          builder: (context) =>
              QuestionQuiz(text: 'Quel est le surnom de Fabian Marti?'),
        ),
        Story(
          name: 'Widgets/Answer',
          description: 'Bouton re réponse à une question',
          builder: (context) => AnswerItem(
            text: 'Martin',
            isCorrectAnswer: false,
            click: () {},
          ),
        ),
        Story(
          name: 'Widgets/DetailQuizPage',
          description: 'Page de detail sur un quiz',
          builder: (context) => DetailQuizPage(),
        ),
        Story(
          name: 'Widgets/QuestionTitleItem',
          description: 'Forme la question',
          builder: (context) => QuestionTitleItem(question: quiz.questions[0]),
        ),
        Story(
          name: 'Widgets/QuestionPage',
          description: 'Page contanant la question',
          builder: (context) => QuestionPage(question: quiz.questions[0]),
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
          body: Container(
              color: Colors.black,
              child: Expanded(child: Center(child: child))),
        ),
      ),
    );
  }
}
