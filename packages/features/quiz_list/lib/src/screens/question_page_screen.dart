import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';

class QuestionPageScreen extends StatefulWidget {
  static const routeName = 'question_page';

  const QuestionPageScreen({super.key});

  @override
  State<QuestionPageScreen> createState() => _QuestionPageScreenState();
}

class _QuestionPageScreenState extends State<QuestionPageScreen> {
  Widget body(Question question) {
    return Center(
      child: Text(
        question.title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final quiz = context.read<QuizListProvider>().findQuizById(id);
    final questions = quiz.questions;

    final question = questions[index];

    List<bool> correctAnswerList = [];

    for (int i = 0; i < question.answers.length; i++) {
      if (i == question.rightAnswer - 1) {
        correctAnswerList.add(true);
      } else {
        correctAnswerList.add(false);
      }
    }

    return Scaffold(
      appBar: AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuestionTitleItem(question: question),
            const SizedBox(height: 100),
            AnswerItem(
                text: question.answers[0],
                isCorrectAnswer: correctAnswerList[0],
                click: () {}),
            const SizedBox(height: 30),
            AnswerItem(
                text: question.answers[1],
                isCorrectAnswer: correctAnswerList[1],
                click: () {}),
            const SizedBox(height: 30),
            AnswerItem(
                text: question.answers[2],
                isCorrectAnswer: correctAnswerList[2],
                click: () {}),
            const SizedBox(height: 30),
            AnswerItem(
                text: question.answers[3],
                isCorrectAnswer: correctAnswerList[3],
                click: () {}),
            // ListView.separated(
            //   itemBuilder: (context, index) =>
            //       AnswerItem(text: question.answers[index]),
            //   separatorBuilder: (context, index) => const SizedBox(height: 30),
            //   itemCount: question.answers.length,
            // ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(70, 70, 70, 70),
        child: IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.arrow_forward,
            size: 24.0,
          ),
          onPressed: () => _nextQuestion(context, index),
        ),
      ),
    );
  }

  void _nextQuestion(BuildContext context, int index) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final quiz = context.read<QuizListProvider>().findQuizById(id);
    final questions = quiz.questions;

    // index += 1;

    if (index < questions.length) {
      setState(() {
        this.index += 1;
      });
    } else {
      // TODO : aller à la page de résultat
    }
  }
}
