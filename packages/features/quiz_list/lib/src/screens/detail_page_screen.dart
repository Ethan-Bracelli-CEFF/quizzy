import 'dart:math';

import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';

class DetailPageScreen extends StatefulWidget {
  static const routeName = 'detail_quiz';

  const DetailPageScreen({super.key});

  @override
  State<DetailPageScreen> createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  void _like(id) {
    context.read<UserListProvider>().addLike(null, id);
    final quiz = context.read<QuizListProvider>().findQuizById(id);

    for (String tag in quiz.tags) {
      context.read<UserListProvider>().addInterest(null, tag);
    }
  }

  void _dislike(id) {
    context.read<UserListProvider>().deleteLike(null, id);

    final quiz = context.read<QuizListProvider>().findQuizById(id);

    for (String tag in quiz.tags) {
      context.read<UserListProvider>().deleteInterest(null, tag);
    }
  }

  Widget body(Quiz quiz, int note, bool liked) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DetailQuizItem(
              quiz: quiz,
              note: note,
              liked: liked,
              onLike: (id) => _like(id),
              onDislike: (id) => _dislike(id),
            ),
            const SizedBox(height: 80),
            StartButton(
              click: () => _showQuestionPageScreen(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as List;
    final id = data[0] as String;
    final note = data[1] as int;
    final liked = data[2] as bool;
    final quiz = context.read<QuizListProvider>().findQuizById(id);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(70, 70, 70, 70),
        centerTitle: true,
        title: Text(
          'Quizzy',
          style: TextStyle(color: Colors.white, fontSize: 60),
        ),
      ),
      body: body(quiz, note, liked),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
    );
  }

  void _showQuestionPageScreen() {
    final data = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    final id = data[0];
    final quiz = context.read<QuizListProvider>().findQuizById(id);
    List<Question> questions = quiz.questions;
    int questionTotalCount = questions.length;
    final user = context.read<UserListProvider>().userState.user;
    final progress =
        context.read<UserListProvider>().getQuizProgression(quiz, user);

    if (progress != null) {
      context.read<QuizSeed>().seed = progress.seed;
    } else {
      context.read<QuizSeed>().seed = DateTime.now().millisecondsSinceEpoch;
      questions.shuffle(Random(context.read<QuizSeed>().seed));

      for (var question in questions) {
        question.answers.shuffle(Random(context.read<QuizSeed>().seed));
      }
    }

    int index;

    if (progress != null) {
      List<Question> newQuestions = questions;
      questions = [];
      for (int index = 0; index < newQuestions.length; index++) {
        if (index >= progress.index) {
          questions.add(newQuestions[index]);
        }
      }
      context.read<QuizPoints>().points = progress.point;
      index = progress.index;
    } else {
      context.read<QuizPoints>().points = 0;
      index = 0;
    }

    Navigator.of(context).pushReplacementNamed(QuestionPageScreen.routeName,
        arguments: [questions, id, index, questionTotalCount]);
  }
}
