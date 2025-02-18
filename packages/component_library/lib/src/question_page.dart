import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({required this.question, super.key});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                text: question.answers[0], isCorrectAnswer: true, click: () {}),
            const SizedBox(height: 30),
            AnswerItem(
                text: question.answers[1], isCorrectAnswer: true, click: () {}),
            const SizedBox(height: 30),
            AnswerItem(
                text: question.answers[2], isCorrectAnswer: true, click: () {}),
            const SizedBox(height: 30),
            AnswerItem(
                text: question.answers[3], isCorrectAnswer: true, click: () {}),
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
    );
  }
}
