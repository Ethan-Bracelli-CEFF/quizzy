import 'package:flutter/material.dart';
import 'package:quiz_list/quiz_list.dart';

class CreateQuizScreen extends StatefulWidget {
  static const routeName = 'create_quiz';

  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 70, 70, 70),
        toolbarHeight: 70.0,
        centerTitle: true,
        title: Text(
          'Quizzy',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: FormQuiz(),
        ),
      ),
    );
  }
}
