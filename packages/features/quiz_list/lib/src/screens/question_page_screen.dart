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

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final quiz = context.read<QuizListProvider>().findQuizById(id);
    final questions = quiz.questions;
    final question = questions[0];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(70, 70, 70, 70),
        centerTitle: true,
        title: Text(
          'Quizzy',
          style: TextStyle(color: Colors.white, fontSize: 60),
        ),
      ),
      body: body(question),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
    );
  }
}
