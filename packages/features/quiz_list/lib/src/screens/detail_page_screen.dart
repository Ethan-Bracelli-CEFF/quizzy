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
  Widget body(Quiz quiz) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DetailQuizItem(quiz: quiz),
          const SizedBox(height: 100),
          StartButton(
            click: () => _showQuestionPageScreen(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
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
      body: body(quiz),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
    );
  }

  void _showQuestionPageScreen() {
    final id = ModalRoute.of(context)?.settings.arguments as String;

    context.read<QuizPoints>().points == 0;

    Navigator.of(context)
        .pushNamed(QuestionPageScreen.routeName, arguments: id);
  }
}
