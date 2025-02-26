import 'dart:math';

import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultatPageScreen extends StatefulWidget {
  static const routeName = 'resultat_screen';

  const ResultatPageScreen({super.key});

  @override
  State<ResultatPageScreen> createState() => _ResultatPageScreenState();
}

class _ResultatPageScreenState extends State<ResultatPageScreen> {
  @override
  Widget build(BuildContext context) {
    final questions =
        ModalRoute.of(context)?.settings.arguments as List<Question>;

    int score = context.read<QuizPoints>().points;

    double percentage = score / questions.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(70, 70, 70, 70),
        centerTitle: true,
        title: const Text(
          'Quizzy',
          style: TextStyle(color: Colors.white, fontSize: 60),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 200.0,
              lineWidth: 30.0,
              percent: percentage,
              center: Text(
                '${(percentage * 100).roundToDouble()}%',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              progressColor: Colors.green,
              backgroundColor: Colors.red,
            ),
            SizedBox(height: 50),
            Text(
              'Votre score : $score / ${questions.length}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27.0,
              ),
            ),
            SizedBox(height: 15),
            AchievementItem.fromPercentage(percentage, size: 100)
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(70, 70, 70, 70),
        child: IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.restart_alt,
            size: 40.0,
          ),
          onPressed: () => _retry(context, questions),
        ),
      ),
    );
  }

  void _retry(BuildContext context, List<Question> questions) {
    context.read<QuizSeed>().seed = DateTime.now().millisecondsSinceEpoch;

    questions.shuffle(Random(context.read<QuizSeed>().seed));

    for (var question in questions) {
      question.answers.shuffle(Random(context.read<QuizSeed>().seed));
    }

    Navigator.of(context).pushReplacementNamed(QuestionPageScreen.routeName,
        arguments: [questions, '']);
    context.read<QuizPoints>().points = 0;
  }
}
