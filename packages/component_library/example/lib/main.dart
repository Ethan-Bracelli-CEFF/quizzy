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
      category: "Culture G",
      id: 'Salam',
      questions: [
        Question(
          title:
              'D\'une manière très objective quel est le meilleurs cours du jeudi?',
          answers: [
            Response(text: 'Simon', correct: false),
            Response(text: 'Quentin', correct: true),
            Response(text: 'Martim', correct: false),
            Response(text: 'Fabian', correct: false),
          ],
        ),
        Question(
          title: 'Laquelle de ces personnes préfère le cours de mobile?',
          answers: [
            Response(text: 'Ewan', correct: false),
            Response(text: 'Quentin', correct: true),
            Response(text: 'Martim', correct: false),
            Response(text: 'Le Hockey', correct: false)
          ],
        ),
        Question(
          title: 'Qui a eu la meilleure note au cie 295?',
          answers: [
            Response(text: 'Le Hockey', correct: false),
            Response(text: 'Quentin', correct: true),
            Response(text: 'Ewan', correct: false),
            Response(text: 'Fabian', correct: true)
          ],
        ),
      ],
      tags: [
        "général",
        "culture",
        "test",
      ]);

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: 'Widgets/QuizItem',
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
        Story(
          name: 'Widgets/Answer',
          description: 'Bouton re réponse à une question',
          builder: (context) => AnswerItem(
            text: 'ICH-165 NoSQL',
            isCorrectAnswer: false,
            showAnswer: false,
            click: (index) {},
            index: 0,
          ),
        ),
        Story(
          name: 'Widgets/QuestionTitleItem',
          description: 'Forme la question',
          builder: (context) => Padding(
            padding: const EdgeInsets.all(17.0),
            child: QuestionTitleItem(question: quiz.questions[0]),
          ),
        ),
        Story(
          name: 'Widgets/SearchBar',
          description: 'Barre de recherche',
          builder: (context) => Padding(
            padding: const EdgeInsets.all(17.0),
            child: SearchsBar(click: (String value) {}),
          ),
        ),
        Story(
          name: 'Widgets/StartButton',
          description: 'Bouton pour démarrer un quiz',
          builder: (context) => StartButton(click: () {}),
        ),
        Story(
          name: 'Widgets/ProgressBar',
          description: 'Barre de progression d\'un quiz',
          builder: (context) => ProgressBar(
              points: context.knobs
                  .sliderInt(label: 'Nb de questions faites', max: 36, min: 0)),
        ),
        Story(
          name: 'Widgets/ResultCircle',
          description: 'Cercle du pourcentage de bonne réponses',
          builder: (context) => ResultCircle(
              points: context.knobs
                  .sliderInt(label: 'Nombre de points', max: 36, min: 0)),
        ),
      ],
      wrapperBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizzy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.black.withAlpha(100),
          ),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Container(color: Colors.black, child: Center(child: child)),
        ),
      ),
    );
  }
}
